//
//  GMapsViewController.m
//  ContiExam
//
//  Created by Ramón García on 6/7/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "GMapsViewController.h"

typedef enum : NSUInteger {
    NoTextField = 0,
    LatitudeTextField,
    LongitudeTextField,
    MarkerDescTextField,
} NewMarkerTextFields;

@interface GMapsViewController ()

@end

@implementation GMapsViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
//                                                            longitude:151.20
//                                                                 zoom:6];
//    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    mapView_.myLocationEnabled = YES;
//    self.view = mapView_;
//    
//    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView_;

    // Maps
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: -33.86
                                                            longitude: 151.20
                                                                 zoom: 6];
    mapView_                    = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled  = YES;
    mapView_.frame              = CGRectMake(0, 0, self.vMap.frame.size.width, self.vMap.frame.size.height);
    
    // Creates a marker in the center of the map.
    [self addNewMarkerAt:CLLocationCoordinate2DMake(-33.86, 151.20) withTitle:@"Continental Automotive" andSnippet:@"Tlaquepaque"];
    
    [self.vMap addSubview:mapView_];
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

- (IBAction)addMarkerPressed:(id)sender
{
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"New Marker"
//                                                     message:@"Enter Latitude & Longitude"
//                                                    delegate:self
//                                           cancelButtonTitle:@"Cancel"
//                                           otherButtonTitles:@"OK", nil];
//    
//    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
//    UITextField* alertTextField1 = [alert textFieldAtIndex:0];
//    alertTextField1.keyboardType = UIKeyboardTypeDecimalPad;
//    alertTextField1.placeholder = @"Latitude";
//    
//    UITextField* alertTextField2 = [alert textFieldAtIndex:1];
//    alertTextField2.keyboardType = UIKeyboardTypeDecimalPad;
//    alertTextField2.placeholder = @"Longitude";
//    alertTextField2.secureTextEntry = NO;
//    
//    [alert show];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10,0,252,25)];
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField1.placeholder = @"Latitude";
    textField1.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField1.delegate = self;
    textField1.tag = LatitudeTextField;
    [v addSubview:textField1];
    
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10,30,252,25)];
    textField2.placeholder = @"Longitude";
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField2.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField2.delegate = self;
    textField2.tag = LongitudeTextField;
    [v addSubview:textField2];
    
    
    UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(10,60,252,25)];
    textField3.placeholder = @"Marker Description";
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    textField3.keyboardType = UIKeyboardTypeDefault;
    textField3.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField3.delegate = self;
    textField3.tag = MarkerDescTextField;
    [v addSubview:textField3];
    
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"New Marker" message:@"Enter Latitude & Longitude" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [av setValue:v  forKey:@"accessoryView"];
    [av show];
}

- (void) addNewMarkerAt: (CLLocationCoordinate2D)coord withTitle: (NSString*) title andSnippet: (NSString*) snippet
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = coord;
    marker.title = title;
    marker.snippet = snippet;
    marker.map = mapView_;
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSLog( @"Will add new marker ..." );
        
        [self addNewMarkerAt:CLLocationCoordinate2DMake( _latitude, _longitude ) withTitle:_markerDesc andSnippet:@""];
    }
}

#pragma mark - Text Field Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch( textField.tag )
    {
        case LatitudeTextField:
        {
            NSLog(@"Latitude [%@]", textField.text);
            _latitude = [textField.text doubleValue];
            break;
        }
        case LongitudeTextField:
        {
            NSLog(@"Longitud [%@]", textField.text);
            _longitude= [textField.text doubleValue];
            break;
        }
        case MarkerDescTextField:
        {
            NSLog(@"Marker Description [%@]", textField.text);
            _markerDesc = textField.text;
            break;
        }
        default:
        {
            break;
        }
    }
}

@end
