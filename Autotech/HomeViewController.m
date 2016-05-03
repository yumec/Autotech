//
//  HomeViewController.m
//  Autotech
//
//  Created by Javier Jara on 6/21/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "HomeViewController.h"


@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void) viewDidAppear:(BOOL)animated{
    
//	self.currentUserLabel.text = [NSString stringWithFormat:@"Current User: %@", u.name];
//	self.currentVersionLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

}

//- (void) viewWillAppear: (BOOL)animated {
// 
//}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
	
	if (!u)
	{		
		LogonViewController *logon = [[[LogonViewController alloc] init] autorelease];
		[logon setModalPresentationStyle:UIModalPresentationFullScreen];
        [logon setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [[self navigationController] presentViewController:logon animated:YES completion:nil];
		u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
	}
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    return YES;
}


@end
