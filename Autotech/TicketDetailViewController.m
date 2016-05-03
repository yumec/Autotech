#import "TicketDetailViewController.h"
#import "AutotechAppDelegate.h"
#import "TicketActivity.h"
#import "DefaultTechNotesViewController.h"
#import "AddTicketViewController.h"
#import "NSString+URLEscapes.h"
#import "ViewWithSearchBarViewController.h"
#import "PICSViewController.h"

@implementation TicketDetailViewController


@synthesize ticket = _ticket, 
techForTicket = _techForTicket,
parentTickets = _parentTickets,
machineTextField = _machineTextField, 
partDescriptionTextField = _partDescriptionTextField, 
categoryTextField = _categoryTextField,
techTextField = _techTextField,
scrollView = _scrollView,
issueDescriptionTextView = _issueDescriptionTextView,
statusSwitch = _statusSwitch,
closeTicketButton = _closeTicketButton,
techs = _techs, 
//techPickerView = _techPickerView,
techNotesTextView = _techNotesTextView,
inProcessLabel = _inProcessLabel, 
dateEnteredTextField = _dateEnteredTextField,
playPauseButton = _playPauseButton,
defaultNotesButton = _defaultNotesButton;

@synthesize statusPickerView = _statusPickerView;
@synthesize status = _status;
@synthesize popOverController = _popOverController;
@synthesize ticketIdLabel = _ticketIdLabel;
@synthesize createSubTicket = _createSubTicket;
@synthesize subTicketLabel = _subTicketLabel;
@synthesize requestorLabel = _requestorLabel;
@synthesize locationTextField = _locationTextField;

@synthesize spinner = _spinner;
@synthesize locations = _locations;
@synthesize machines = _machines;
@synthesize categories = _categories;
@synthesize locationForTicket = _locationForTicket;
@synthesize machineForTicket = _machineForTicket;
@synthesize categoryForTicket = _categoryForTicket;

@synthesize didSelectedMachine = _didSelectedMachine;
@synthesize didSelectedTech = _didSelectedTech;
@synthesize likePartTextField = _likePartTextField;

@synthesize viewPicsButton = _viewPicsButton;
//@synthesize hasPics = _hasPics;
@synthesize picsStatus = _picsStatus;
//@synthesize techExceptionList = _techExceptionList;

+ (id) initWithTicket: (Ticket *) newTicket{
    TicketDetailViewController *t = [[[TicketDetailViewController alloc]init]autorelease];
    [t setTicket:newTicket];
    return self;
}


