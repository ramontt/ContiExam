//
//  AddUserViewController.h
//  ContiExam
//
//  Created by Ramón García on 6/5/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddUserViewController : UIViewController

// Outlets
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

// Actions
- (IBAction)okButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
