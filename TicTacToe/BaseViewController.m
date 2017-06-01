//
//  BaseViewController.m
//  TicTacToe
//
//  Created by Aman Agarwal on 02/05/17.
//  Copyright © 2017 Intrview. All rights reserved.
//

#import "BaseViewController.h"
#import "BoardCollectionViewCell.h"

@interface BaseViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation BaseViewController

//board
float board[3][3];


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCollectionView];
    _gameState = @"NOTSTARTED";
    _turnName = @"NO ONE";
    for(int i = 0;i < 3;i++)for(int j = 0;j < 3;j++)board[i][j] = -1;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureView];
}

bool helperValidateGameForWin(int x){
    //horizontal
    for(int i = 0;i < 3;i++){
        bool flag = true;
        for(int j = 0;j < 3;j++){
            if(board[i][j] != x){
                flag = false;
                break;
            }
        }
        if(flag)return true;
    }
    //vertical
    for(int i = 0;i < 3;i++){
        bool flag = true;
        for(int j = 0;j < 3;j++){
            if(board[j][i] != x){
                flag = false;
                break;
            }
        }
        if(flag)return true;
    }
    //daigonal
    if( (board[0][0] == x && board[1][1] == x && board[2][2] == x ) || (board[0][2] == x && board[1][1] == x && board[2][0] == x))return true;
    return false;
}

bool helperValidateGameForDraw(){
    bool flagBoard = true;
    //horizontal
    for(int i = 0;i < 3;i++){
        bool flagRow = false;
        int prev = -1;
        for(int j = 0;j < 3;j++){
            if(board[i][j] == -1)continue;
            else if(prev == -1 && board[i][j] != -1){
                prev = board[i][j];
            }
            else if(prev != -1 && board[i][j] != prev)flagRow = true;
        }
        flagBoard = (flagBoard && flagRow);
        if(!flagBoard)return flagBoard;
    }
    //vertical
    for(int i = 0;i < 3;i++){
        bool flagCol = false;
        int prev = -1;
        for(int j = 0;j < 3;j++){
            if(board[i][j] == -1)continue;
            else if(prev == -1 && board[i][j] != -1){
                prev = board[i][j];
            }
            else if(prev != -1 && board[i][j] != prev)flagCol = true;
        }
        flagBoard = (flagBoard && flagCol);
        if(!flagBoard)return flagBoard;
    }
    
    bool flagDiagonal = false;
    int prev = -1;
    //left diagonal
    for(int i = 0;i < 3;i++){
        if(board[i][i] == -1)continue;
        else if(prev == -1 && board[i][i] != -1){
            prev = board[i][i];
        }
        else if(prev != -1 && board[i][i] != prev)flagDiagonal = true;
    }
    flagBoard = (flagBoard && flagDiagonal);
    if(!flagBoard)return flagBoard;
    
    flagDiagonal = false;
    prev = -1;
    //right diagonal
    for(int i = 0;i < 3;i++){
        for(int j = 0;j < 3;j++){
            if(i+j == 2){
                if(board[i][i] == -1)continue;
                else if(prev == -1 && board[i][i] != -1){
                    prev = board[i][i];
                }
                else if(prev != -1 && board[i][i] != prev)flagDiagonal = true;
            }
        }
    }
    flagBoard = (flagBoard && flagDiagonal);
    return flagBoard;
}

//1 for player
//0 for computer
//-1 for continue;
//-2 for gameOver;
-(int)validateGame{
    //check if PLAYER won
    if(helperValidateGameForWin(1))return 1;
    if(helperValidateGameForWin(0))return 0;
    //check for draw
    if(helperValidateGameForDraw())return -2;
    return -1;
}

