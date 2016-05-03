//
//  ResultViewController.m
//  Autotech
//
//  Created by hz-yumec-mac on 2/27/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import "ResultViewController.h"


@implementation ResultViewController

@synthesize reportView = _reportView;
@synthesize tableViewArray = _tableViewArray;
@synthesize searchType = _searchType;

- (id) initWithContent:(NSMutableArray *)tableViewArray :(NSString *)searchType {
    [self init];
    self.tableViewArray = tableViewArray;
    self.searchType = searchType;
    [self.tableView reloadData];
    return self;
}

- (id)init {
    NSString *nibFile;
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
        nibFile = @"ResultViewController_iPad";  
    }else {
        nibFile = @"ResultViewController_iPhone";
    }
    
    [super  initWithNibName:nibFile bundle:nil];
    return self;
}

- (void)dealloc
{
    [_reportView release];
    [_tableViewArray release];
    [_searchType release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
//    temporaryBarButtonItem.title = @"Return";
//    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
//    [temporaryBarButtonItem release];
   
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Return" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSInteger totalNumberOfTickets = 0;
    if ([self.searchType isEqualToString:@"User"]) { // Search By User
        if ([self.tableViewArray count] > 0) {
            for (int i = 0; i <= [self.tableViewArray indexOfObject:[self.tableViewArray lastObject]]; i++) {
                totalNumberOfTickets += [[[self.tableViewArray objectAtIndex:i] numberOfTickets] intValue];
            }
        }
    } else if ([self.searchType isEqualToString:@"Machine"]) { // Search By Machine
        if ([self.tableViewArray count] > 0) {
            for (int i = 0; i <= [self.tableViewArray indexOfObject:[self.tableViewArray lastObject]]; i++) {
                totalNumberOfTickets += [[[self.tableViewArray objectAtIndex:i] totals] intValue];
            }
        }
    }

    NSArray *statusItems = [NSArray arrayWithObjects:[NSString stringWithFormat:@"Total Number Of Tickets: %d", (int)totalNumberOfTickets], nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:statusItems];
//    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.tintColor =  [UIColor orangeColor];
    self.tableView.tableHeaderView = segmentedControl;
    [segmentedControl release];
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
    return [self.tableViewArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice] userInterfaceIdiom]) {
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
        [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    } else {
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        }
    }
    
    if ([self.searchType isEqualToString:@"User"]) { // Search By User
        NSString *text = [NSString stringWithFormat:@"%@ (TechID: %@)", [[self.tableViewArray objectAtIndex:indexPath.row] fullName], [[self.tableViewArray objectAtIndex:indexPath.row] techID]];
        cell.textLabel.text = text;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of Tickets: %@", [[self.tableViewArray objectAtIndex:indexPath.row] numberOfTickets]];
    } else if ([self.searchType isEqualToString:@"Machine"]) { // Search By Machine
        
        cell.textLabel.text = [[self.tableViewArray objectAtIndex:indexPath.row] machineDesc];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of Tickets: %@", [[self.tableViewArray objectAtIndex:indexPath.row] totals]];
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

- (void) backAction
{
    FindViewController *f = [[FindViewController alloc] init];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    
    [self.navigationController pushViewController:f animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[self.navigationController view] cache:NO];
//    [self.navigationController pushViewController:f animated:YES];
//    [UIView commitAnimations];
    
    [f release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
