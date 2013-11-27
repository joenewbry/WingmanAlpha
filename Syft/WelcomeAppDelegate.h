//
//  WelcomeAppDelegate.h
//  Syft
//
//  Created by Joe Newbry on 11/18/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "Constants.h"

@interface WelcomeAppDelegate : UIResponder <UIApplicationDelegate, CBCentralManagerDelegate, CBPeripheralManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) NSMutableArray *UUIDsOfMatches; // array of CBBUUIDs

@end