-(void)configureView{
    int result = [self validateGame];
    if(result == 1){
        [self.gameStateLabel setText:@"GAME WON BY PLAYER"];
        
        _gameState = @"GAME WON BY PLAYER";
        [self.gameButton setTitle:@"START NEW GAME" forState:UIControlStateNormal];
    }
    else if(result == 0){
        [self.gameStateLabel setText:@"GAME WON BY COMPUTER"];
        
        _gameState = @"GAME WON BY COMPUTER";
        [self.gameButton setTitle:@"START NEW GAME" forState:UIControlStateNormal];
    }
    else if(result == -2){
        [self.gameStateLabel setText:@"GAME DRAW"];
        
        _gameState = @"GAME DRAW";
        [self.gameButton setTitle:@"START NEW GAME" forState:UIControlStateNormal];
    }
    else{
        if([_turnName isEqualToString:@"NO ONE"])_turdLABEL.hidden = YES;
        else{
            _turdLABEL.hidden = NO;
            [_turdLABEL setText:_turnName];
        }
        [self.gameStateLabel setText:_gameState];
        if([_gameState isEqualToString:@"NOTSTARTED"]){
            [self.gameButton setTitle:@"START GAME" forState:UIControlStateNormal];
        }
        else{
            [self.gameButton setTitle:@"PAUSE GAME" forState:UIControlStateNormal];
        }
    }
}

-(void)setUpCollectionView{
    self.BoardCollectionView.delegate = self;
    self.BoardCollectionView.dataSource = self;
    [self registerNibs];
}

#pragma mark UICollectionViewDataSource Methods

- (void) registerNibs {
    [self.BoardCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BoardCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(BoardCollectionViewCell.class)];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BoardCollectionViewCell *cellView = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(BoardCollectionViewCell.class) forIndexPath:indexPath];
    int x = (int)[indexPath row]/3;
    int y = [indexPath row]%3;
    
    if(board[x][y] == -1)cellView.backgroundColor = [UIColor blackColor];
    if(board[x][y] == 1)cellView.backgroundColor = [UIColor redColor];
    if(board[x][y] == 0)cellView.backgroundColor = [UIColor greenColor];
    return cellView;
}

#pragma mark UICollectionViewDelegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if([_gameState isEqualToString:@"NOTSTARTED"] || [_gameState isEqualToString:@"GAME DRAW"] || [_gameState isEqualToString:@"GAME WON BY COMPUTER"] || [_gameState isEqualToString:@"GAME WON BY PLAYER"])return ;
    
    NSLog(@"collection view cell touched");
    //make move
    int x = (int)[indexPath row]/3;
    int y = [indexPath row]%3;
    
    //validate
    if(board[x][y] == -1){
        //valid move
        if([_turnName isEqualToString:@"PLAYER"]){
            board[x][y] = 1;
            _turnName = @"COMPUTER";
        }
        else if([_turnName isEqualToString:@"COMPUTER"]){
           board[x][y] = 0;
            _turnName = @"PLAYER";
        }
        [self configureView];
        [self.BoardCollectionView reloadData];
    }
    else{
        //discard move
    }
}

#pragma mark UICollectionViewFlowLayoutDelegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //SDINSTANT-609
    return CGSizeMake(50.0, 50.0);
}

- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath
               atScrollPosition:(UICollectionViewScrollPosition)scrollPosition
                       animated:(BOOL)animated{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)gameAction:(UIButton *)sender {

    if([_gameState isEqualToString:@"NOTSTARTED"]){
        _gameState = @"PLAYING";
        if([_turnName isEqualToString:@"NO ONE"])
            _turnName = @"PLAYER";
        self.turdLABEL.hidden = NO;
        [self configureView];
        [self.BoardCollectionView reloadData];
    }
    else if([_gameState isEqualToString:@"PLAYING"]){
        _gameState = @"NOTSTARTED";
        self.turdLABEL.hidden = YES;
        [self configureView];
        [self.BoardCollectionView reloadData];
    }
    else if([_gameState isEqualToString:@"GAME DRAW"] || [_gameState isEqualToString:@"GAME WON BY COMPUTER"] || [_gameState isEqualToString:@"GAME WON BY PLAYER"]){
        _gameState = @"NOTSTARTED";
        self.turdLABEL.hidden = YES;
        _turnName = @"NO ONE";
        for(int i = 0;i < 3;i++)for(int j = 0;j < 3;j++)board[i][j] = -1;
        [self configureView];
        [self.BoardCollectionView reloadData];
    }
}
@end
