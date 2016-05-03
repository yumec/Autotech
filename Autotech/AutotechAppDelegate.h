//
//  AutotechAppDelegate.h
//  Autotech
//
//  Created by Javier Jara on 5/20/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AutotechAppDelegate : NSObject <UIApplicationDelegate> {

    User *_currentUser;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) User *currentUser;

- (void)checkForAppUpdate;
NSString *documentsDirectoryPath();

@end
