#import "TicketsViewController.h"
#import "TicketActivity.h"

@implementation TicketsViewController

@synthesize 
tickets = _tickets,
ticketsNew = _ticketsNew, 
ticketsInProc = _ticketsInProc,
statusSegmentedControl = _statusSegmentedControl;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{

    [_tickets release];
    [_ticketsNew release];
    [_ticketsInProc release];
    [_statusSegmentedControl release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *statusItems = [NSArray arrayWithObjects:@"All", @"New", @"InProc", nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:statusItems];
    [segmentedControl setSelectedSegmentIndex:0];
    [self setStatusSegmentedControl:segmentedControl];
    
    [segmentedControl release];

    [self.statusSegmentedControl addTarget:self action:@selector(segmentedControlIndexChanged) forControlEvents:UIControlEventValueChanged];
//    self.statusSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.statusSegmentedControl.tintColor = self.navigationController.navigationBar.tintColor;
    self.tableView.tableHeaderView = self.statusSegmentedControl;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
    if (!u){
        [self.navigationController  popToRootViewControllerAnimated:YES];
    }else{
        if (!self.tickets){
            [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
        }else {
            [NSThread detachNewThreadSelector:@selector(loadDataFromTickets) toTarget:self withObject:nil];
        }
    }
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch ([[self statusSegmentedControl] selectedSegmentIndex]) {
        case 0:
   return [[self tickets] count];  
            break;
        case 1:
             return [[self ticketsNew] count];
            break;
        case 2: 
             return [[self ticketsInProc] count];
            break;
        default:
            return 0;
            break;
    }
}


#pragma mark - Table view delegate



- (void) loadData
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    if (!self.tickets) {
        
    NSString *address = [NSString stringWithFormat:@"http://%@/autotech/services/OpenTickets.ashx", ConnectionString];
    NSURL *url = [NSURL URLWithString:address];
    NSArray *results = [NSArray arrayWithContentsOfURL:url];
    [self setTickets:[NSMutableArray arrayWithCapacity:[results count]]];
    [self setTicketsNew:[NSMutableArray arrayWithCapacity:[results count]]];
    [self setTicketsInProc:[NSMutableArray arrayWithCapacity:[results count]]];
    
    for (NSDictionary *t in results)
    {
        [[self tickets] addObject:[Ticket TicketWithDictionary:t]];
        if ([[t valueForKey:@"statusDescription"]isEqualToString:cStatusNew] )  { 
            [[self ticketsNew] addObject:[Ticket TicketWithDictionary:t]];
        }else {
            [[self ticketsInProc] addObject:[Ticket TicketWithDictionary:t]];        
        }
    }
    }
    
    [self performSelectorOnMainThread:@selector(finish) withObject:nil waitUntilDone:NO];
        
    [pool release];
}

- (void) loadDataFromTickets{    
     NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self setTicketsInProc:[NSMutableArray arrayWithCapacity:1]];
    [self setTicketsNew:[NSMutableArray arrayWithCapacity:1]];
    
    for (Ticket *t in self.tickets){
        if ([t.statusDescription isEqualToString:cStatusNew]){
            [[self ticketsNew] addObject:t];
        } else {
            [[self ticketsInProc] addObject:t];
        }
    }
 
    [self performSelectorOnMainThread:@selector(finish) withObject:nil waitUntilDone:NO];
    
    [pool release];

}

