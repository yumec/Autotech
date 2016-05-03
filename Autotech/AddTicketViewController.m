//
//  AddTicketViewController.m
//  Autotech
//
//  Created by Javier Jara on 6/7/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "AddTicketViewController.h"
#import "ViewWithSearchBarViewController.h"
#import "SearchUsersViewController.h"
#import "SelectPartDescViewController.h"
#import "NSString+URLEscapes.h"

@implementation AddTicketViewController

@synthesize scrollView = _scrollView, 
techAssociateTextField = _techAssociateTextField,
machineTextField = _machineTextField,
techForTicket = _techForTicket,
machineForTicket = _machineForTicket,
machines = _machines,
techs = _techs,
categoryForTicket = _categoryForTicket,
categories = _categories,
categoryTextField = _categoryTextField, 
locationTextField = _locationTextField,
locationForTicket = _locationForTicket,
locations = _locations,
userForTicket = _userForTicket,
issueDescriptionTextView = _issueDescriptionTextView, 
orderNumberTextField = _orderNumberTextField,
lineNumberTextField = _lineNumberTextField, 
opIdTextField = _opIdTextField, 
partDescTextField = _partDescTextField, 
addTicketButton = _addTicketButton, 
popOverController = _popOverController,
ID = _ID, 
parentTickets = _parentTickets,
ticket = _ticket;

