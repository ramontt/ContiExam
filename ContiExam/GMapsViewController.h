//
//  GMapsViewController.h
//  ContiExam
//
//  Created by Ramón García on 6/7/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface GMapsViewController : UIViewController <GMSMapViewDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UIView *vMap;

// Actions
- (IBAction)addMarkerPressed:(id)sender;

@end