- (void)dealloc
{
    [_ticket release];
    [_machineTextField release];
	[_parentTickets release];
    [_partDescriptionTextField release];
    [_categoryTextField release];
    [_techTextField release];
    [_issueDescriptionTextView release];
    [_scrollView release];
    [_statusSwitch release];
    [_closeTicketButton release];
    [_techs release];
//    [_techPickerView release];
    [_techNotesTextView release];
    [_inProcessLabel release];
    [_dateEnteredTextField release];
    [_playPauseButton release];
    [_defaultNotesButton release];
    
    [_statusPickerView release];
    [_status release];
    [_popOverController release];
    [_ticketIdLabel release];
    [_createSubTicket release];
    [_subTicketLabel release];
    [_locationTextField release];
    
    [_spinner release];
    [_locations release];
    [_machines release];
    [_categories release];
    [_locationForTicket release];
    [_machineForTicket release];
    [_categoryForTicket release];
    [_likePartTextField release];
    
    [_viewPicsButton release];
//    [_hasPics release];
    [_picsStatus release];
//    [_techExceptionList release];
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
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createSubTicket:)];
//    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.partDescriptionTextField.enabled = YES;
    self.machineTextField.enabled = YES;
    self.locationTextField.enabled = YES;
    self.categoryTextField.enabled = YES;
    self.techTextField.enabled = YES;
    self.likePartTextField.enabled = YES;
    self.machineTextField.delegate = self;
    self.locationTextField.delegate = self;
    self.categoryTextField.delegate = self;
    self.techTextField.delegate = self;
    self.machineTextField.tag = 2;
    self.locationTextField.tag = 3;
    self.categoryTextField.tag = 4;
    self.techTextField.tag = 5;
    
    self.statusSwitch.onTintColor = [UIColor orangeColor];
    self.statusSwitch.tintColor = [UIColor orangeColor];
    self.statusSwitch.thumbTintColor = [UIColor orangeColor];
    
    [[self scrollView] setScrollEnabled:YES];
    
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) 
    {
        [[self scrollView]  setContentSize:CGSizeMake(760, 920)];
    } else {
        [[self scrollView]  setContentSize:CGSizeMake(320, 600)];
    }
    [[self scrollView]  flashScrollIndicators];
    
    UIImageView *locationArrowView = [[ UIImageView  alloc ]  initWithImage :[UIImage  imageNamed : @"Arrow_Down.png" ]];
    [self.locationTextField setRightView: locationArrowView];
    [self.locationTextField setRightViewMode: UITextFieldViewModeAlways];
    [locationArrowView release ];
    
    
    UIImageView *machineArrowView = [[ UIImageView  alloc ]  initWithImage :[UIImage  imageNamed : @"Arrow_Down.png" ]];
    [self.machineTextField setRightView: machineArrowView];
    [self.machineTextField setRightViewMode: UITextFieldViewModeAlways];
    [machineArrowView release ];
    
    UIImageView *categoryArrowView = [[ UIImageView  alloc ]  initWithImage :[UIImage  imageNamed : @"Arrow_Down.png" ]];
    [self.categoryTextField setRightView: categoryArrowView];
    [self.categoryTextField setRightViewMode: UITextFieldViewModeAlways];
    [categoryArrowView release ];
    
    UIImageView *techArrowView = [[ UIImageView  alloc ]  initWithImage :[UIImage  imageNamed : @"Arrow_Down.png" ]];
    [self.techTextField setRightView: techArrowView];
    [self.techTextField setRightViewMode: UITextFieldViewModeAlways];
    [techArrowView release ];
    
    
    [self.closeTicketButton setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"]
                                                stretchableImageWithLeftCapWidth:8.0f
                                                topCapHeight:0.0f]
                                      forState:UIControlStateNormal];
    
    [self.closeTicketButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    [self.viewPicsButton setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"]
                                                stretchableImageWithLeftCapWidth:8.0f
                                                topCapHeight:0.0f]
                                      forState:UIControlStateNormal];
    
    [self.viewPicsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.defaultNotesButton setBackgroundImage:[[UIImage imageNamed:@"Select_Default_Button.png"]
                                                stretchableImageWithLeftCapWidth:8.0f
                                                topCapHeight:0.0f]
                                      forState:UIControlStateNormal];
    
    self.closeTicketButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    self.issueDescriptionTextView.layer.borderWidth = 1;
    self.issueDescriptionTextView.layer.cornerRadius = 8;
    self.issueDescriptionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.techNotesTextView.layer.borderWidth = 1;
    self.techNotesTextView.layer.cornerRadius = 8;
    self.techNotesTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
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



- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height / 3)];
    [self.view addSubview:spinner];
    self.spinner = spinner;
    [spinner release];
    
    [super viewWillAppear:animated];
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
    if (!u){
        [self.navigationController  popToRootViewControllerAnimated:YES];
    } else {
//        self.machineTextField.text = self.ticket.machine;
//        self.categoryTextField.text = self.ticket.category;
        
        if (self.partDescriptionTextField.text.length == 0 ) {
            self.partDescriptionTextField.text = self.ticket.partDescription;
        }
        
        if (self.likePartTextField.text.length == 0) {
            self.likePartTextField.text = self.ticket.likePart;
        }
//        if (self.techNotesTextView.text.length == 0) { // do not need the if statement because it use select default tech note.
            self.techNotesTextView.text = self.ticket.techNotes;
//        }
    
        if (self.issueDescriptionTextView.text.length == 0) {
            self.issueDescriptionTextView.text = self.ticket.issueDescription;
        }
     
        self.dateEnteredTextField.text = self.ticket.dateEntered;
        self.ticketIdLabel.text = [NSString stringWithFormat:@"ID = %@", self.ticket.iD];
        self.requestorLabel.text = [NSString stringWithFormat:@"Request by: %@", self.ticket.requestor];
        
        if (self.status == nil) {
            self.status = [NSArray arrayWithObjects:cStatusNew, cStatusInProcess, cStatusClosed, nil];
        }
        
        if  ([self.ticket.statusDescription isEqualToString:cStatusNew])  {
            [self.statusSwitch setOn:NO animated:YES];
            self.playPauseButton.hidden = YES;
        }else{
         [self loadInProcessInfo];
            // Display Pause Button. 
            self.playPauseButton.hidden = NO;
        }
        
        //LoadPics button
        if ([self.ticket.hasPics isEqualToString:@"1"]) {
            self.viewPicsButton.hidden = NO;
        }
        else
        {
            self.viewPicsButton.hidden = YES;
        }

        //Get Pics Status
        self.picsStatus = [self GetPicsStauts:self.ticket.iD];
        if ([self.picsStatus isEqualToString:@"1"])
        {
            self.viewPicsButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.viewPicsButton setTitle:@"This Ticket had been confirmed!" forState:UIControlStateNormal];
        }
    }
    
//    if (self.ticket.subTicketId.length > 0) {
//        self.subTicketLabel.text =[NSString stringWithFormat:@"SubID = %@", self.ticket.subTicketId];
//    }
    
    
    [self.spinner startAnimating];
//    [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
    [self loadData];
}

- (void) loadData {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
    
    // load location
    
    if (self.locations == nil) {
        NSString *locationAddress = [NSString stringWithFormat:@"http://%@/autotech/services/Location.ashx", ConnectionString];
        NSURL *locationUrl = [NSURL URLWithString:locationAddress];
        NSArray *locationResults = [NSArray arrayWithContentsOfURL:locationUrl];
        [self setLocations:[NSMutableArray arrayWithCapacity:[locationResults count]]];
        
        for (NSDictionary *l in locationResults)
        {
            [[self locations] addObject:[Location LocationWithDictionary:l]];
            if ([[l valueForKey:@"locationId"]isEqualToString:self.ticket.locationId] && self.locationForTicket == nil){
                self.locationForTicket = [Location LocationWithDictionary:l];
                self.locationTextField.text = [ self.locationForTicket locationDescription];
            }
        }
    } else if (self.locationForTicket != nil) {
        self.locationTextField.text = self.locationForTicket.locationDescription;
    }
    
    // load category
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
    
    if (self.locationForTicket != nil)
    {
        [self refreshMachinesArray:[self.locationForTicket locationId]];
        [self refreshTechsArray:self.locationForTicket.locationId];
    }
    
//    if (self.techExceptionList == nil) {
//        NSString *techExceptionListAddress = [NSString stringWithFormat:@"http://%@/autotech/services/TechExceptionList.ashx", ConnectionString];
//        NSURL *techExceptionListUrl = [NSURL URLWithString:techExceptionListAddress];
//        NSArray *techExceptionListResults = [NSArray arrayWithContentsOfURL:techExceptionListUrl];
//        [self setTechExceptionList:[NSMutableArray arrayWithCapacity:[techExceptionListResults count]]];
//        
//        for (NSDictionary *t in techExceptionListResults)
//        {
//            [self.techExceptionList addObject:[t valueForKey:@"techID"]];
//        }
//    }
    
    [self.spinner stopAnimating];
    
    [pool release];
}

