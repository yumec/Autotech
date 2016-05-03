//
//  customNavigationController.m
//  Autotech-2
//
//  Created by Javier Jara on 5/13/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "customNavigationController.h"
#import "TicketsViewController.h"

@implementation customNavigationController 

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
	//if([[self.viewControllers lastObject] class] == [TicketsViewController class]){
       
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                               forView:[self view]
                                 cache:YES];
        UIViewController *viewController = [super popViewControllerAnimated:NO];
        
		[UIView commitAnimations];
        
		return viewController;

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
@end
