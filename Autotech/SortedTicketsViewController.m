//
//  SortedTicketsViewController.m
//  Autotech
//
//  Created by Yume Chen on 1/20/12.
//  Copyright 2011 Samtec. All rights reserved.


#import "SortedTicketsViewController.h"


@implementation SortedTicketsViewController

@synthesize sortedTicketsDictionary = _sortedTicketsDictionary;
@synthesize keys = _keys;
@synthesize spinner = _spinner;
@synthesize tableView = _tableView;
@synthesize sortedAreaTicketsSegmentedControl = _sortedAreaTicketsSegmentedControl;
@synthesize sortedPersonalTicketsSegementControl = _sortedPersonalTicketsSegementControl;

- (void) loadData
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    User *u = [(AutotechAppDelegate *) [[UIApplication sharedApplication] delegate] 
                         currentUser];
    NSString *address = [NSString stringWithFormat:@"http://%@/OpenTickets.ashx?techassocId=%@", ConnectionString, u.techID];

    NSURL *url = [NSURL URLWithString:address];
    NSArray *results = [NSArray arrayWithContentsOfURL:url];
    self.sortedTicketsDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    [self.sortedTicketsDictionary removeAllObjects];
//    NSInteger newTicketCount = 0;
   
//    for (NSDictionary *t in results) {
//        if ([[t objectForKey:@"statusDescription"] isEqualToString:@"New"]) {
//            newTicketCount++;
//        }
//    }

    switch (self.sortedAreaTicketsSegmentedControl.selectedSegmentIndex) {
        case 0: // sorted by date
            for (NSDictionary *t in results) {
                Ticket *t1 = [Ticket TicketWithDictionary:t];
                if ([self.sortedTicketsDictionary valueForKey:t1.dateEntered] != nil) {
                    [[self.sortedTicketsDictionary valueForKey:t1.dateEntered] addObject:t1];
                } else {
                    NSMutableArray *ticketsArray = [NSMutableArray arrayWithCapacity:1];
                    [ticketsArray addObject:t1];
                    [self.sortedTicketsDictionary setObject:ticketsArray forKey:t1.dateEntered];
                }
            }
            break;
        case 1: // sorted by priority/machine
            for (NSDictionary *t in results) {
                Ticket *t1 = [Ticket TicketWithDictionary:t];

                if (t1.priority.length > 0) {
                    if ([self.sortedTicketsDictionary valueForKey:t1.priority] != nil) {
                        [[self.sortedTicketsDictionary valueForKey:t1.priority] addObject:t1];
                    } else {
                        NSMutableArray *ticketsArray = [NSMutableArray arrayWithCapacity:1];
                        [ticketsArray addObject:t1];
                        [self.sortedTicketsDictionary setObject:ticketsArray forKey:t1.priority];
                    }
                } else {
                    if ([self.sortedTicketsDictionary valueForKey:t1.machine] != nil) {
                        [[self.sortedTicketsDictionary valueForKey:t1.machine] addObject:t1];
                    } else {
                        NSMutableArray *ticketsArray = [NSMutableArray arrayWithCapacity:1];
                        [ticketsArray addObject:t1];
                        [self.sortedTicketsDictionary setObject:ticketsArray forKey:t1.machine];
                    }
                }
            }
            break;
        case 2: // sort by category
            for (NSDictionary *t in results) {
                Ticket *t1 = [Ticket TicketWithDictionary:t];
                if ([self.sortedTicketsDictionary valueForKey:t1.category] != nil) {
                    [[self.sortedTicketsDictionary valueForKey:t1.category] addObject:t1];
                } else {
                    NSMutableArray *ticketsArray = [NSMutableArray arrayWithCapacity:1];
                    [ticketsArray addObject:t1];
                    [self.sortedTicketsDictionary setObject:ticketsArray forKey:t1.category];
                }
            }
            break;
        case 3: // sort by status
            for (NSDictionary *t in results) {
                Ticket *t1 = [Ticket TicketWithDictionary:t];
                if ([self.sortedTicketsDictionary valueForKey:t1.statusDescription] != nil) {
                    [[self.sortedTicketsDictionary valueForKey:t1.statusDescription] addObject:t1];
                } else {
                    NSMutableArray *ticketsArray = [NSMutableArray arrayWithCapacity:1];
                    [ticketsArray addObject:t1];
                    [self.sortedTicketsDictionary setObject:ticketsArray forKey:t1.statusDescription];
                }
            }
        default:
            break;
    }
    
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    [UIApplication sharedApplication].applicationIconBadgeNumber = newTicketCount;
    