- (void) refreshMachinesArray: (NSString *) locationId {
    [self.machines removeAllObjects];
    
    if (!self.didSelectedMachine) {
        self.machineForTicket = nil;
    }
    
    NSString *address =[NSString stringWithFormat: @"http://%@/autotech/services/Machines.ashx?plantId=%@&isMold=0",ConnectionString,locationId];
    
    NSURL *url = [NSURL URLWithString:address];
    NSArray *results = [NSArray arrayWithContentsOfURL:url];
    [self setMachines:[NSMutableArray arrayWithCapacity:[results count]]];
    
    for (NSDictionary *m in results)
    {
        [[self machines] addObject:[Machine machineWithDictionary:m]];
        if ([[m valueForKey:@"machineId"] isEqualToString:self.ticket.machineId] && self.machineForTicket == nil) {
            self.machineForTicket = [Machine machineWithDictionary:m];
            self.machineTextField.text = self.machineForTicket.machineDescription;
        }
    }

    if (self.machineForTicket == nil) {
        self.machineTextField.text = @"Select a Machine ...";
    } else {
        self.machineTextField.text = self.machineForTicket.machineDescription;
    }
    
    if ([[self machines] count] == 0)
    {
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
        if ([[t valueForKey:@"techID"]isEqualToString:self.ticket.techId]  && self.techForTicket == nil) {
            self.techForTicket = [Techs techWithDictionary:t];
            self.techTextField.text = self.techForTicket.techFullName;
        }
    }
    
    if (self.techForTicket == nil) {
        self.techTextField.text = @"Select a tech ...";
    } else {
        self.techTextField.text = self.techForTicket.techFullName;
    }
    
    if (self.techs.count == 0) {
        self.techTextField.text = @"No Techs Found ...";
    }
    
    self.didSelectedTech = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.spinner = nil;
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
        [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];

    NSInteger statusAsInt;
    if (self.statusSwitch.on) {
        statusAsInt = KStatusInProcess;
    } else {
        statusAsInt = KStatusNew;
    }
    NSString *activityAction = @"Play";
    if (self.playPauseButton.tag == 2) {
        activityAction = @"Pause";
    }
    
    if (buttonIndex == 0) { // Cancel
        return;
    } else if (buttonIndex == 1) { // Save Ticket
        NSString *address = [NSString stringWithFormat: @"http://%@/autotech/services/UpdateTicket.ashx?ticketID=%@&opId=%@&categoryId=%@&machineId=%@&statusId=%d&techAssocId=%@&dateclosed=no&techNotes=%@&userMasterId=%@&issueDesc=%@&activityAction=%@&partDesc=%@&plantId=%@&likePart=%@",ConnectionString, self.ticket.iD,self.ticket.opId, self.categoryForTicket.categoryId, self.machineForTicket.machineId, (int)statusAsInt,self.techForTicket.techID ,[self.techNotesTextView.text escapedURLString], u.userMasterId,[self.issueDescriptionTextView.text escapedURLString], activityAction, self.partDescriptionTextField.text, self.locationForTicket.locationId, self.likePartTextField.text];
        address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:address];
        NSError *error;
        NSString *result = [NSString stringWithContentsOfURL:url encoding: NSASCIIStringEncoding error:&error];
        if([result isEqualToString:@"1"]){ // success save
            if (![self.techForTicket.techID isEqualToString:self.ticket.techId]) { // push to another tech associate page.
                [self.parentTickets removeObject:self.ticket];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                // Reload Data
                self.ticket.techNotes = self.techNotesTextView.text;
                self.ticket.issueDescription = self.issueDescriptionTextView.text;
                self.ticket.partDescription = self.partDescriptionTextField.text;
                self.ticket.likePart = self.likePartTextField.text;
            }
        }else {
            [self displayInfoAlert:@"Error" And: [NSString stringWithFormat: @"An error occurred while closing the ticket, please try again or contact MIS. Error: %@", result]];
        }
    } else if (buttonIndex == 2) { // Close Ticket
        
        if ([self.ticket.hasPics isEqualToString:@"1"] && [self.picsStatus isEqualToString:@"1"]) { // has pics and neec to confirmed first
            [self saveCurrentTickt];
        }
        else if ([self.ticket.hasPics isEqualToString:@"0"]) // no pics
        {
            [self saveCurrentTickt];
        }
        else
        {
            [self displayInfoAlert:@"Error" And:@"Please Confirm PICS first!"];
        }
    }
}