@synthesize selectPartDescButton = _selectPartDescButton;
@synthesize spinner = _spinner;
@synthesize didSelectedMachine = _didSelectedMachine;
@synthesize didSelectedTech = _didSelectedTech;
@synthesize likePartTextField = _likePartTextField;

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
    [_scrollView release];
    [_techAssociateTextField release];
    [_machineTextField release];
    [_techForTicket release];
    [_machineForTicket release];
    [_machines release];
    [_techs release];
    [_categoryForTicket release];
    [_categories release];
    [_categoryTextField release];
    [_locations release];
    [_locationForTicket release];
    [_locationTextField release];
    [_userForTicket release];
    [_issueDescriptionTextView release];
    [_orderNumberTextField release];
    [_lineNumberTextField release];
    [_opIdTextField release];
    [_partDescTextField release];
    [_addTicketButton release];
    [_popOverController release];
    [_selectPartDescButton release];
    [_spinner release];
    [_ID release];
    [_parentTickets release];
    [_ticket release];
    [_likePartTextField release];
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
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height / 3)];
    [self.view addSubview:spinner];
    self.spinner = spinner;
    [spinner release];
    
    self.techAssociateTextField.tag = 1;
    self.machineTextField.tag = 2;
    self.locationTextField.tag = 3;
    self.categoryTextField.tag = 4;
    self.opIdTextField.tag  = 5;
    
    self.machineTextField.enabled = YES;
    self.techAssociateTextField.enabled = YES;
    self.opIdTextField.text = @"Select a User ...";
    
    [super viewDidLoad];
    [[self scrollView] setScrollEnabled:YES];

    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) 
    {
    [[self scrollView]  setContentSize:CGSizeMake(320, 820)];
    }else
    {
     [[self scrollView]  setContentSize:CGSizeMake(320, 530)];
    }

    [[self scrollView]  flashScrollIndicators];
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * machineArrowView = [[ UIImageView  alloc ]  initWithImage :
                            [UIImage  imageNamed : @"Arrow_Down.png" ]]; 
    [self.machineTextField setRightView: machineArrowView];
    [self.machineTextField setRightViewMode: UITextFieldViewModeAlways];
    [machineArrowView release ];

    UIImageView * categoryArrowView = [[ UIImageView  alloc ]  initWithImage :
                             [UIImage  imageNamed : @"Arrow_Down.png" ]];
    [self.categoryTextField setRightView: categoryArrowView];
    [self.categoryTextField setRightViewMode: UITextFieldViewModeAlways];
    [categoryArrowView release ];
    
    UIImageView * locationArrowView = [[ UIImageView  alloc ]  initWithImage :
                                       [UIImage  imageNamed : @"Arrow_Down.png" ]];
    [self.locationTextField setRightView: locationArrowView];
    [self.locationTextField setRightViewMode: UITextFieldViewModeAlways];
    [locationArrowView release ];
    
    UIImageView * opIdArrowView = [[ UIImageView  alloc ]  initWithImage :
                                             [UIImage  imageNamed : @"Arrow_Down.png" ]];
    [self.opIdTextField setRightView: opIdArrowView];
    [self.opIdTextField setRightViewMode: UITextFieldViewModeAlways];
    [opIdArrowView release ];
    
    UIImageView * techAssociatesArrowView = [[ UIImageView  alloc ]  initWithImage :
                                             [UIImage  imageNamed : @"Arrow_Down.png" ]];
    [self.techAssociateTextField setRightView: techAssociatesArrowView];
    [self.techAssociateTextField setRightViewMode: UITextFieldViewModeAlways];
    [techAssociatesArrowView release ];
    
    [self.addTicketButton setBackgroundImage:[[UIImage imageNamed:@"iPhone_Orange_Button.png"]
                                                stretchableImageWithLeftCapWidth:8.0f
                                                topCapHeight:0.0f]
                                      forState:UIControlStateNormal];
    
    [self.addTicketButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addTicketButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.addTicketButton.titleLabel.shadowColor = [UIColor lightGrayColor];
    self.addTicketButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    [self.selectPartDescButton setBackgroundImage:[[UIImage imageNamed:@"iPhone_Orange_Button.png"]
                                              stretchableImageWithLeftCapWidth:8.0f
                                              topCapHeight:0.0f]
                                    forState:UIControlStateNormal];
    
    [self.selectPartDescButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
        self.selectPartDescButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    } else {
        self.selectPartDescButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    
    self.selectPartDescButton.titleLabel.shadowColor = [UIColor lightGrayColor];
    self.selectPartDescButton.titleLabel.shadowOffset = CGSizeMake(0, -1);

    self.issueDescriptionTextView.layer.borderWidth = 1;
    self.issueDescriptionTextView.layer.cornerRadius = 8;
    self.issueDescriptionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    
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

- (void) viewWillAppear:(BOOL)animated {
    
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
    if (!u){
        [self.navigationController  popToRootViewControllerAnimated:YES];
    }
    
    if (self.userForTicket != nil) {
        self.opIdTextField.text = self.userForTicket.fullName;
    }
    
    if (self.categories == nil) {
        NSString *categoryAddress = [NSString stringWithFormat:@"http://%@/autotech/services/TicketCategory.ashx", ConnectionString];
        NSURL *categoryUrl = [NSURL URLWithString:categoryAddress];
        NSArray *categoryResults = [NSArray arrayWithContentsOfURL:categoryUrl];
        [self setCategories:[NSMutableArray arrayWithCapacity:[categoryResults count]]];
        
        for (NSDictionary *c in categoryResults)
        {
            [[self categories] addObject:[TicketCategory TicketCategoryWithDictionary:c]];
            if ([[c valueForKey:@"categoryId"] isEqualToString:self.ticket.categoryId] && self.categoryForTicket == nil) {
                self.categoryForTicket = [TicketCategory TicketCategoryWithDictionary:c];
                self.categoryTextField.text = self.categoryForTicket.categoryDescription;
            }
        }
    } else if (self.categoryForTicket != nil) {
        self.categoryTextField.text = self.categoryForTicket.categoryDescription;
    }
    
//    [self.spinner startAnimating];
    
//    [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
    
    [self loadData];
    
    [super viewWillAppear:animated];
}

- (void) loadData {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];

        
    if (self.locations == nil) {
        NSString *locationAddress = [NSString stringWithFormat:@"http://%@/autotech/services/Location.ashx", ConnectionString];
        NSURL *locationUrl = [NSURL URLWithString:locationAddress];
        NSArray *locationResults = [NSArray arrayWithContentsOfURL:locationUrl];
        [self setLocations:[NSMutableArray arrayWithCapacity:[locationResults count]]];

        for (NSDictionary *l in locationResults)
        {
            [[self locations] addObject:[Location LocationWithDictionary:l]];
            if ([[l valueForKey:@"locationId"]isEqualToString:u.plantID]){
                self.locationForTicket = [Location LocationWithDictionary:l];
                self.locationTextField.text = [[self locationForTicket] locationDescription];
            }
        }
    } else if (self.locationForTicket != nil) {
        self.locationTextField.text = self.locationForTicket.locationDescription;
    }
    
    if (self.locationForTicket != nil)
    {
        // load machine
        [self refreshMachinesArray:[self.locationForTicket locationId]];
        // load techAssociates
        [self refreshTechsArray:self.locationForTicket.locationId];
    }
    
    /*
    NSString *techAreaID = [[(AutotechAppDelegate *) [[UIApplication sharedApplication] delegate] currentUser] getTechAreaID];

    NSString *techAssociatesAddress = [NSString stringWithFormat:@"http://%@/autotech/services/TechAssociates.ashx?TechAreaID=%@", ConnectionString, techAreaID];
    NSURL *techAssociatesUrl = [NSURL URLWithString:techAssociatesAddress];
    NSArray *techAssociatesResults = [NSArray arrayWithContentsOfURL:techAssociatesUrl];
    [self setTechs:[NSMutableArray arrayWithCapacity:[techAssociatesResults count]]];
    for (NSDictionary *t in techAssociatesResults) {
        [self.techs addObject:[Techs techWithDictionary:t]];
        if ([[t valueForKey:@"techID"] isEqualToString: [u getTechAdminID]]) {
            self.techForTicket = [Techs techWithDictionary:t];
            self.techAssociateTextField.text = self.techForTicket.techFullName;
            if (![techAreaID isEqualToString:@"0"]) {
                break;
            }
        }
    }
    */
    
//    [self.spinner stopAnimating];
    
    [pool release];
}

- (void) refreshMachinesArray: (NSString *) locationid {
    [self.machines removeAllObjects];
    
    if (!self.didSelectedMachine) {
        self.machineForTicket = nil;
    }
    
    NSString *address =[NSString stringWithFormat: @"http://%@/autotech/services/Machines.ashx?plantId=%@&isMold=0",ConnectionString,locationid];
    
    NSURL *url = [NSURL URLWithString:address];
    NSArray *results = [NSArray arrayWithContentsOfURL:url];
    [self setMachines:[NSMutableArray arrayWithCapacity:[results count]]];
    
    for (NSDictionary *m in results)
    {
        [[self machines] addObject:[ Machine machineWithDictionary:m]];
    }
    
    if (self.machineForTicket == nil) {
        self.machineTextField.text = @"Select a Machine ...";
    } else {
        self.machineTextField.text = self.machineForTicket.machineDescription;
    }
    
    if (self.machines.count == 0) {
        self.machineTextField.text = @"No Machines Found ...";
    }
    
    self.didSelectedMachine = NO;
}

- (void)refreshTechsArray:(NSString *)locationId
{
    [self.techs removeAllObjects];
    
    if (!self.didSelectedTech) {
        self.techForTicket = nil;
    }
    
    NSString *techAssociatesAddress = [NSString stringWithFormat:@"http://%@/autotech/services/Techs.ashx?plantId=%@", ConnectionString,locationId];
    NSURL *techAssociatesUrl = [NSURL URLWithString:techAssociatesAddress];
    NSArray *techAssociatesResults = [NSArray arrayWithContentsOfURL:techAssociatesUrl];
    [self setTechs:[NSMutableArray arrayWithCapacity:[techAssociatesResults count]]];
    for (NSDictionary *t in techAssociatesResults) {
        [self.techs addObject:[Techs techWithDictionary:t]];
    }
    
    if (self.techForTicket == nil) {
        self.techAssociateTextField.text = @"Select a tech ...";
    } else {
        self.techAssociateTextField.text = self.techForTicket.techFullName;
    }
    
    if (self.techs.count == 0) {
        self.techAssociateTextField.text = @"No Techs Found ...";
    }
    
    self.didSelectedTech = NO;
}

- (void)viewDidUnload
{
    self.spinner = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}


#pragma mark - UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (thePickerView.tag) {
        case 1: // Tech Associate TextField
            return [self.techs count];            
            break;
//        case 2:
//            return [self.machines count];
//            break;
        case 3:
            return [self.locations count];
                break;
        case 4:
            return [self.categories count];
            break;
//        case 5:
//            return [self.allUsers count];
//            break;
        default:
            return 0;
            break;
    }
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (pickerView.tag) {
        case 1: // Tech Associate TextField
            return [[[self techs] objectAtIndex:row] techFullName];
            break;
//        case 2:  // Machine TextField
//            return [[[self machines] objectAtIndex:row] machineDescription];
//            break;
        case 3:  // Location TextField
            return [[[self locations] objectAtIndex:row] locationDescription];
            break;
        case 4:  // Category TextField
            return [[[self categories] objectAtIndex:row] categoryDescription];
            break;
//        case 5: // All User TextFiled = opidTextField
//            return [[self.allUsers objectAtIndex:row] fullName];
//            break;
        default:
            return nil;
            break;
    }
}


- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (thePickerView.tag) {
        case 1: 
            self.techForTicket = [self.techs objectAtIndex:row];
            break;
//        case 2: 
//            self.machineForTicket = [self.machines objectAtIndex:row];
//            break;
        case 3: 
            self.locationForTicket = [self.locations objectAtIndex:row];
            break;
        case 4: 
            self.categoryForTicket = [self.categories objectAtIndex:row];
            break;
//        case 5:
//            self.userForTicket = [self.allUsers objectAtIndex:row];
//            break;
        default:
            break;
    }
    
}



#pragma mark - UITextField Delegate Override

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    switch (textField.tag) {   
        case 1: // Tech Associates Textfield
        {
            // old way to load
//            [self showPicker:@"Tech Associate" textFieldTag:textField.tag];
//            [self.techAssociateTextField resignFirstResponder];
            
            [self.techAssociateTextField resignFirstResponder];
            ViewWithSearchBarViewController *aView = [[ViewWithSearchBarViewController alloc]initWithContent:self.techs AndSearchType:4 AndSearchView:1];
            [aView setAddTicketViewController:self];
            [aView setModalPresentationStyle:UIModalPresentationFullScreen];
            [aView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:aView animated:YES completion:nil];
            [aView release];
        }
            break;
        case 2: // Machine Textfield
            {
                [self.machineTextField resignFirstResponder];
                
                ViewWithSearchBarViewController *aView = [[ViewWithSearchBarViewController alloc] initWithContent: self.machines AndSearchType:1 AndSearchView:1];
                [aView setAddTicketViewController:self];
                [aView setModalPresentationStyle:UIModalPresentationFullScreen];
                [aView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:aView animated:YES completion:nil];
                [aView release];
            }
            break;
        case 3: // Location Textfield
//            [self showPicker:@"Location" textFieldTag:textField.tag];
//           [self.locationTextField resignFirstResponder];
            {
                [self.locationTextField resignFirstResponder];
                ViewWithSearchBarViewController *aView = [[ViewWithSearchBarViewController alloc]initWithContent:self.locations AndSearchType:3 AndSearchView:1];
                [aView setAddTicketViewController:self];
                [aView setModalPresentationStyle:UIModalPresentationFullScreen];
                [aView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:aView animated:YES completion:nil];
                [aView release];
            }
            break;
        case 4: // Category Textfield
            {
                [self.categoryTextField resignFirstResponder];
                ViewWithSearchBarViewController *aView = [[ViewWithSearchBarViewController alloc]initWithContent:self.categories AndSearchType:2 AndSearchView:1];
                [aView setAddTicketViewController:self];
                [aView setModalPresentationStyle:UIModalPresentationFullScreen];
                [aView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:aView animated:YES completion:nil];
                [aView release];
            }
            break;
        case 5: // All User Textfield
            {
                [self.opIdTextField resignFirstResponder];
                SearchUsersViewController *aView = [[SearchUsersViewController alloc] init];
                [aView setAddTicketViewController:self];
                [aView setModalPresentationStyle:UIModalPresentationFullScreen];
                [aView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                [self presentViewController:aView animated:YES completion:nil];
                [aView release];
            }
            break;
        default:
            [super textFieldDidBeginEditing:textField];
            break;
    }
}


