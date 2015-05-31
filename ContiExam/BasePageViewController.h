//
//  BasePageViewController.h
//  ContiExam
//
//  Created by Ramón García on 5/31/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePageViewController : UIViewController

// Properties
@property (strong, nonatomic) UIPageViewController* introPageVC;

// Actions
- (IBAction)btnSkipPressed:(id)sender;

@end
