//
//  MainTabBarController.h
//  ContiExam
//
//  Created by Ramón García on 5/30/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController

// Outlets

// Members
@property (strong, nonatomic) UIPageViewController* basePageVC;
@property BOOL introShown;

@end