- (void)finish
{
    [[self tableView] reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    Ticket *t ;
    switch ([[self statusSegmentedControl] selectedSegmentIndex]) {
        case 0:
             t = [[self tickets] objectAtIndex:[indexPath row]];
            break;
        case 1:
             t = [[self ticketsNew] objectAtIndex:[indexPath row]];
            break;
        case 2: 
             t = [[self ticketsInProc] objectAtIndex:[indexPath row]];
            break;
        default:
            break;
    }
    
    NSString *title;
//    if (t.subTicketId.length > 0) {
//        title = [NSString stringWithFormat:@"%@ (%@)(%@)", t.machine, t.partDescription, t.subTicketId];
//    } else {
//        title = [NSString stringWithFormat:@"%@ (%@)", t.machine, t.partDescription];
//    }
    
    title = [NSString stringWithFormat:@"%@ (%@)", t.machine, t.partDescription];
    
    cell.textLabel.text = title;
    
    NSString *ticketInfo = [self loadInProcessInfoByTicketId:t.iD];
    if (ticketInfo.length > 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"(%@) %@", ticketInfo, t.issueDescription];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", t.issueDescription];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    Ticket *selectedTicket;
    switch ([self.statusSegmentedControl selectedSegmentIndex]) {
        case 0: // all 
            selectedTicket = [[self tickets] objectAtIndex:[indexPath row]];
            break;
        case 1: // New
            selectedTicket = [[self ticketsNew] objectAtIndex:[indexPath row]];
            break;
        case 2:
            selectedTicket = [[self ticketsInProc] objectAtIndex:[indexPath row]];
            break;
        default:
            break;
    }
    
    NSString *nibFile;
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    {
        nibFile = TicketDeatilViewController_Ipad; 
    } else
    {
        nibFile = TicketDeatilViewController_Iphone;
    }
    
    TicketDetailViewController *tDetail = [[TicketDetailViewController alloc]initWithNibName:nibFile 
                                                                                      bundle:nil];
    [tDetail setTicket:selectedTicket];
    [tDetail setParentTickets:self.tickets];
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:[self.navigationController view]
							 cache:NO];
    tDetail.title = selectedTicket.machine; 
    
    [self.navigationController pushViewController:tDetail animated:YES];
	[UIView commitAnimations];
    
    [tDetail release];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row % 2 == 0)
	{
		UIColor *col = [UIColor colorWithRed:1.00 green:0.90 blue:0.80 alpha:1.0];
		cell.backgroundColor = col;
	}
}

- (IBAction) handledAddTapped{
    NSString *nibFile = [[NSString alloc]init];
    
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    {
        nibFile = AddTicketViewController_iPad;
    }else
    {
        nibFile = AddTicketViewController_iPhone;
    }
    
    AddTicketViewController *tAdd = [[AddTicketViewController alloc]initWithNibName:nibFile 
                                                                                      bundle:nil];
    [tAdd setTitle:@"Add Ticket"];
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:[self.navigationController view]
							 cache:NO];
    [self.navigationController pushViewController:tAdd animated:YES];
	[UIView commitAnimations];
    [tAdd release];
    [nibFile release];

}

- (IBAction) segmentedControlIndexChanged 
{
    [[self tableView] reloadData];
}

-(NSString *) loadInProcessInfoByTicketId:(NSString *)ticketId 
{
    NSString *ticketInfo = @"";
    NSString *address = [NSString stringWithFormat:@"http://%@/autotech/services/InProcessInfo.ashx?hdTicketId=%@", ConnectionString, ticketId];
    NSURL *url = [NSURL URLWithString:address];
    NSDictionary *results = [NSDictionary dictionaryWithContentsOfURL:url];
    
    if (results){
        TicketActivity *tc = [TicketActivity TicketActivityWithDictionary:results];
        if ([tc.description isEqualToString:@"Created"]) {
//            ticketInfo = [NSString stringWithFormat:@"Create by: %@", [tc enteredBy]];
            ticketInfo = @"";
        } else if ([tc.description isEqualToString:@"Paused"]){
            ticketInfo = [NSString stringWithFormat:@"Paused by: %@", [tc enteredBy]];
        }else if ([tc.description isEqualToString:@"In Process"]) {
            ticketInfo = [NSString stringWithFormat:@"In Process by: %@", [tc enteredBy]];
        } else {
            ticketInfo = @"";
        }
    }
    return ticketInfo;
}

@end