- (void) textFieldDidEndEditing:(UITextField *)textField{
    
//    switch (textField.tag) {
//        case 1: // Tech Associate TextField
//        case 2: // Machine TextField
//        case 3: // Location TextField
//        case 4: // Category Textfield
//            break;
//        default:
//            [super textFieldDidEndEditing:textField]; 
//            //self.currentWritingTextField = nil; 
//            break;
//    }
    
    if (textField == self.lineNumberTextField && [self.orderNumberTextField.text integerValue] >= 1000  && self.lineNumberTextField.text.length > 0) {
        Part *p = [self getPartInfo:self.orderNumberTextField.text And:self.lineNumberTextField.text];
        self.partDescTextField.text = p.partNumber;
        self.likePartTextField.text = p.likePart;
    }
    
    [super textFieldDidEndEditing:textField];     
}


#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        switch (actionSheet.tag) {
            case 1: // Tech Associate
                if (!self.techs) {
                    self.techAssociateTextField = [self.techs objectAtIndex:0];
                }
                self.techAssociateTextField.text = self.techForTicket.techFullName;
                break;
//            case 2: // Machine 
//                if (!self.machineForTicket){
//                    self.machineForTicket = [self.machines objectAtIndex:0];
//                }
//                self.machineTextField.text = self.machineForTicket.machineDescription;
//                break;
            case 3: // Location 
                if (!self.locationForTicket){
                    self.locationForTicket = [self.locations objectAtIndex:0];
                }
                self.locationTextField.text = self.locationForTicket.locationDescription;
                [self refreshMachinesArray:self.locationForTicket.locationId];
                break;
            case 4: // Category
                if (!self.categoryForTicket){
                    self.categoryForTicket = [self.categories objectAtIndex:0];
                }
                self.categoryTextField.text = self.categoryForTicket.categoryDescription;
                break;
