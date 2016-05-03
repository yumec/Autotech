//
//  SelectPartDescViewController.m
//  Autotech
//
//  Created by Yume Chen on 2/29/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import "SelectPartDescViewController.h"
#import "Constants.h"
#import "AutotechAppDelegate.h"
#import "MachinePriority.h"

@implementation SelectPartDescViewController

@synthesize machinesPriorities = _machinesPriorities;
@synthesize tableView = _tableView;
@synthesize cancelButton = _cancelButton;
@synthesize addTicketViewController = _addTicketViewController;

/*
- (id) initWithContent: (NSMutableArray *) tableViewArray {
    self.machinesPriorities = tableViewArray;
    [self init];
    [self.tableView reloadData];
    return self;
}
*/

- (id)init {
    NSString *nibFile;
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
        nibFile = @"SelectPartDescViewController_iPad";  
    }else {
        nibFile = @"SelectPartDescViewController_iPhone";
    }
    
    [super  initWithNibName:nibFile bundle:nil];
    return self;
}

- (void)dealloc
{
    [_machinesPriorities release];
    [_tableView release];
    [_cancelButton release];
    [_addTicketViewController release];
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
    [self.cancelButton setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"]
                                           stretchableImageWithLeftCapWidth:8.0f
                                           topCapHeight:0.0f]
                                 forState:UIControlStateNormal];
    
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
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
    [NSThread detachNewThreadSelector:@selector(loadPartDescription) toTarget:self withObject:nil];
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
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.machinesPriorities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.detailTextLabel.text = [[self.machinesPriorities objectAtIndex:indexPath.row] machineDesc];
    cell.textLabel.text = [[self.machinesPriorities objectAtIndex:indexPath.row] machinePriority];
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
    self.addTicketViewController.partDescTextField.text = [[self.machinesPriorities objectAtIndex:indexPath.row] machineDesc];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) closeView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) loadPartDescription
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString *workCenterID = [[(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser] plantID];
    
    NSString *address = [NSString stringWithFormat:@"http://%@/autotech/services/MachinePriority.ashx?plantid=%@",ConnectionString, workCenterID];
    
    NSURL *url = [NSURL URLWithString:address];
    NSArray *results = [NSArray arrayWithContentsOfURL:url];
    [self setMachinesPriorities:[NSMutableArray arrayWithCapacity:1]];
    [self.machinesPriorities removeAllObjects];
    
    
    for (NSDictionary *t in results)
    {
        MachinePriority *mp = [MachinePriority MachinePriorityWithDictionary:t];
        [self.machinesPriorities  addObject:mp];
    }
    
    [self performSelectorOnMainThread:@selector(finish) withObject:nil waitUntilDone:NO];
    
    [pool release];
}

- (void)finish
{
    [self.tableView reloadData];
}

@end
