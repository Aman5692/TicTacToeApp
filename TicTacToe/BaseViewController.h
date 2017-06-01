//
//  BaseViewController.h
//  TicTacToe
//
//  Created by Aman Agarwal on 02/05/17.
//  Copyright © 2017 Intrview. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *turdLABEL;
@property (weak, nonatomic) IBOutlet UICollectionView *BoardCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *gameStateLabel;
@property (weak, nonatomic) IBOutlet UIButton *gameButton;
- (IBAction)gameAction:(UIButton *)sender;
@property (strong,atomic) NSString *gameState;
@property (strong,atomic) NSString *turnName;

@end