//            case 5:
//                if (!self.userForTicket) {
//                    self.userForTicket = [self.allUsers objectAtIndex:0];
//                    }
//                self.opIdTextField.text = self.userForTicket.fullName;
//                break;
            default:
                break;
        }
    }else 
    {
        [self resignFirstResponder];
    }
}


#pragma mark IBAction

- (void) showPicker: (NSString *) title
       textFieldTag: (NSInteger) textFieldTag {
    // Add the picker
    
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    { 

        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(10,60,300,180)];
        pickerView.tag = textFieldTag;
        pickerView.delegate = self;
        pickerView.showsSelectionIndicator = YES;    // note this is default to NO
        
        
                
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
        switch (textFieldTag) {
            case 1: // Tech Associate
                locationRec = CGRectMake(0,0,768,430);
                break;
            case 2: // Machine 
                locationRec = CGRectMake(0,0,768,360);
                break;
            case 3: // Location 
                locationRec = CGRectMake(0,0,768,290);
                break;
            case 4: // Category
                locationRec = CGRectMake(0,0,768,220);
                break;
            case 5: // All Users
                locationRec = CGRectMake(0,0,768,360);
                break;
            default:
                break;
        }
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

#pragma mark Programmer Methods

- (void) popSelection:(id) sender {
    NSInteger tid = ((UIControl*)sender).tag;
    
    switch (tid) {
        case 1: // Tech Associate
            self.techAssociateTextField.text = self.techForTicket.techFullName;
            break;
//        case 2: // Machine 
//            self.machineTextField.text = self.machineForTicket.machineDescription;
//            break;
        case 3: // Location 
            self.locationTextField.text = self.locationForTicket.locationDescription;
            [self refreshMachinesArray:self.locationForTicket.locationId];
            break;
        case 4: // Category
            self.categoryTextField.text = self.categoryForTicket.categoryDescription;
            break;
//        case 5: // All Users
//            self.opIdTextField.text = self.userForTicket.fullName;
//            break;
        default:
            break;
    }
    [self.popOverController dismissPopoverAnimated:YES];
}

- (IBAction) createTicketButtonClick: (id) sender {
    if( [self validateFields])
        [self saveTicket];
}

- (BOOL) validateFields 
{ 
    BOOL areAllValid = YES;
    
    NSString *message = @"Please perform the following actions:\n";
    
    if ([self.orderNumberTextField.text integerValue] < 1000) {
        message = [message stringByAppendingString:@"\nOrder Number's must lager than 1000"];
        areAllValid = NO; 
    }
    
//    if (self.orderNumberTextField.text.length < 4 || self.orderNumberTextField.text.length > 10) {
//        message = [message stringByAppendingString:@"\nOrder Number's length must be 4-10"];
//        areAllValid = NO; 
//    }
    
    if ([self categoryForTicket] == nil) {
        message = [message stringByAppendingString:@"\nSelect Category"];
        areAllValid = NO;   
    }   
    
    if ([self locationForTicket] == nil) {
        message = [message stringByAppendingString:@"\nSelect Location"];
        areAllValid = NO;   
    }
    
    if ([self machineForTicket] == nil) {
        message = [message stringByAppendingString:@"\nSelect Machine"];
        areAllValid = NO;   
    }
    
    if ([self techForTicket] == nil){
        message = [message stringByAppendingString:@"\nSelect Tech Assoc"];
        areAllValid = NO;   
    }
    
    if(self.issueDescriptionTextView.text.length == 0) {
        message = [message stringByAppendingString:@"\nEnter a Description"];
        areAllValid = NO;   
    }
    
    if (! areAllValid){
        [self displayInfoAlert:@"Couldn't create ticket":message];
    }
      return areAllValid;
}


- (void) saveTicket {
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
//    NSString *adminTechAssocId =[u getTechAdminID];
    NSString *address = [NSString stringWithFormat: @"http://%@/autotech/services/AddTicket.ashx?opId=%@&categoryId=%@&machineId=%@&techAssocId=%@&orderNumber=%@&lineNumber=%@&plantId=%@&issueDesc=%@&partDesc=%@&adminTechAssocId=%@&techAssocName=%@&userMasterId=%@&likePart=%@",ConnectionString,self.userForTicket.userMasterID, [self.categoryForTicket categoryId],[self.machineForTicket machineId], [[self techForTicket] techID], self.orderNumberTextField.text, self.lineNumberTextField.text, [self.locationForTicket locationId],[self.issueDescriptionTextView.text escapedURLString], self.partDescTextField.text, self.techForTicket.techID, u.name, u.userMasterId, self.likePartTextField.text];
    
    address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:address];
    NSError *error;
    NSString *result = [NSString stringWithContentsOfURL:url encoding: NSASCIIStringEncoding error:&error];
    if(![result isEqualToString:@"0"]){
        // Update SubTicket ID
        if (self.ID.length > 0) {
            NSString *subTicektId = result;
            [self updateSubTicketID:self.ID :subTicektId];
        } else {
        [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        [self displayInfoAlert:@"Error": [NSString stringWithFormat: @"An error occurred while creating the ticket, please try again or contact MIS. Error: %@", result]];
    }
}

- (void) updateSubTicketID: (NSString *) ID : (NSString *) subTicketId
{
    NSString *address = [NSString stringWithFormat:@"http://%@/autotech/services/UpdateSubTicketID.ashx?ID=%@&subTicketID=%@", ConnectionString, ID, subTicketId];
    address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:address];
    NSError *error;
    [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) displayInfoAlert: (NSString *) title
                         : (NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:title];
	[alert setMessage:message];
	[alert addButtonWithTitle:@"Close"];
	[alert show];
	[alert release];
    
}

-(void)dismissKeyboard {
    if ([self.orderNumberTextField isFirstResponder]) {
        [self.orderNumberTextField resignFirstResponder];
    } else if ([self.lineNumberTextField isFirstResponder]) {
        [self.lineNumberTextField resignFirstResponder];
    } else if ([self.partDescTextField isFirstResponder]) {
        [self.partDescTextField resignFirstResponder];
    } else if ([self.likePartTextField isFirstResponder]) {
        [self.likePartTextField resignFirstResponder];
    } else if ([self.issueDescriptionTextView isFirstResponder]) {
        [self.issueDescriptionTextView resignFirstResponder];
    }
}

- (IBAction) showPartDescription
{
    SelectPartDescViewController *s = [[SelectPartDescViewController alloc] init];
    [s setAddTicketViewController:self];
    [s setModalPresentationStyle:UIModalPresentationFullScreen];
    [s setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:s animated:YES completion:nil];
    [s release];
}

- (Part *) getPartInfo:(NSString *) orderNumber And: (NSString *) lineNumber
{
    Part *p = nil;
    NSString *address = [NSString stringWithFormat:@"http://%@/autotech/services/PartNumber.ashx?orderNumber=%@&lineNumber=%@", ConnectionString, orderNumber, lineNumber];
    NSURL *url = [NSURL URLWithString:address];
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfURL:url];
    if (result != nil) {
        p = [Part partWithDictionary:result];
    }
    return p;
}

@end
