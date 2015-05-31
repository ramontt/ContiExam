//
//  PageContentViewController.h
//  ContiExam
//
//  Created by Ramón García on 5/30/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *lblTopLine;
@property (weak, nonatomic) IBOutlet UILabel *lblText1;
@property (weak, nonatomic) IBOutlet UILabel *lblText2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

// Members
@property NSString* topLine;
@property NSString* textLine1;
@property NSString* textLine2;
@property NSString* btnSkipText;
@property NSString* imgFile;
@property NSInteger pageIndex;

@end
