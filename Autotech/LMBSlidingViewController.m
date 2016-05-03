


#import "LMBSlidingViewController.h"

@implementation LMBSlidingViewController


#pragma mark -
#pragma mark Constants declaration

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.15;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.85;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 122;
static const CGFloat Height = 50;

#pragma mark -
#pragma mark Normal life cycle

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Sliding Views implementation [UITextFieldDelegate implementation]

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
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField{

   if(UIUserInterfaceIdiomPad != [[UIDevice currentDevice] userInterfaceIdiom]) 
    {
	CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
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


# pragma mark -- UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//    if(UIUserInterfaceIdiomPad != [[UIDevice currentDevice] userInterfaceIdiom] 
//       || (orientation != UIInterfaceOrientationPortrait && orientation !=  UIInterfaceOrientationPortraitUpsideDown)) {

	CGRect textFieldRect =	[self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect = 	[self.view.window convertRect:self.view.bounds fromView:self.view];
	
        if (orientation == UIInterfaceOrientationLandscapeLeft )
        {
            textFieldRect.origin.y = textFieldRect.origin.x - Height; // Adding 50p because of the Navigation bar
            textFieldRect.size.height = textFieldRect.size.width - Height;
            viewRect.size.height = viewRect.size.width - Height;
//            viewRect.origin.y = viewRect.origin.y + Height;
        }
        else  if (orientation == UIInterfaceOrientationLandscapeRight )
        {
            textFieldRect.origin.y =viewRect.size.width - textFieldRect.origin.x - Height; 
            textFieldRect.size.height = textFieldRect.size.width - Height;
            viewRect.size.height = viewRect.size.width - Height;
//            viewRect.origin.y = viewRect.origin.y + Height - 40;
        }
        else   if (orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            textFieldRect.origin.y = viewRect.size.height - textFieldRect.origin.y;
        }    

	CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
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
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];

}


- (void) textViewDidEndEditing:(UITextView *)textView{
    //UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

   // if(UIUserInterfaceIdiomPad != [[UIDevice currentDevice] userInterfaceIdiom] 
   //    || (orientation != UIInterfaceOrientationPortrait && orientation !=  UIInterfaceOrientationPortraitUpsideDown)) 
    {
	CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
