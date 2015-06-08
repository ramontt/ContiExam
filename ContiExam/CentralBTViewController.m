//
//  CentralBTViewController.m
//  ContiExam
//
//  Created by Ramón García on 6/7/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "CentralBTViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

#define TRANSFER_SERVICE_UUID           @"ADFD9852-838F-44E2-853A-C4AFEE4FC59F"
#define TRANSFER_CHARACTERISTIC_UUID    @"096DFB42-C2AC-4979-BBB5-FFFD51F843A4"


@interface CentralBTViewController ()

@end

@implementation CentralBTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // And somewhere to store the incoming data
    self.data = [[NSMutableData alloc] init];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    // Reset texts
    _lblStatus.text = @"Waiting for Bluetooth data ...";
    _txtDataReceived.text = @"";
    
    // Start activity indicator
    [_activityIndicator startAnimating];
    
    // Start up the CBCentralManager
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
    // Don't keep it going while we're not showing.
    [self.centralManager stopScan];
    NSLog(@"Scanning stopped");
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utileries

-(void) parseData: (NSString*) data
{
    NSArray *stringArray = [data componentsSeparatedByString: @"|"];
    NSString* textToSend = ( [stringArray count] >= 1 ) ? [stringArray objectAtIndex: 0] : @"";
    
    // Extract message & command
    _lblStatus.text = @"Bluetooth data received!";
    
    // Stop activity indicator
    [_activityIndicator stopAnimating];
    
    if( [stringArray count] >= 2 )
    {
        NSString* cmd = [stringArray objectAtIndex: 1];
        cmd = [cmd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // Facebook
        if( [cmd isEqualToString:@"FB"] )
        {
            NSLog( @"Send message through Facebook" );
            if([SLComposeViewController isAvailableForServiceType: SLServiceTypeFacebook] )
            {
                SLComposeViewController* fvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

                [fvc setTitle:@"FB BT Post"];
                [fvc setInitialText: textToSend];
                //[fvc addImage:[UIImage imageNamed:@"Conti"]];
                [self presentViewController:fvc animated:YES completion:nil];
            }
        }
        // Twitter
        else if( [cmd isEqualToString:@"TW"] )
        {
            NSLog( @"Send message through Twitter" );
            if([SLComposeViewController isAvailableForServiceType: SLServiceTypeTwitter] )
            {
                SLComposeViewController* fvc = [SLComposeViewController composeViewControllerForServiceType: SLServiceTypeTwitter];
                
                [fvc setTitle:@"TW BT Post"];
                [fvc setInitialText: textToSend];

                [self presentViewController:fvc animated:YES completion:nil];
            }
        }
        // Email
        else if( [cmd isEqualToString:@"EMAIL"] )
        {
            NSLog( @"Send message through E-Mail" );
            // Email subject
            NSString * subject = @"EMAIL BT";
            // Email body
            NSString * body = textToSend;
            //recipient(s)
            NSArray * recipients = [NSArray arrayWithObjects:@"ramon_tt@hotmail.com", nil];
            
            // Create the MFMailComposeViewController
            MFMailComposeViewController * composer = [[MFMailComposeViewController alloc] init];
            composer.mailComposeDelegate = self;
            [composer setSubject:subject];
            [composer setMessageBody:body isHTML: NO];
            [composer setToRecipients:recipients];
            
            //present it on the screen
            [self presentViewController:composer animated:YES completion:NULL];
        }
        // Unknwokn command
        else
        {

        }
    }
}

#pragma mark - MF Mail Compose Delegate

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled"); break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved"); break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent"); break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]); break;
        default:
            break;
    }
    
    // close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - CB Central Manager Delegate

// centralManagerDidUpdateState is a required protocol method.
// Usually, you'd check for other states to make sure the current device supports LE, is powered on, etc.
// In this instance, we're just using it to wait for CBCentralManagerStatePoweredOn, which indicates
// the Central is ready to be used.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"centralManagerDidUpdateState");
    if (central.state != CBCentralManagerStatePoweredOn) {
        // In a real app, you'd deal with all the states correctly
        return;
    }
    // The state must be CBCentralManagerStatePoweredOn...
    // Start scanning
    [self scan];
}

- (void)scan
{
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]
                                                options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    NSLog(@"Scanning started");
}

