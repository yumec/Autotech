//
//  LogonViewController.h
//  Autotech
//
//  Created by Javier Jara on 6/21/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "HomeViewController.h"
#import "LMBSlidingViewController.h"
#import "Constants.h"

#define kLoadDataNotification @"kLoadDataNotification"

@interface LogonViewController : UIViewController {
   	IBOutlet UITextField *pinNumberTextField;
	IBOutlet UITextField *netWorkNameTextField;
    UIButton *_logonButton;
	BOOL keyboardIsShown; 
    CGFloat animatedDistance;
}

@property (nonatomic, retain) IBOutlet UIButton *logonButton;

//#define kOFFSET_FOR_KEYBOARD 100

- (IBAction)logon;

@end
