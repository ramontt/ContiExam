//
//  AddUserViewController.m
//  ContiExam
//
//  Created by Ramón García on 6/5/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "AddUserViewController.h"

@interface AddUserViewController ()

@end

@implementation AddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [[self view] setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    
    [[_cancelButton layer] setBorderWidth:2.0f];
    [[_cancelButton layer] setBorderColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
    
    [[_okButton layer] setBorderWidth:2.0f];
    [[_okButton layer] setBorderColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
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

- (IBAction)okButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