- (void) saveCurrentTickt
{
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
    
    NSString *address = [NSString stringWithFormat: @"http://%@/autotech/services/UpdateTicket.ashx?ticketID=%@&opId=%@&categoryId=%@&machineId=%@&statusId=6&techAssocId=%@&dateclosed=close&techNotes=%@&userMasterId=%@&issueDesc=%@&partDesc=%@&plantId=%@&likePart=%@",ConnectionString, self.ticket.iD,self.ticket.opId, self.categoryForTicket.categoryId, self.machineForTicket.machineId,self.techForTicket.techID, [self.techNotesTextView.text escapedURLString], u.userMasterId,[self.issueDescriptionTextView.text escapedURLString], self.partDescriptionTextField.text, self.locationForTicket.locationId, self.likePartTextField.text];
    address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:address];
    NSError *error;
    NSString *result = [NSString stringWithContentsOfURL:url encoding: NSASCIIStringEncoding error:&error];
    if([result isEqualToString:@"1"]){
        [self.parentTickets removeObject:self.ticket];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self displayInfoAlert:@"Error" And: [NSString stringWithFormat: @"An error occurred while closing the ticket, please try again or contact MIS. Error: %@", result]];
    }
    
    /*
    BOOL isExceptionuser = NO;
    for (NSString *exceptionUser in self.techExceptionList) {
        if ([self.techForTicket.techID isEqualToString: exceptionUser]) {
            isExceptionuser= YES;
            break;
        }
    }

    if (isExceptionuser || [u.loginTechID isEqualToString:self.techForTicket.techID]) {
        NSString *address = [NSString stringWithFormat: @"http://%@/autotech/services/UpdateTicket.ashx?ticketID=%@&opId=%@&categoryId=%@&machineId=%@&statusId=6&techAssocId=%@&dateclosed=close&techNotes=%@&userMasterId=%@&issueDesc=%@&partDesc=%@&plantId=%@&likePart=%@",ConnectionString, self.ticket.iD,self.ticket.opId, self.categoryForTicket.categoryId, self.machineForTicket.machineId,self.techForTicket.techID, [self.techNotesTextView.text escapedURLString], u.userMasterId,[self.issueDescriptionTextView.text escapedURLString], self.partDescriptionTextField.text, self.locationForTicket.locationId, self.likePartTextField.text];
        address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:address];
        NSError *error;
        NSString *result = [NSString stringWithContentsOfURL:url encoding: NSASCIIStringEncoding error:&error];
        if([result isEqualToString:@"1"]){
            [self.parentTickets removeObject:self.ticket];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self displayInfoAlert:@"Error" And: [NSString stringWithFormat: @"An error occurred while closing the ticket, please try again or contact MIS. Error: %@", result]];
        }
    } else {
        [self displayInfoAlert:@"Error" And:@"You must assign the Tech Associate to yourself to close the ticket."];
    }*/
}

#pragma mark - UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (thePickerView.tag) {
        case 1:
            return [self.techs count];
            break;
        case 2:
            return [self.status count];
            break;
        default:
            return 0;
            break;
    }
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    switch (thePickerView.tag) {
        case 1:
            return [[self.techs objectAtIndex:row] techFullName];
            break;
        case 2:
            return [self.status objectAtIndex:row];
            break;
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (thePickerView.tag) {
        case 1:
            self.techForTicket = [self.techs objectAtIndex:row];
            self.techTextField.text = self.techForTicket.techFullName;
            break;
        default:
            break;
    }
}