//    UILocalNotification *episodeNotification = [[UILocalNotification alloc] init];
//    episodeNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:(10)];
//    episodeNotification.timeZone = [NSTimeZone defaultTimeZone];
//    episodeNotification.applicationIconBadgeNumber = newTicketCount;
//    
//    [[UIApplication sharedApplication] scheduleLocalNotification:episodeNotification];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = episodeNotification.applicationIconBadgeNumber ;
//    [episodeNotification release];
    
   
    self.keys = [[self.sortedTicketsDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
                 
    [self performSelectorOnMainThread:@selector(finish) withObject:nil waitUntilDone:NO];
    
    [pool release];
}

- (IBAction) segmentedControlIndexChanged 
{
    [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
}

- (void) finish
{
    [self.tableView reloadData];
    [self.spinner stopAnimating];
}

- (IBAction) handledAddTapped
{
    NSString *nibFile = [[NSString alloc] init];
    
    if (UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
        nibFile = AddTicketViewController_iPad;
    } else {
        nibFile = AddTicketViewController_iPhone;
    }
    
    AddTicketViewController *addTicket = [[AddTicketViewController alloc] initWithNibName:nibFile bundle:nil];
    
    [addTicket setTitle:@"Add Ticket"];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[self.navigationController view] cache:NO];
    [self.navigationController pushViewController:addTicket animated:YES];
    [UIView commitAnimations];
    [addTicket release];
    [nibFile release];
}

- (IBAction) handledRefreshTapped
{
    [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
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
    [_sortedTicketsDictionary release];
    [_keys release];
    [_spinner release];
    [_tableView release];
    [_sortedAreaTicketsSegmentedControl release];
    [_sortedPersonalTicketsSegementControl release];
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
    
    NSArray *sortedAreaTicketsItems = [NSArray arrayWithObjects:@"Date", @"Priority", @"Category", @"Status", nil];
    UISegmentedControl *areaSegmentedControl = [[UISegmentedControl alloc] initWithItems:sortedAreaTicketsItems];
    [areaSegmentedControl setSelectedSegmentIndex:0];
    self.sortedAreaTicketsSegmentedControl = areaSegmentedControl;
    [areaSegmentedControl release];
    [self.sortedAreaTicketsSegmentedControl addTarget:self action:@selector(segmentedControlIndexChanged) forControlEvents:UIControlEventValueChanged];
//    self.sortedAreaTicketsSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.sortedAreaTicketsSegmentedControl.tintColor = self.navigationController.navigationBar.tintColor;
    self.tableView.tableHeaderView = self.sortedAreaTicketsSegmentedControl;
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    self.sortedTicketsDictionary = nil;
    self.keys = nil;
    self.spinner = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{  
    [self.spinner startAnimating];
    
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];

    if (u == nil)
    {
        self.navigationItem.title = @"Open Tickets.";
        [[self sortedTicketsDictionary] removeAllObjects];
        [[self tableView] reloadData];
        
        LogonViewController *logon = [[[LogonViewController alloc] init] autorelease];
        [logon setModalPresentationStyle:UIModalPresentationFullScreen];
//        [logon setModalTransitionStyle:UIModalTransitionStylePartialCurl];
//        [logon setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//        [self presentModalViewController:logon animated:NO];
        [self.navigationController presentViewController:logon animated:NO completion:nil];
        u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:kLoadDataNotification object:nil];
        
        return;
    } 

    self.navigationItem.title = u.techName;
    [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
    
    [super viewWillAppear:animated];
}

- (void) loadData:(NSNotification *) note {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                              name:kLoadDataNotification object:nil];
    [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
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
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // return [self.dateEnteredDictionary count];
    return [self.keys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    id aKey = [self.keys objectAtIndex:indexPath.row];
    NSArray *currentArray = (NSArray *) [self.sortedTicketsDictionary objectForKey:aKey];
    
    if (self.sortedAreaTicketsSegmentedControl.selectedSegmentIndex == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[[[self.sortedTicketsDictionary objectForKey:aKey] objectAtIndex:0] valueForKey:@"machine"]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Open Tickets: %d", (int)[currentArray count]];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", aKey];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Open Tickets: %d", (int)[currentArray count]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row % 2 == 0)
	{
		UIColor *col = [UIColor colorWithRed:1.00 green:0.90 blue:0.80 alpha:1.0];
		cell.backgroundColor = col;
	}
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id aKey = [self.keys objectAtIndex:indexPath.row];
    NSMutableArray *currentArray = (NSMutableArray *) [self.sortedTicketsDictionary objectForKey:aKey];
    
    NSString *nibFile = [[NSString alloc] init];
    if (UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
        nibFile = TicketsViewController_iPad;
    } else {
        nibFile = TicketsViewController_iPhone;
    }
    
    TicketsViewController *ticketDetail = [[TicketsViewController alloc] initWithNibName:nibFile bundle:nil];
    
    ticketDetail.tickets = currentArray;
    if (self.sortedAreaTicketsSegmentedControl.selectedSegmentIndex == 1) {
        ticketDetail.title = [[[self.sortedTicketsDictionary objectForKey:aKey] objectAtIndex:0] valueForKey:@"machine"];
    } else {
        ticketDetail.title = aKey;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[self.navigationController view] cache:NO];
    [self.navigationController pushViewController:ticketDetail animated:YES];
    [UIView commitAnimations];
    
    [ticketDetail release];
    [nibFile release];
}

@end
