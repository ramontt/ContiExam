//
//  IntroPageViewController.h
//  ContiExam
//
//  Created by Ramón García on 5/31/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroPageViewController : UIPageViewController <UIPageViewControllerDataSource>

// Properties
@property (strong, nonatomic) NSArray* pageBtnSkipTexts;
@property (strong, nonatomic) NSArray* pageImageNames;
@property (strong, nonatomic) NSArray* pageTopTexts;
@property (strong, nonatomic) NSArray* pageTexts1;
@property (strong, nonatomic) NSArray* pageTexts2;

@end
