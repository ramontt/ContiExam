//
//  GMapsViewController.m
//  ContiExam
//
//  Created by Ramón García on 6/7/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "GMapsViewController.h"

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
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"New Marker"
                                                     message:@"Enter Latitude & Longitude"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    UITextField* alertTextField1 = [alert textFieldAtIndex:0];
    alertTextField1.keyboardType = UIKeyboardTypeDecimalPad;
    alertTextField1.placeholder = @"Latitude";
    
    UITextField* alertTextField2 = [alert textFieldAtIndex:1];
    alertTextField2.keyboardType = UIKeyboardTypeDecimalPad;
    alertTextField2.placeholder = @"Longitude";
    alertTextField2.secureTextEntry = NO;
    
    [alert show];
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
        UITextField* latTxt = [alertView textFieldAtIndex:0];
        UITextField *lonTxt = [alertView textFieldAtIndex:1];
        
        double latitude = [latTxt.text doubleValue];
        double longitude = [lonTxt.text doubleValue];
        
        [self addNewMarkerAt:CLLocationCoordinate2DMake( latitude, longitude ) withTitle:@"New Title" andSnippet:@"New Snippet"];
    }
}
@end
