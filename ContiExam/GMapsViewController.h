//
//  GMapsViewController.h
//  ContiExam
//
//  Created by Ramón García on 6/7/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface GMapsViewController : UIViewController <GMSMapViewDelegate, UITextFieldDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UIView *vMap;
@property double latitude;
@property double longitude;
@property NSString* markerDesc;

// Actions
- (IBAction)addMarkerPressed:(id)sender;

@end