// This callback comes whenever a peripheral that is advertising the TRANSFER_SERVICE_UUID is discovered.
// We check the RSSI, to make sure it's close enough that we're interested in it, and if it is,
// we start the connection process.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    // Reject any where the value is above reasonable range
    if (RSSI.integerValue > -15) {
        return;
    }
    // Reject if the signal strength is too low to be close enough (Close is around -22dB)
    if (RSSI.integerValue < -35) {
        return;
    }
    NSLog(@"Discovered %@ at %@", peripheral.name, RSSI);
    
    // Ok, it's in range - have we already seen it?
    if (self.discoveredPeripheral != peripheral) {
        // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
        self.discoveredPeripheral = peripheral;
        
        // And connect
        NSLog(@"Connecting to peripheral %@", peripheral);
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

// If the connection fails for whatever reason, we need to deal with it.
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Failed to connect to %@. (%@)", peripheral, [error localizedDescription]);
    [self cleanup];
}

// We've connected to the peripheral, now we need to discover the services and characteristics to find the 'transfer' characteristic.
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Peripheral Connected");
    // Stop scanning
    [self.centralManager stopScan];
    NSLog(@"Scanning stopped");
    
    // Clear the data that we may already have
    [self.data setLength:0];
    
    // Make sure we get the discovery callbacks
    peripheral.delegate = self;
    
    // Search only for services that match our UUID
    [peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
}

// The Transfer Service was discovered
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"didDiscoverServices");
    if (error) {
        NSLog(@"Error discovering services: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    // Discover the characteristic we want...
    // Loop through the newly filled peripheral.services array, just in case there's more than one.
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:service];
    }
}

// The Transfer characteristic was discovered.
// Once this has been found, we want to subscribe to it, which lets the peripheral know we want the data it contains
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"didDiscoverCharacteristicsForService");
    // Deal with errors (if any)
    if (error) {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    
    // Again, we loop through the array, just in case.
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        // And check if it's the right one
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
            
            // If it is, subscribe to it
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
    // Once this is complete, we just need to wait for the data to come in.
}

// This callback lets us know more data has arrived via notification on the characteristic.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didUpdateValueForCharacteristic");
    if (error) {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        return;
    }
    NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    // Have we got everything we need?
    if ([stringFromData isEqualToString:@"EOM"]) {
        
        // We have, so show the data,
        NSString* data = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
        [_txtDataReceived setText: data];
        
        // Parse data & command
        [self parseData: data];
        
        // Cancel our subscription to the characteristic
        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
        
        // and disconnect from the peripehral
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
    // Otherwise, just add the data on to what we already have
    [self.data appendData:characteristic.value];
    NSLog(@"Received: %@", stringFromData);
}

// The peripheral letting us know whether our subscribe/unsubscribe happened or not
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didUpdateNotificationStateForCharacteristic");
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    // Exit if it's not the transfer characteristic
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    
    // Notification has started
    if (characteristic.isNotifying) {
        NSLog(@"Notification began on %@", characteristic);
    }
    
    // Notification has stopped
    else {
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
}

// Once the disconnection happens, we need to clean up our local copy of the peripheral
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Peripheral Disconnected");
    self.discoveredPeripheral = nil;
    
    // We're disconnected, so start scanning again
    [self scan];
}

// Call this when things either go wrong, or you're done with the connection.
// This cancels any subscriptions if there are any, or straight disconnects if not.
// (didUpdateNotificationStateForCharacteristic will cancel the connection if a subscription is involved)
- (void)cleanup
{
    NSLog(@"cleanup");
    // Don't do anything if we're not connected
    if (self.discoveredPeripheral.state != CBPeripheralStateConnected) {
        return;
    }
    
    // See if we are subscribed to a characteristic on the peripheral
    if (self.discoveredPeripheral.services != nil) {
        for (CBService *service in self.discoveredPeripheral.services) {
            if (service.characteristics != nil) {
                for (CBCharacteristic *characteristic in service.characteristics) {
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
                        if (characteristic.isNotifying) {
                            // It is notifying, so unsubscribe
                            [self.discoveredPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                            
                            // And we're done.
                            return;
                        }
                    }
                }
            }
        }
    }
    
    // If we've got this far, we're connected, but we're not subscribed, so we just disconnect
    [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
}

@end