#pragma mark - UITextField Delegate Override

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 1: // Tech Associate TextField
            [self showPicker:@"Select Tech Associates" textFieldTag:textField.tag];
            [self.techTextField resignFirstResponder];
            break;
        case 2: // Machine Textfield
        {
            [self.machineTextField resignFirstResponder];
            
            ViewWithSearchBarViewController *aView = [[ViewWithSearchBarViewController alloc] initWithContent: self.machines AndSearchType:1 AndSearchView:2];
            [aView setTicketDetailViewController:self];
            [aView setModalPresentationStyle:UIModalPresentationFullScreen];
            [aView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:aView animated:YES completion:nil];
            [aView release];
        }
            break;
        case 3: // Location Textfield
        {
            [self.locationTextField resignFirstResponder];
            ViewWithSearchBarViewController *aView = [[ViewWithSearchBarViewController alloc]initWithContent:self.locations AndSearchType:3 AndSearchView:2];
            [aView setTicketDetailViewController:self];
            [aView setModalPresentationStyle:UIModalPresentationFullScreen];
            [aView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:aView animated:YES completion:nil];
            [aView release];
        }
            break;
        case 4: // Category Textfield
        {
            [self.categoryTextField resignFirstResponder];
            ViewWithSearchBarViewController *aView = [[ViewWithSearchBarViewController alloc]initWithContent:self.categories AndSearchType:2 AndSearchView:2];
            [aView setTicketDetailViewController:self];
            [aView setModalPresentationStyle:UIModalPresentationFullScreen];
            [aView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:aView animated:YES completion:nil];
            [aView release];
        }
            break;
        case 5: // Tech Associates Textfield
        {
            [self.techTextField resignFirstResponder];
            ViewWithSearchBarViewController *aView = [[ViewWithSearchBarViewController alloc]initWithContent:self.techs AndSearchType:4 AndSearchView:2];
            [aView setTicketDetailViewController:self];
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

- (void) textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
}

#pragma mark - Action Sheet Delegate


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        switch (actionSheet.tag) {
            case 1: // Tech Associates
                if (!self.techs) {
                    self.techTextField.text = [self.techs objectAtIndex:0];
                }
                self.techTextField.text = self.techForTicket.techFullName;
                break;
            default:
                break;
        }
    } else {
        [self resignFirstResponder];
    }
}


#pragma mark - Programmer Messages 

/*
- (void) showPicker: (NSString *) title {

    //resenting action sheet clipped by its superview. Some controls might not respond to touches. On iPhone try -[UIActionSheet showFromTabBar:] or -[UIActionSheet showFromToolbar:] instead of -[UIActionSheet showInView:].
    
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:@"Select"
                                        destructiveButtonTitle:@"Cancel"
                                             otherButtonTitles:nil];

    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,185,0,0)];
    
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;    // note this is default to NO
    
    [menu addSubview:pickerView];
    //[menu showInView:self.view];
       [menu showFromTabBar:self.tabBarController.tabBar];
    [menu setBounds:CGRectMake(0,0,320, 655)];
    
    [pickerView release];
    [menu release];

}
*/

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
        UIView *popoverView = [[UIView alloc]
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
                locationRec = CGRectMake(0,0,618,375);
                break;
            case 2: // Status 
                locationRec = CGRectMake(0,0,618,375);
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
    } else {
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


- (IBAction) toggleEnabledForStatusSwitch: (id) sender {  
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
    if(self.statusSwitch.on ) // Set as InProcess
    {
        NSString *address = [NSString stringWithFormat: @"http://%@/autotech/services/LogProcessTicket.ashx?hdticketID=%@&statusId=%d&userMasterId=%@&action=play",ConnectionString, self.ticket.iD,KStatusInProcess,u.userMasterId];
        address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:address];
        NSError *error;
        NSString *result = [NSString stringWithContentsOfURL:url encoding: NSASCIIStringEncoding error:&error];
        if([result isEqualToString:@"0"]) {
            [self displayInfoAlert:@"Error" And:@"An error occurred while changing ticket status, please try again or contact MIS"];
        } else {
            self.ticket.statusDescription =  cStatusInProcess;
            self.inProcessLabel.text = [NSString stringWithFormat:@"In Process by: %@", u.name];
            self.playPauseButton.hidden = NO;
            [self.playPauseButton setImage:[UIImage imageNamed:@"pause_button.png"] forState:UIControlStateNormal];
            self.playPauseButton.tag = 1;
        }
    } else { // Set Ticket as New
        NSString *address = [NSString stringWithFormat: @"http://%@/autotech/services/LogProcessTicket.ashx?hdticketID=%@&statusId=%d&userMasterId=%@&action=new", ConnectionString,self.ticket.iD, KStatusNew,u.userMasterId];
        address = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:address]; 
        NSError *error;
        NSString *result = [NSString stringWithContentsOfURL:url encoding: NSASCIIStringEncoding error:&error];
        if([result isEqualToString:@"0"]) {
            [self displayInfoAlert:@"Error" And:@"An error occurred while changing ticket status, please try again or contact MIS"];
        }
        else {
            self.ticket.statusDescription =  cStatusNew;
            self.inProcessLabel.text = @"";
            self.playPauseButton.hidden = YES;
        }
    }
    
}


