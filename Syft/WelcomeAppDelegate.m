//
//  WelcomeAppDelegate.m
//  Syft
//
//  Created by Joe Newbry on 11/18/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import "WelcomeAppDelegate.h"
#import <TestFlightSDK/TestFlight.h>
#import <Parse/Parse.h>
#import <LookBack/LookBack.h>
//#import "Constants.h"

@implementation WelcomeAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    // setting default color scheme for application
    //[[UIApplication sharedApplication] keyWindow].tintColor = [UIColor myPopPurpleColor];

    // test flight for better user tracking
    [TestFlight takeOff:testFlight];

    // Lookback for user testing
    [LookBack setupWithAppToken:lookBackKey];
    [LookBack lookback].shakeToRecord = YES;

    // Initializing Parse
    //Register our parse app
    [Parse setApplicationId:appID
                  clientKey:clKey];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    // asking for permission to store datat
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];

    // setting up bluetooth central communication
    [self setupBluetoothCentral];
    [self startScanningForPeripharyDevices];

    // setting up bluetooth periphary communication
    [self setupBluetoothPeriphary];
    [self setupUUIDAndTreeOfServicesAndCharacteristics];
    // method above calls broadcasting method for new service


    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    NSLog(@"New device token");
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];
}

#pragma mark bluetooth central setup
- (void)setupBluetoothCentral
{
    if(!self.centralManager)
    {
        // Put on main queue so we can call UIAlertView from delegate callbacks.
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    [self centralManagerDidUpdateState:self.centralManager]; // Show initial state
}

- (void)startScanningForPeripharyDevices
{
    [self.centralManager scanForPeripheralsWithServices:self.UUIDsOfMatches options:nil];
}


#pragma mark bluetooth central delegate methods
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSString *stateString = nil;
    switch(self.centralManager.state)
    {
        case CBCentralManagerStateResetting: stateString = @"The connection with the system service was momentarily lost, update imminent."; break;
        case CBCentralManagerStateUnsupported: stateString = @"The platform doesn't support Bluetooth Low Energy."; break;
        case CBCentralManagerStateUnauthorized: stateString = @"The app is not authorized to use Bluetooth Low Energy."; break;
        case CBCentralManagerStatePoweredOff: stateString = @"Bluetooth is currently powered off, please turn bluetooth on to use this app."; break;
        case CBCentralManagerStatePoweredOn: stateString = @"Bluetooth is currently powered on and available to use."; break;
        default: stateString = @"State unknown, update imminent."; break;
    }
    UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Bluetooth State"
                                                     message:stateString delegate:nil
                                           cancelButtonTitle:@"Okay"
                                           otherButtonTitles:nil, nil];
    [alert show];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"%@ found! With RSSI: %@, and ad data: %@", peripheral.name, RSSI, advertisementData);
    [self.centralManager stopScan];
    NSLog(@"Stop scanning for devices");
}

#pragma mark bluetooth periphary setup
- (void)setupBluetoothPeriphary
{
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}

- (void)setupUUIDAndTreeOfServicesAndCharacteristics
{
    CBUUID *user1 = [CBUUID UUIDWithString:UUID_USER_1];

    NSData *userNSDataWithArray = [NSData dataWithData:[NSKeyedArchiver archivedDataWithRootObject:@[@0,@1,@2]]];

    /* Note: If you specify a value for the characteristic, the value is cached and its properties and permissions are set to be readable. Therefore, if you need the value of a characteristic to be writeable, or if you expect the value to change during the lifetime of the published service to which the characteristic belongs, you must specify the value to be nil. Following this approach ensures that the value is treated dynamically and requested by the peripheral manager whenever the peripheral manager receives a read or write request from a connected central.
     **/
    CBMutableCharacteristic *userBluetoothMatchingProfileCharacteristics = [[CBMutableCharacteristic alloc] initWithType:user1 properties:CBCharacteristicPropertyRead value:userNSDataWithArray permissions:CBAttributePermissionsReadable];

    CBMutableService *userBLEService = [[CBMutableService alloc] initWithType:user1 primary:YES];
    userBLEService.characteristics = @[userBluetoothMatchingProfileCharacteristics];

    [self.peripheralManager addService:userBLEService];
    [self startBraodcastingService:userBLEService];
}

- (void)startBraodcastingService: (CBMutableService *)service
{
    [self.peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[service.UUID] }];
    NSLog(@"Advertising first periphery");
}

#pragma mark bluetooth periphary deleage methods

- (void) peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSString *stateString = nil;
    switch(self.centralManager.state)
    {
        case CBCentralManagerStateResetting: stateString = @"The connection with the system service was momentarily lost, update imminent."; break;
        case CBCentralManagerStateUnsupported: stateString = @"The platform doesn't support Bluetooth Low Energy."; break;
        case CBCentralManagerStateUnauthorized: stateString = @"The app is not authorized to use Bluetooth Low Energy."; break;
        case CBCentralManagerStatePoweredOff: stateString = @"Bluetooth is currently powered off, please turn bluetooth on to use this app."; break;
        case CBCentralManagerStatePoweredOn: stateString = @"Bluetooth is currently powered on and available to use."; break;
        default: stateString = @"State unknown, update imminent."; break;
    }
    UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Bluetooth State"
                                                     message:stateString delegate:nil
                                           cancelButtonTitle:@"Okay"
                                           otherButtonTitles:nil, nil];
    [alert show];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    if (error) {
        NSLog(@"Error publishing service: %@", [error localizedDescription]);
    } else {
        NSLog(@"Periphary is ready to be broadcasted");
    }
}

# pragma mark handle push notifs when app is open
// handles push notifications that are recieved when the app is open
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
