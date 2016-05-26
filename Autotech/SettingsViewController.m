//
//  SettingsViewController.m
//  Autotech
//
//  Created by Javier Jara on 6/23/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "AutotechAppDelegate.h"
#import "SortedTicketsViewController.h"
#import "ViewWithSearchBarViewController.h"

@implementation SettingsViewController

@synthesize logOffButton = _logOffButton, 
loginNameLabel = _loginNameLabel, 
techAreaLabel = _techAreaLabel,
popOverController = _popOverController,
ticketListTextField = _ticketListTextField,
clientVersionStr = _clientVersionStr;

@synthesize thePicker = _thePicker;
@synthesize techForUser = _techForUser;
@synthesize techs = _techs;
@synthesize techSwitch = _techSwitch;
@synthesize techLabel = _techLabel;

- (NSArray *) ticketLists 
{
    _ticketLists = [NSArray arrayWithObjects:@"Mold Process", @"HDR", @"Automation", @"CR Facilities", @"PN Handfill", @"PN 2nd Ops", @"PN Facilities", @"PN Automation", @"CR 1 Floor", @"CR HDR1", @"CR Automation", @"SME Tech Group", @"SME Engineering", nil];
    return _ticketLists;
}

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
    [_logOffButton release];
    [_loginNameLabel release];
    [_techAreaLabel release];
    [_clientVersionStr release];
    [_thePicker release];
    [_techForUser release];
    [_techs release];
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

- (void)viewWillAppear:(BOOL)animated{
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
//    self.ticketListTextField.text = u.techAreaDescription;
    self.loginNameLabel.text  = [NSString stringWithFormat:@"Logged As: %@", u.name];
    NSString *clientVersionStr  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    self.clientVersionStr.text = [NSString stringWithFormat:@"Version: %@", clientVersionStr];
    
    [self refreshTechs];
}

- (void) refreshTechs
{
    if (self.techSwitch.on) {
        self.techLabel.text = @"Select Tech Area:";
        [self loadTechs:0];
    } else
    {
        self.techLabel.text = @"Select Tech Associate:";
        [self loadTechs:1];
    }
}

- (void) loadTechs:(NSInteger)type
{
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
    
    [self.techs removeAllObjects];

    NSString *techAssociatesAddress = nil;
    
    if (type == 0) {
        techAssociatesAddress = [NSString stringWithFormat:@"http://%@/Techs.ashx?", ConnectionString];
    } else
    {
        techAssociatesAddress = [NSString stringWithFormat:@"http://%@/Techs.ashx?type=1", ConnectionString];
    }
    
    NSURL *techAssociatesUrl = [NSURL URLWithString:techAssociatesAddress];
    NSArray *techAssociatesResults = [NSArray arrayWithContentsOfURL:techAssociatesUrl];
    [self setTechs:[NSMutableArray arrayWithCapacity:[techAssociatesResults count]]];
    for (NSDictionary *t in techAssociatesResults) {
        [self.techs addObject:[Techs techWithDictionary:t]];
        if (u != nil && self.techForUser == nil && [[t valueForKey:@"techID"]isEqualToString:u.techID]) {
            self.techForUser = [Techs techWithDictionary:t];
            self.ticketListTextField.text = self.techForUser.techFullName;
        }
    }
    
    
    // Set default value to Mold Process
    if (self.techForUser == nil) {
        for (Techs *t in self.techs) {
            if ([[t valueForKey:@"techID"] isEqualToString:@"227"]) {
                self.techForUser = t;
            }
        }
    }
    
    u.techID = self.techForUser.techID;
    u.techName = self.techForUser.techFullName;
    u.plantID = self.techForUser.plantID;
    self.techAreaLabel.text = [NSString stringWithFormat:@"Tech Associates: %@", u.techName];
//    u.techAreaDescription = self.techForUser.techFullName;
    
    self.ticketListTextField.text = self.techForUser.techFullName;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    { 
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LogOffBackGround_iPad.png"]];
    }else
    {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LogOffBackGround_iPhone.png"]];
    }
    
    [self.logOffButton setBackgroundImage:[[UIImage imageNamed:@"iPhone_Orange_Button.png"]
                                          stretchableImageWithLeftCapWidth:8.0f
                                          topCapHeight:0.0f]
                                forState:UIControlStateNormal];
 
    [self.logOffButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //self.logonButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    // self.logonButton.titleLabel.shadowColor = [UIColor lightGrayColor];
    self.logOffButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    
    UIImageView * arrowImageView = [[UIImageView  alloc]  initWithImage :
                                       [UIImage  imageNamed:@"Arrow_Down.png" ]];
    [self.ticketListTextField setRightView: arrowImageView];
    [self.ticketListTextField setRightViewMode: UITextFieldViewModeAlways];
    [arrowImageView release ];
    
    self.techSwitch.thumbTintColor = [UIColor orangeColor];
    self.techSwitch.tintColor = [UIColor orangeColor];
    self.techSwitch.onTintColor = [UIColor orangeColor];
    
    if (self.techSwitch.on) {
        self.techLabel.text = @"Select Tech Area:";
    } else
    {
        self.techLabel.text = @"Select Tech Associate:";
    }
}


- (IBAction)techSwithClicked
{
    [self refreshTechs];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}


#pragma mark UITextField Delegate: 

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.ticketListTextField)
    {
//        [self showPicker:@"Ticket List" textFieldTag:textField.tag];
        [textField resignFirstResponder];
        ViewWithSearchBarViewController *aView = [[ViewWithSearchBarViewController alloc]initWithContent:self.techs AndSearchType:4 AndSearchView:3];
        [aView setSettingsViewController:self];
        [aView setModalPresentationStyle:UIModalPresentationFullScreen];
        [aView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:aView animated:YES completion:nil];
        [aView release];
        
    }
}