//- (IBAction) closeTicketButtonClick: (id) sender{
//    UIAlertView *alert = [[UIAlertView alloc] init];
//	[alert setTitle:@"Close Ticket"];
//	[alert setMessage:@"Please confirm you want to close this ticket:"];
//	[alert setDelegate:self];
//	[alert addButtonWithTitle:@"Yes"];
//	[alert addButtonWithTitle:@"No"];
//	[alert show];
//	[alert release];
//}

- (IBAction) saveAndExitCloseTicketClick:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"Do you want to save this ticket?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save Ticket", @"Close Ticket", nil];
    [alter show];
    [alter release];
}

- (IBAction) showDefaultNotes
{
    DefaultTechNotesViewController *techNotesView = [[DefaultTechNotesViewController alloc] init];    
//    [techNotesView setTicket:self.ticket];
    techNotesView.ticket = self.ticket;
//    techNotesView.ticket.issueDescription = self.issueDescriptionTextView.text;
    techNotesView.ticketDetailViewController = self;
    [techNotesView setModalPresentationStyle:UIModalPresentationFullScreen];
    [techNotesView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:techNotesView animated:YES completion:nil];
    [techNotesView release];
}


- (IBAction) pauseOrPlayButtonClick: (id) sender {
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];

    if ([sender tag] == 1) { // Clicked to pause
        NSString *address = [NSString stringWithFormat: @"http://%@/autotech/services/LogProcessTicket.ashx?hdTicketId=%@&action=%@&userMasterId=%@&statusId=%d",ConnectionString, self.ticket.iD,@"pause",u.userMasterId, KStatusInProcess];
        NSURL *url = [NSURL URLWithString:address];
        NSError *error;
        NSString *result = [NSString stringWithContentsOfURL:url encoding: NSASCIIStringEncoding error:&error];
        if(result) {        
            [(UIButton *)sender setImage:[UIImage imageNamed:@"play_button.png"] forState:UIControlStateNormal ];
            self.inProcessLabel.text = [NSString stringWithFormat:@"Paused by: %@", u.name];
            [sender setTag:2];
        }
    } else { // Clicke to play
        NSString *address = [NSString stringWithFormat: @"http://%@/autotech/services/LogProcessTicket.ashx?hdTicketId=%@&action=%@&userMasterId=%@&statusId=%d",ConnectionString, self.ticket.iD,@"play",u.userMasterId, KStatusInProcess];
        NSURL *url = [NSURL URLWithString:address];
        NSError *error;
        NSString *result = [NSString stringWithContentsOfURL:url encoding: NSASCIIStringEncoding error:&error];
        if(result) {   
            [(UIButton *)sender setImage:[UIImage imageNamed:@"pause_button.png"] forState:UIControlStateNormal ];
            self.inProcessLabel.text = [NSString stringWithFormat:@"In Process by: %@", u.name];
            [sender setTag:1];
        }
    }
}

- (void) displayInfoAlert: (NSString *) title And:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:title];
	[alert setMessage:message];
	[alert addButtonWithTitle:@"Close"];
	[alert show];
	[alert release];
}

