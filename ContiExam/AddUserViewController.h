//
//  AddUserViewController.h
//  ContiExam
//
//  Created by Ramón García on 6/5/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddUserControllerDelegate <NSObject>
- (void)addNewMemberWithName:(NSString*)name andImage:(UIImage*)image;
@end

@interface AddUserViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *memberImg;
@property (weak, nonatomic) id <AddUserControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *popUpView;


// Actions
- (IBAction)addPhotoPressed:(id)sender;
- (IBAction)okButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
