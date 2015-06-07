//
//  ContiTeamTableViewController.h
//  ContiExam
//
//  Created by Ramón García on 5/31/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#define MEMBER_NAMES_KEY  @"MemberNamesKey"
#define IMAGE_COUNTER_KEY @"ImageCounterKey"

#define IMAGE_COUNTER_INIT_VALUE 1
#define IMAGE_PREFIX      @"memberPhoto"

#import <UIKit/UIKit.h>
#import "AddUserViewController.h"

@interface ContiTeamTableViewController : UITableViewController <AddUserControllerDelegate>

// Members
@property (nonatomic, strong) NSMutableArray *memberNames;
@property (nonatomic, strong) NSMutableArray *memberPhotos;
@property NSInteger imageCounter;
@property (nonatomic, strong) AddUserViewController* addUserVC;

// Outlets
@property (strong, nonatomic) IBOutlet UITableView *memberTbl;


// Actions
- (IBAction)addUserPressed:(id)sender;

@end