-(void) loadInProcessInfo {
    NSString *address = [NSString stringWithFormat:@"http://%@/autotech/services/InProcessInfo.ashx?hdTicketId=%@",ConnectionString, self.ticket.iD];
    NSURL *url = [NSURL URLWithString:address];
    NSDictionary *results = [NSDictionary dictionaryWithContentsOfURL:url];
    if (results){
        TicketActivity *tc = [TicketActivity TicketActivityWithDictionary:results];
        if ([tc.description isEqualToString:@"Paused"]){
            [self.playPauseButton setImage:[UIImage imageNamed:@"play_button.png"] forState:UIControlStateNormal];
            self.inProcessLabel.text = [NSString stringWithFormat:@"Paused by: %@", [tc enteredBy]];
            self.playPauseButton.tag = 2;
        }else {
            self.inProcessLabel.text = [NSString stringWithFormat:@"In Process by: %@", [tc enteredBy]];
             [self.playPauseButton setImage:[UIImage imageNamed:@"pause_button.png"] forState:UIControlStateNormal];
            self.playPauseButton.tag = 1;
        }
    }
}


- (void) dismissKeyboard
{
    if ([self.partDescriptionTextField isFirstResponder]) {
        [self.partDescriptionTextField resignFirstResponder];
    } else if([self.likePartTextField isFirstResponder]) {
        [self.likePartTextField resignFirstResponder];
    } else if ([self.dateEnteredTextField isFirstResponder]) {
        [self.dateEnteredTextField resignFirstResponder];
    } else if ([self.issueDescriptionTextView isFirstResponder]) {
        [self.issueDescriptionTextView resignFirstResponder];
    } else if ([self.techNotesTextView isFirstResponder]) {
        [self.techNotesTextView resignFirstResponder];
    }
}

- (void) popSelection:(id) sender {
    NSInteger tid = ((UIControl*)sender).tag;
    
    switch (tid) {
        case 1: // Tech Associate
            self.techTextField.text = self.techForTicket.techFullName;
            break;
        default:
            break;
    }
    
    [self.popOverController dismissPopoverAnimated:YES];
}

- (IBAction)createSubTicket:(id)sender
{
    NSString *nibFile;
    
    if (self.subTicketLabel.text.length > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Already have sub ticket." delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    } else {
        
        if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
        {
            nibFile = AddTicketViewController_iPad;
        }else
        {
            nibFile = AddTicketViewController_iPhone;
        }
        
        AddTicketViewController *tAdd = [[AddTicketViewController alloc]initWithNibName:nibFile
                                                                                 bundle:nil];
        tAdd.ID = self.ticket.iD;
        [tAdd setTitle:@"Add Ticket"];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                               forView:[self.navigationController view]
                                 cache:NO];
        [self.navigationController pushViewController:tAdd animated:YES];
        [UIView commitAnimations];
        [tAdd release];
    }
}

-(IBAction)viewPicsButtonClicked:(id)sender
{
    NSString *nibFile;
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    {
        nibFile = @"PICSViewController_iPad";
    } else
    {
        nibFile = @"PICSViewController_iPhone";
    }
    
    PICSViewController *picsViewController = [[PICSViewController alloc] initWithNibName:nibFile bundle:nil];
    
    picsViewController.partDesc = self.partDescriptionTextField.text;
    picsViewController.confirmStatus = self.picsStatus;
    picsViewController.ticketId = self.ticket.iD;
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:[self.navigationController view]
							 cache:NO];
    [self.navigationController pushViewController:picsViewController animated:YES];
    
    [UIView commitAnimations];
    
    [picsViewController release];
}

-(NSString *) GetPicsStauts:(NSString *)ticketId
{
    NSString *address = [NSString stringWithFormat:@"http://%@/autotech/services/PicsConfirm.ashx?ticketId=%@&type=GetPics",ConnectionString, self.ticket.iD];
    NSURL *url = [NSURL URLWithString:address];
    
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfURL:url];
    
    return [result valueForKey:@"Confirmed"];
}

@end



