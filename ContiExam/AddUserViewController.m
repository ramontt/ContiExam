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

- (IBAction)addPhotoPressed:(id)sender
{
    UIAlertController* view = [[UIAlertController alloc] init];
    //[UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle: UIAlertControllerStyleActionSheet];
    
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
    [self.delegate addNewMemberWithName:_nameTxt.text andImage:_memberImg.image];
    _memberImg.image = nil;
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    _memberImg.image = nil;
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Image Picker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        _memberImg.image = image;
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
