//
//  SignUpViewController.h
//  Syft
//
//  Created by Joe Newbry on 11/21/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>

- (void)passUserObject:(NSMutableDictionary *)data;

@end
