//
//  ContiTeamTableViewController.h
//  ContiExam
//
//  Created by Ramón García on 5/31/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddUserViewController.h"

@interface ContiTeamTableViewController : UITableViewController

// Members
@property (nonatomic, strong) NSArray *memberNames;
@property (nonatomic, strong) NSArray *memberPhotos;
@property (strong, nonatomic) AddUserViewController* addUserVC;

// Actions
- (IBAction)addUserPressed:(id)sender;

@end
