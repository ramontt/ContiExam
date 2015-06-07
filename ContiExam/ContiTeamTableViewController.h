//
//  ContiTeamTableViewController.h
//  ContiExam
//
//  Created by Ramón García on 5/31/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddUserViewController.h"

@interface ContiTeamTableViewController : UITableViewController <AddUserControllerDelegate>

// Members
@property (nonatomic, strong) NSMutableArray *memberNames;
@property (nonatomic, strong) NSMutableArray *memberPhotos;
@property (nonatomic, strong) AddUserViewController* addUserVC;

// Outlets
@property (strong, nonatomic) IBOutlet UITableView *memberTbl;


// Actions
- (IBAction)addUserPressed:(id)sender;

@end
