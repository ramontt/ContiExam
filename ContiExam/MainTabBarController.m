//
//  MainTabBarController.m
//  ContiExam
//
//  Created by Ramón García on 5/30/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create page view controller
    _basePageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BasePageViewController"];
    
    _introShown = NO;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if( !_introShown )
    {
        [self presentViewController:_basePageVC animated:YES completion:nil];
        _introShown = YES;
    }
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

@end
