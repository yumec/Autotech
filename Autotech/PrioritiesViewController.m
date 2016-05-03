//
//  PrioritiesViewController.m
//  Autotech
//
//  Created by Javier Jara on 8/11/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "PrioritiesViewController.h"
#import "Constants.h"
#import "MachinePriority.h"
#import "AutotechAppDelegate.h"

@implementation PrioritiesViewController

@synthesize machinesPriorities = _machinePriorities, keys = _keys;


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
    [_machinePriorities release];
    [_keys release];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];

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
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [[self machinesPriorities]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
     [[cell  detailTextLabel] setText:[[[self machinesPriorities] objectAtIndex:indexPath.row] machineDesc]];
     [[cell textLabel] setText:[[[self machinesPriorities] objectAtIndex:indexPath.row] machinePriority]];
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}


#pragma  mark programmer messages 


- (void) loadData
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString *workCenterId = [[(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser] plantID];

    NSString *address = [NSString stringWithFormat:@"http://%@/autotech/services/MachinePriority.ashx?plantid=%@",ConnectionString, workCenterId];
    
    NSURL *url = [NSURL URLWithString:address];
    NSArray *results = [NSArray arrayWithContentsOfURL:url];
    [self setMachinesPriorities:[NSMutableArray arrayWithCapacity:1]];
    [self.machinesPriorities removeAllObjects];
    
    
    for (NSDictionary *t in results)
    {
        MachinePriority *mp = [MachinePriority MachinePriorityWithDictionary:t];
        [self.machinesPriorities  addObject:mp];
    }
        //self.keys = [self.machinesPriorities allKeys];
    [self performSelectorOnMainThread:@selector(finish) withObject:nil waitUntilDone:NO];
    
    [pool release];
} 


- (void)finish
{
    [[self tableView] reloadData];
}

@end
