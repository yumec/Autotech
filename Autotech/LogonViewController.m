//
//  LogonViewController.m
//  Autotech
//
//  Created by Javier Jara on 6/21/11.
//  Copyright 2011 Samtec. All rights reserved.

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.15;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.85;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 122;
static const CGFloat Height = 50;

#import "LogonViewController.h"


@implementation LogonViewController

@synthesize logonButton = _logonButton;

- (id)init
{
	NSString *nibName = (UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) ? 
	@"LogonViewController_iPad" : 
	@"LogonViewController_iPhone";
	
	self = [super initWithNibName:nibName bundle:nil];
	
	return self;	
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(UIUserInterfaceIdiomPad != [[UIDevice currentDevice] userInterfaceIdiom]) 
    {
        CGRect textFieldRect =	[self.view.window convertRect:textField.bounds fromView:textField];
        CGRect viewRect =	[self.view.window convertRect:self.view.bounds fromView:self.view];
        
        if (orientation == UIInterfaceOrientationLandscapeLeft )
        {
            textFieldRect.origin.y = textFieldRect.origin.x - Height ; // Adding 50p because of the Navigation bar
            textFieldRect.size.height = textFieldRect.size.width - Height ;
            viewRect.size.height = viewRect.size.width  - Height;
            viewRect.origin.y = viewRect.origin.y + Height;
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight )
        {
            textFieldRect.origin.y = viewRect.size.width - textFieldRect.origin.x - Height; 
            textFieldRect.size.height = textFieldRect.size.width - Height;
            viewRect.size.height = viewRect.size.width - Height;
            viewRect.origin.y = viewRect.origin.y + Height;
        }
        else if (orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            textFieldRect.origin.y = viewRect.size.height - textFieldRect.origin.y;
        }    
        
        
        CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
        CGFloat numerator =	midline - viewRect.origin.y	- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
        CGFloat denominator =	(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)	* viewRect.size.height;
        
        CGFloat heightFraction = numerator / denominator;
        
        if (heightFraction < 0.0)
        {
            heightFraction = 0.0;
        }
        else if (heightFraction > 1.0)
        {
            heightFraction = 1.0;
        }
        
        
        if (orientation == UIInterfaceOrientationPortrait ||
            orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        }
        else
        {
            if (UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
                animatedDistance = floor((LANDSCAPE_KEYBOARD_HEIGHT + 200) * heightFraction);
            } else {
                animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
            } 
        }
        
        CGRect viewFrame = self.view.frame;
        if (orientation == UIInterfaceOrientationPortrait) {
            viewFrame.origin.y -= animatedDistance;
        } else {
            viewFrame.origin.y += animatedDistance;
        }
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [self.view setFrame:viewFrame];
        
        [UIView commitAnimations];
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(UIUserInterfaceIdiomPad != [[UIDevice currentDevice] userInterfaceIdiom]) 
    {
        CGRect viewFrame = self.view.frame;
        if (orientation == UIInterfaceOrientationPortrait) {
            viewFrame.origin.y += animatedDistance;
        } else {
            viewFrame.origin.y -= animatedDistance;
        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [self.view setFrame:viewFrame];
        
        [UIView commitAnimations];
    }
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField{
	//NSInteger nextTag = textField.tag + 1;
	// Try to find next responder
	UIResponder* nextResponder = nil;
	
	if (nextResponder) {
		// Found next responder, so set it.
		[nextResponder becomeFirstResponder];
	} else {
		// Not found, so remove keyboard.
		[textField resignFirstResponder];
	}
	
	return NO; 
}



- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    
    [self becomeFirstResponder];
    
    [self.logonButton setBackgroundImage:[[UIImage imageNamed:@"iPhone_Orange_Button.png"]
                                          stretchableImageWithLeftCapWidth:8.0f
                                          topCapHeight:0.0f]
                                forState:UIControlStateNormal];
    
    [self.logonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //self.logonButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
   // self.logonButton.titleLabel.shadowColor = [UIColor lightGrayColor];
    self.logonButton.titleLabel.shadowOffset = CGSizeMake(0, -1);

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


-(void) viewDidLoad {
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    { 
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LoginBackGround_Ipad.png"]];
    }else{
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LoginBackGround_iPhone.png"]];
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    //view to catch  tap
    UIView *view = [[UIView alloc] init];
    
    //leave the navigation bar alone
    view.frame = CGRectMake(0, 60, screenWidth, screenHeight-60);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [view addGestureRecognizer:tap];
    
    [self.view addSubview:view];
    [self.view sendSubviewToBack:view];
    
    [view release];

}
- (void)dealloc 
{
	[netWorkNameTextField release];
	[pinNumberTextField release];
    [_logonButton release];

    [super dealloc];
}

- (void)logon
{		
	NSString *address = [NSString stringWithFormat:@"http://%@/LogonValidateUser.ashx?userMasterId=%@&networkName=%@",ConnectionString, pinNumberTextField.text,netWorkNameTextField.text];

//    NSLog(@"%@", address);
    
	NSURL *url = [NSURL URLWithString:address];
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithContentsOfURL:url];
    if (result) {
//        if ([[result valueForKey:@"techAreaDescription"] isEqualToString:@""]) {
//            [result setValue:[NSString stringWithFormat:@"Mold Process"] forKey:@"techAreaDescription"];
//        }
		NSString *path = (NSString *) documentsDirectoryPath();
		NSString *fullPath = [path stringByAppendingPathComponent:@"userinfo.plist"];
        
		[result writeToFile:fullPath atomically:YES];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoadDataNotification
                                                            object:nil];
    } else {
		// Logon failed
		netWorkNameTextField.backgroundColor = [UIColor redColor];
		pinNumberTextField.backgroundColor = [UIColor redColor];
	}	
}

-(void)dismissKeyboard {
    
    if([pinNumberTextField isFirstResponder])[pinNumberTextField  resignFirstResponder];
    else if([netWorkNameTextField isFirstResponder])[netWorkNameTextField resignFirstResponder];
        
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}


@end
