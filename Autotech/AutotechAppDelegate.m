//
//  AutotechAppDelegate.m
//  Autotech
//
//  Created by Javier Jara on 5/20/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "AutotechAppDelegate.h"

@implementation AutotechAppDelegate


@synthesize window=_window;
@synthesize currentUser = _currentUser;

NSString *documentsDirectoryPath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    return path;
}

- (User *)currentUser
{
	if (_currentUser == nil)
	{
		NSString *path = (NSString *)documentsDirectoryPath();
		NSString *fullPath = [path stringByAppendingPathComponent:@"userinfo.plist"];
		NSDictionary *userinfo = [NSDictionary dictionaryWithContentsOfFile:fullPath];
		
		if (userinfo)
		{
            [self setCurrentUser:[User UserWithDictionary:userinfo]];
		}
	}
	return _currentUser;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window makeKeyAndVisible];
    [self checkForAppUpdate];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self checkForAppUpdate];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void) alertView: (UIAlertView *) alertView clickedButtonAtIndex: (NSInteger) buttonIndex 
{
	if (buttonIndex == 1)
	{
        NSString *address = @"itms-services://?action=download-manifest&url=https://iosinstalls.samtec.com/iOS/AutoTech.plist";
#ifdef IS_LOCAL
        address = @"itms-services://?action=download-manifest&url=http://prodext1/iOS/autoTechLocal.plist";
#elif IS_DEV
        address = @"itms-services://?action=download-manifest&url=https://iosinstallsdev.samtec.com/iOS/autoTechDev.plist";
#elif IS_TEST
        address = @"itms-services://?action=download-manifest&url=https://iosinstallstest.samtec.com/iOS/autoTechTest.plist";
#elif IS_STAG
        address = @"itms-services://?action=download-manifest&url=https://iosinstallsstage.samtec.com/iOS/autoTechStag.plist";
#endif
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
	}
}


#pragma mark - Programmer Options

- (void)checkForAppUpdate
{
    NSString *address = @"https://iosinstalls.samtec.com/autotech.plist";
#ifdef IS_LOCAL
    address = @"http://prodext1/iOS/autotechLocal.plist";
#elif IS_DEV
    address = @"https://iosinstallsdev.samtec.com/iOS/autotechDev.plist";
#elif IS_TEST
    address = @"https://iosinstallstest.samtec.com/iOS/autotechTest.plist";
#elif IS_STAG
    address = @"https://iosinstallsstage.samtec.com/iOS/autotechStag.plist";
#endif

    NSDictionary *plistdict = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:address]];
    NSString *serverVersionStr = [[[[plistdict valueForKey:@"items"] valueForKey:@"metadata"] objectAtIndex:0] valueForKey:@"bundle-version"];
    NSString *clientVersionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

    if ([clientVersionStr compare:serverVersionStr] != 0)
    {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Update Available"
                                   message: [NSString stringWithFormat:@"An update (version %@) to the Autotech is available. Would you like to install?", serverVersionStr]
                                  delegate: self
                         cancelButtonTitle: @"NO"
                         otherButtonTitles: @"YES", nil];
        [alert show];
        [alert release];
    }
    
}


@end
