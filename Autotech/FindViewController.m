//
//  FindViewController.m
//  Autotech
//
//  Created by hz-yumec-mac on 2/27/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import "FindViewController.h"
#import "ResultViewController.h"


@implementation FindViewController

@synthesize startDateTextField = _startDateTextField;
@synthesize endDateTextField = _endDateTextField;
@synthesize statusSwitch = _statusSwitch;
@synthesize report = _report;
@synthesize popOverController = _popOverController;
@synthesize datePicker = _datePicker;
@synthesize segmentControl = _segmentControl;
@synthesize searchByUserOptionView = _searchByUserOptionView;
@synthesize find = _find;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
    NSString *nibFile;
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
        nibFile = @"FindViewController_iPad";  
    }else {
        nibFile = @"FindViewController_iPhone";
    }
    
    [super  initWithNibName:nibFile bundle:nil];
    return self;
}

- (void)dealloc
{
    [_startDateTextField release];
    [_endDateTextField release];
    [_statusSwitch release];
//    [_reportForTech release];
    [_report release];
    [_popOverController release];
    [_datePicker release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{    
    [super viewDidLoad];
    
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
//    temporaryBarButtonItem.title = @"Report";
//    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
//    [temporaryBarButtonItem release];
    
    self.startDateTextField.tag = 1;
    self.endDateTextField.tag = 2;
    
    UIImageView * startDateArrowView = [[ UIImageView  alloc ]  initWithImage :
                                      [UIImage  imageNamed : @"Arrow_Down.png" ]]; 
    [self.startDateTextField setRightView: startDateArrowView];
    [self.startDateTextField setRightViewMode: UITextFieldViewModeAlways];
    [startDateArrowView release ];
    
    UIImageView * endDateArrowView = [[ UIImageView  alloc ]  initWithImage :
                                      [UIImage  imageNamed : @"Arrow_Down.png" ]]; 
    [self.endDateTextField setRightView: endDateArrowView];
    [self.endDateTextField setRightViewMode: UITextFieldViewModeAlways];
    [endDateArrowView release ];
    
    [self.find setBackgroundImage:[[UIImage imageNamed:@"iPhone_Orange_Button.png"]
                                              stretchableImageWithLeftCapWidth:8.0f
                                              topCapHeight:0.0f]
                                    forState:UIControlStateNormal];
    
    [self.find setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.find.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.find.titleLabel.shadowColor = [UIColor lightGrayColor];
    self.find.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    self.segmentControl.tintColor =[UIColor orangeColor];
    
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
//    self.view.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.0];
    [self.view sendSubviewToBack:view];
    
    [view release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (IBAction) searchReault
{
    [self.report removeAllObjects];
    ResultViewController *reportView = nil;
    
    if (self.segmentControl.selectedSegmentIndex == 0) {
        NSString *status;
        if (self.statusSwitch.on) {
            status = @"O"; // Open Tickets
        }  else {
            status = @"C"; // Closed Ticket;
        }
        NSString *techAssociatesTicketsReportAddress = [NSString stringWithFormat:@"http://%@/autotech/services/TicketsReport.ashx?startDate=%@&endDate=%@&option=%@", ConnectionString, self.startDateTextField.text, self.endDateTextField.text, status];
        NSURL *techAssociatesTicketsReportUrl = [NSURL URLWithString:techAssociatesTicketsReportAddress];
        NSArray *techAssociatesTicketsReportResults = [NSArray arrayWithContentsOfURL:techAssociatesTicketsReportUrl];
        [self setReport:[NSMutableArray arrayWithCapacity:[techAssociatesTicketsReportResults count]]];
        
        for (NSDictionary *t in techAssociatesTicketsReportResults)
        {
            [self.report addObject:[TechAssociatesTicketsReport TechAssociatesTicketsReportWithDictionary:t]];
        }
        reportView = [[ResultViewController alloc] initWithContent:self.report : @"User"];
        
    } else if(self.segmentControl.selectedSegmentIndex == 1) {
        NSString *address = [NSString stringWithFormat:@"http://%@/autotech/services/MachinesReport.ashx?startDate=%@&endDate=%@", ConnectionString, self.startDateTextField.text, self.endDateTextField.text];
        NSArray *result = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:address]];
        self.report = [NSMutableArray arrayWithCapacity:result.count];
        for (NSDictionary *d in result) {
            [self.report addObject:[MachinesReport MachinesReportWithDictionary:d]];
        }
        reportView = [[ResultViewController alloc] initWithContent:self.report : @"Machine"];
    }
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[self.navigationController view] cache:NO];
//    [self.navigationController pushViewController:reportView animated:YES];
//    [UIView commitAnimations];
    
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    [self.navigationController pushViewController:reportView animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [reportView release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        formatter.dateFormat = @"MM/dd/YYYY";
        if (actionSheet.tag == 1) {
            self.startDateTextField.text = [formatter stringFromDate:self.datePicker.date];
        } else {
            self.endDateTextField.text = [formatter stringFromDate:self.datePicker.date];
        }
    } else {
        [self resignFirstResponder];
    }
}

- (void) popSelection:(id) sender
{
    NSInteger tid = ((UIControl*)sender).tag;
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"MM/dd/YYYY";
    if (tid == 1) {
        self.startDateTextField.text = [formatter stringFromDate:self.datePicker.date];
    } else {
        self.endDateTextField.text = [formatter stringFromDate:self.datePicker.date];
    }
    [self.popOverController dismissPopoverAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField 
{
    switch (textField.tag) {
        case 1:
            [self showPicker:@"Select Start Date" textFieldTag:textField.tag];
            [self.startDateTextField resignFirstResponder];
            break;
        case 2:
            [self showPicker:@"Select End Date" textFieldTag:textField.tag];
            [self.endDateTextField resignFirstResponder];
            break;   
        default:
            [super textFieldDidBeginEditing:textField];
            break;
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [super textFieldDidEndEditing:textField]; 
}

- (void) showPicker: (NSString *) title
       textFieldTag: (NSInteger) textFieldTag {
    // Add the picker
    
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    {
        CGRect pickerFrame = CGRectMake(10, 60, 300, 180);
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.tag = textFieldTag;
        self.datePicker = datePicker;
        
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        selectButton.tag = textFieldTag;
        
        [selectButton addTarget:self 
                         action:@selector(popSelection:)      
               forControlEvents:UIControlEventTouchDown];
        
        [selectButton setTitle:@"Select" forState:UIControlStateNormal];
        
        selectButton.frame = CGRectMake(10.0, 10.0, 300.0, 40.0);
        
        
        [selectButton setBackgroundImage:[[UIImage imageNamed:@"iPhone_Orange_Button.png"]
                                          stretchableImageWithLeftCapWidth:8.0f
                                          topCapHeight:0.0f]
                                forState:UIControlStateNormal];
        
        [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selectButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        selectButton.titleLabel.shadowColor = [UIColor lightGrayColor];
        selectButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
        
        
        UIViewController* popoverContent = [[UIViewController alloc]
                                            init];
        UIView* popoverView = [[UIView alloc]
                               initWithFrame:CGRectMake(0, 0, 768, 330)];
        popoverView.backgroundColor = [UIColor whiteColor];
        
        
        [popoverView addSubview:selectButton];
        [popoverView addSubview:self.datePicker]; 
        
        popoverContent.view = popoverView;
        
        //resize the popover view shown
        //in the current view to the view's size
        popoverContent.preferredContentSize = CGSizeMake(320, 260);
        
        //create a popover controller
        UIPopoverController *popoverController = [[UIPopoverController alloc]
                                                  initWithContentViewController:popoverContent];
        self.popOverController = popoverController;
        //present the popover view non-modal with a
        //refrence to the button pressed within the current view
        CGRect locationRec; 
        switch (textFieldTag) {
            case 1: // Tech Associate
                locationRec = CGRectMake(0,0,768,80);
                break;
            case 2: // Machine 
                locationRec = CGRectMake(0,0,768,120);
                break;
            default:
                break;
        }
        [popoverController  presentPopoverFromRect:locationRec  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        //release the popover content
        [popoverView release];
        [popoverContent release]; 
        [datePicker release];
        [popoverController release];
    }else
    {
        UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:title 
                                                          delegate:self
                                                 cancelButtonTitle:@"Select"
                                            destructiveButtonTitle:@"Cancel"
                                                 otherButtonTitles:nil];
        menu.tag = textFieldTag;
        CGRect pickerFrame; 
        if ((self.interfaceOrientation == UIInterfaceOrientationPortrait) || (self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {
            pickerFrame = CGRectMake(0, 185, 0, 0);
        } else {
            pickerFrame = CGRectMake(0,185,480,200);
        }
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.tag = textFieldTag;
        self.datePicker = datePicker;
        
        [menu addSubview:self.datePicker];
        [datePicker release];
        [menu showFromTabBar:self.tabBarController.tabBar];
        
        if ((self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
            (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)) {
            [menu setBounds:CGRectMake(0,0,480, 480)];
            
        } else {
            [menu setBounds:CGRectMake(0,0,320, 655)];
        }
        [menu release];
    }
}

-(void)dismissKeyboard
{
    if ([self.startDateTextField isFirstResponder]) {
        [self.startDateTextField resignFirstResponder];
    }
    if ([self.endDateTextField isFirstResponder]) {
        [self.endDateTextField resignFirstResponder];
    }
}

- (IBAction)selectSearchOption:(id)sender
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    pulseAnimation.duration = 0.8;
    pulseAnimation.autoreverses = NO;
    if (self.segmentControl.selectedSegmentIndex == 0) { // Search By User
        pulseAnimation.fromValue = [NSNumber numberWithFloat:0.0];
        pulseAnimation.toValue = [NSNumber numberWithFloat:1.0];
        self.searchByUserOptionView.alpha = 1.0;
        [self.searchByUserOptionView.layer addAnimation:pulseAnimation forKey:@"SelectAnimation"];
    } else if (self.segmentControl.selectedSegmentIndex == 1) { // Search By Machine
        pulseAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        pulseAnimation.toValue = [NSNumber numberWithFloat:0.0];
        self.searchByUserOptionView.alpha = 0;
        [self.searchByUserOptionView.layer addAnimation:pulseAnimation forKey:@"SelectAnimation"];
    }
}

@end
