//
//  CentralBTViewController.h
//  ContiExam
//
//  Created by Ramón García on 6/7/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <MessageUI/MessageUI.h>

@interface CentralBTViewController : UIViewController<CBCentralManagerDelegate, CBPeripheralDelegate, MFMailComposeViewControllerDelegate>

// Members
@property (strong, nonatomic) CBCentralManager      *centralManager;
@property (strong, nonatomic) CBPeripheral          *discoveredPeripheral;
@property (strong, nonatomic) NSMutableData         *data;

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtDataReceived;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
