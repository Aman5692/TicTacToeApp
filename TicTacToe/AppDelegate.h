//
//  AppDelegate.h
//  TicTacToe
//
//  Created by Aman Agarwal on 02/05/17.
//  Copyright © 2017 Intrview. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