- (void) textFieldDidEndEditing:(UITextField *)textField{
    [super textFieldDidEndEditing:textField]; 
}


#pragma mark - UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self ticketLists] count]; 
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
        return [[self ticketLists] objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    self.ticketListTextField.text =  [[self ticketLists] objectAtIndex:row];
//    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
//    strTechArea = [self.ticketLists objectAtIndex:row];
//    u.techAreaDescription = strTechArea;
}


# pragma mark programmer methods 


-(IBAction) logOff {
    
    NSString *path = (NSString *)documentsDirectoryPath();
    NSString *fullPath = [path stringByAppendingPathComponent:@"userinfo.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fullPath error:NULL];
    [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] setCurrentUser:nil];

    self.tabBarController.selectedIndex = 0;
}


- (void) showPicker: (NSString *) title
       textFieldTag: (NSInteger) textFieldTag {
    // Add the picker
    
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    { 
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(10,60,300,180)];
        pickerView.tag = textFieldTag;
        pickerView.delegate = self;
        pickerView.showsSelectionIndicator = YES;    // note this is default to NO
        self.thePicker = pickerView;
        
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
                               initWithFrame:CGRectMake(0, 0, 768, 260)];
        popoverView.backgroundColor = [UIColor whiteColor];
        
        [popoverView addSubview:selectButton];
        [popoverView addSubview:pickerView]; 
        
        popoverContent.view = popoverView;
        
        //resize the popover view shown
        //in the current view to the view's size
//        popoverContent.contentSizeForViewInPopover = CGSizeMake(320, 260);
        popoverContent.preferredContentSize = CGSizeMake(320, 260);
        //create a popover controller
        UIPopoverController *popoverController = [[UIPopoverController alloc]
                                                  initWithContentViewController:popoverContent];
        self.popOverController = popoverController;
        //present the popover view non-modal with a
        //refrence to the button pressed within the current view
        CGRect locationRec; 
        locationRec = CGRectMake(0,0,700,360);
        [popoverController  presentPopoverFromRect:locationRec  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        //release the popover content
        [popoverView release];
        [popoverContent release]; 
        [pickerView release];
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
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
        pickerView.tag = textFieldTag;
        pickerView.delegate = self;
        self.thePicker = pickerView;
        pickerView.showsSelectionIndicator = YES;    // note this is default to NO
        [menu addSubview:pickerView];
       // [menu showInView:self.view];
        [menu showFromTabBar:self.tabBarController.tabBar];
        if ((self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
            (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)) {
            [menu setBounds:CGRectMake(0,0,480, 480)];
            
        } else {
            [menu setBounds:CGRectMake(0,0,320, 655)];
        }
        
        [pickerView release];
        [menu release];
        
    }
}

- (void) popSelection:(id) sender {
    [self selectedTechArea];
    [self.popOverController dismissPopoverAnimated:YES];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self selectedTechArea];
    }
}

- (void) selectedTechArea {
    User *u = [(AutotechAppDelegate *) [[UIApplication sharedApplication] delegate] currentUser];
    NSInteger row = [self.thePicker selectedRowInComponent:0];
    u.techName = [self.ticketLists objectAtIndex:row];
    self.ticketListTextField.text =  u.techName;
}

@end
