//
//  AddUserViewController.m
//  ContiExam
//
//  Created by Ramón García on 6/5/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "AddUserViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Foundation/Foundation.h>

@interface AddUserViewController ()

@end

@implementation AddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [[self view] setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    
    // border radius
    [_popUpView.layer setCornerRadius: 10.0f];
    
//    [[_cancelButton layer] setBorderWidth:2.0f];
//    [[_cancelButton layer] setBorderColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
    
//    [[_okButton layer] setBorderWidth:2.0f];
//    [[_okButton layer] setBorderColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillShow:(NSNotification *)n
{
    NSLog( @"Keyboard will show ..." );
    
    // Animate the current view out of the way
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = _popUpView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - 129);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [_popUpView setFrame:viewFrame];
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)n
{
    NSLog( @"Keyboard will hide ..." );
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = _popUpView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - 129);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [_popUpView setFrame:viewFrame];
    [UIView commitAnimations];
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

- (IBAction)addPhotoPressed:(id)sender
{
    UIAlertController* view = [[UIAlertController alloc] init];
    
    UIAlertAction* useCamera =
        [UIAlertAction actionWithTitle:@"Use Camera"
                                 style: UIAlertActionStyleDefault
             handler:^(UIAlertAction * action)
             {
                 if ([UIImagePickerController isSourceTypeAvailable:
                      UIImagePickerControllerSourceTypeCamera])
                 {
                     UIImagePickerController *imagePicker    = [[UIImagePickerController alloc] init];
                     imagePicker.delegate                    = self;
                     imagePicker.sourceType                  = UIImagePickerControllerSourceTypeCamera;
                     imagePicker.mediaTypes                  = @[(NSString *) kUTTypeImage];
                     imagePicker.allowsEditing               = YES;
                     [self presentViewController:imagePicker animated:YES completion:nil];
                 }
                 
                 [view dismissViewControllerAnimated:YES completion:nil];
                 
             }];
    UIAlertAction* useLibrary =
        [UIAlertAction actionWithTitle:@"From Library"
                                 style:UIAlertActionStyleDefault
             handler:^(UIAlertAction * action)
             {
                 if ([UIImagePickerController isSourceTypeAvailable:
                      UIImagePickerControllerSourceTypeSavedPhotosAlbum])
                 {
                     UIImagePickerController *imagePicker    = [[UIImagePickerController alloc] init];
                     imagePicker.delegate                    = self;
                     imagePicker.sourceType                  = UIImagePickerControllerSourceTypePhotoLibrary;
                     imagePicker.mediaTypes                  = @[(NSString *) kUTTypeImage];
                     imagePicker.allowsEditing               = YES;
                     [self presentViewController:imagePicker animated:YES completion:nil];
                 }
                 
                 [view dismissViewControllerAnimated:YES completion:nil];
                 
             }];
    UIAlertAction* cancel =
        [UIAlertAction actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
             handler:^(UIAlertAction * action)
             {
                 [view dismissViewControllerAnimated:YES completion:nil];
                 
             }];
    
    
    [view addAction: useCamera];
    [view addAction: useLibrary];
    [view addAction: cancel];
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)okButtonPressed:(id)sender
{
    // Dismiss keyboard
    [self.view endEditing:YES];
    
    // Callback parent controller with new name and image
    [self.delegate addNewMemberWithName:_nameTxt.text andImage:_memberImg.image];
    
    _nameTxt.text = @"";
    _memberImg.image = nil;
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    // Dismiss keyboard
    [self.view endEditing:YES];
    
    _nameTxt.text = @"";
    _memberImg.image = nil;
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Image Picker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        CGFloat factor = 300.0f / image.size.height;
        
        _memberImg.image = [self imageWithImage: image scaledToSize: CGSizeMake( image.size.width * factor, image.size.height * factor)];
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
