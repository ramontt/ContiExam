//
//  BasePageViewController.m
//  ContiExam
//
//  Created by Ramón García on 5/31/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "BasePageViewController.h"

@interface BasePageViewController ()

@end

@implementation BasePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _introPageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IntroPageViewController"];
    
    _introPageVC.view.frame = CGRectMake(0, 72, self.view.frame.size.width, self.view.frame.size.height - 144);
    
    [self addChildViewController: _introPageVC];
    [self.view addSubview: _introPageVC.view];
    [_introPageVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSkipPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
