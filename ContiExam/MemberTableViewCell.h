//
//  MemberTableViewCell.h
//  ContiExam
//
//  Created by Ramón García on 5/31/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberTableViewCell : UITableViewCell

// Outlets
@property (weak, nonatomic) IBOutlet UIImageView *imgMemberPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblMemberName;

@end
