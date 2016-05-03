//
//  ComboBoxWithSearchBarViewController.m
//  Autotech
//
//  Created by Javier Jara on 7/27/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "ViewWithSearchBarViewController.h"

#import "Machine.h"
#import "TicketCategory.h"
#import "Location.h"

@implementation ViewWithSearchBarViewController


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;


@synthesize tableViewArray = _tableViewArray, 
tableView = _tableView,
cancelButton = _cancelButton, 
addTicketViewController = _addTicketViewController,
ticketDetailViewController = _ticketDetailViewController,
settingsViewController = _settingsViewController,
listOfItemsCopy = _listOfItemsCopy,
ovController = _ovController,
searchType = _searchType,
searchView = _searchView,
viewTitle = _viewTitle;

- (id) initWithContent: (NSMutableArray *) tableViewArray AndSearchType:(NSUInteger *)searchType AndSearchView:(NSUInteger *)searchView {
    [self init];
    [self setTableViewArray:tableViewArray];
    [self setSearchType:searchType];
    [self setSearchView:searchView];
    [[self tableView]reloadData];
    return self;
}

- (id)init {
    NSString *nibFile;
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
        nibFile = @"ViewWithSearchBarViewController_iPad";
    }else {
        nibFile = @"ViewWithSearchBarViewController_iPhone";
    }
    
    [super  initWithNibName:nibFile bundle:nil];
    return self;
}

- (void)dealloc
{

    [_cancelButton release];
    [_tableViewArray release];
    [_tableView release];
    [_addTicketViewController release];
    [_ticketDetailViewController release];
    [_settingsViewController release];
    [_ovController release];
    [_listOfItemsCopy release];
    [_viewTitle release];
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

    [self.cancelButton setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"]
                                           stretchableImageWithLeftCapWidth:8.0f
                                           topCapHeight:0.0f]
                                 forState:UIControlStateNormal];
    
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
  //  NSDictionary *tableViewDictionary = [NSDictionary dictionaryWithObject:self.tableViewArray forKey:@"machineDescription"];
    
   // copyListOfItems = [[NSMutableArray alloc] init];
    
    switch (self.searchType) {
        case 1:
            self.viewTitle.text = @"Select Machine";
            break;
        case 2:
            self.viewTitle.text = @"Select Category";
            break;
        case 3:
            self.viewTitle.text = @"Select Location";
            break;
        case 4:
            self.viewTitle.text = @"Select Tech Associates";
            break;
        default:
            break;
    }
    searching = NO;
    letUserSelectRow = YES;
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
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
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searching) {
        return [[self listOfItemsCopy] count];
    } else {
        return [[self tableViewArray ] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    switch (self.searchType) {
        case 1: // Machines
            if(searching)
            {
                [[cell textLabel] setText: [[[self listOfItemsCopy] objectAtIndex:indexPath.row] machineDescription]];
            }
            else
            {
                [[cell textLabel] setText:[[[self tableViewArray] objectAtIndex:indexPath.row] machineDescription]];
            }
            break;
        case 2: // Categories
            if(searching)
            {
                [[cell textLabel] setText: [[[self listOfItemsCopy] objectAtIndex:indexPath.row] categoryDescription]];
            }
            else
            {
                [[cell textLabel] setText:[[[self tableViewArray] objectAtIndex:indexPath.row] categoryDescription]];
            }
            break;
        case 3: // Location
            if(searching)
            {
                [[cell textLabel] setText: [[[self listOfItemsCopy] objectAtIndex:indexPath.row] locationDescription]];
            }
            else
            {
                [[cell textLabel] setText:[[[self tableViewArray] objectAtIndex:indexPath.row] locationDescription]];
            }
            break;
        case 4: // Techs
            if(searching)
            {
                [[cell textLabel] setText: [[[self listOfItemsCopy] objectAtIndex:indexPath.row] techFullName]];
            }
            else
            {
                [[cell textLabel] setText:[[[self tableViewArray] objectAtIndex:indexPath.row] techFullName]];
            }
            break;
        default:
            break;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.searchType) {
        case 1:
            {
                Machine *selectedItem = nil;
                if(searching)
                {
                    selectedItem = [[self listOfItemsCopy] objectAtIndex:indexPath.row];
                }
                else
                {
                    selectedItem = [[self tableViewArray] objectAtIndex:indexPath.row];
                }
                if (self.searchView == 1) {
                    [self didSelectedItem];
                    [[self addTicketViewController] setMachineForTicket: selectedItem];
                } else
                {
                    [self didSelectedItem];
                    [[self ticketDetailViewController] setMachineForTicket: selectedItem];
                }
                
            }
            break;
        case 2:
        {
            TicketCategory *selectedItem = nil;
            if(searching)
            {
                selectedItem = [[self listOfItemsCopy] objectAtIndex:indexPath.row];
            }
            else
            {
                selectedItem = [[self tableViewArray] objectAtIndex:indexPath.row];
            }
            if (self.searchView == 1) {
                [self didSelectedItem];
                [[self addTicketViewController ] setCategoryForTicket: selectedItem];
            } else
            {
                [self didSelectedItem];
                [[self ticketDetailViewController] setCategoryForTicket:selectedItem];
            }
            
        }
            break;
        case 3:
        {
            Location *selectedItem = nil;
            if(searching)
            {
                selectedItem = [[self listOfItemsCopy] objectAtIndex:indexPath.row];
            }
            else
            {
                selectedItem = [[self tableViewArray] objectAtIndex:indexPath.row];
            }
            if (self.searchView == 1) {
                [[self addTicketViewController] setLocationForTicket: selectedItem];
            } else
            {
                [[self ticketDetailViewController ] setLocationForTicket: selectedItem];
            }
            
        }
            break;
        case 4:
        {
            Techs *selectedItem = nil;
            if(searching)
            {
                selectedItem = [[self listOfItemsCopy] objectAtIndex:indexPath.row];
            }
            else
            {
                selectedItem = [[self tableViewArray] objectAtIndex:indexPath.row];
            }
            if (self.searchView == 1) {
                [self didSelectedItem];
                [[self addTicketViewController] setTechForTicket:selectedItem];
            } else if (self.searchView == 2) {
                [self didSelectedItem];
                [[self ticketDetailViewController] setTechForTicket: selectedItem];
            } else if(self.searchView == 3) {
                [self.settingsViewController setTechForUser:selectedItem];
            }
        }
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) didSelectedItem
{
    self.ticketDetailViewController.didSelectedMachine = YES;
    self.ticketDetailViewController.didSelectedTech = YES;
    self.addTicketViewController.didSelectedMachine = YES;
    self.addTicketViewController.didSelectedTech = YES;
}

- (NSIndexPath *)tableView :(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(letUserSelectRow)
        return indexPath;
    else
        return nil;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	if (indexPath.row % 2 == 0)
//	{
//		UIColor *col = [UIColor colorWithRed:1.00 green:0.90 blue:0.80 alpha:1.0];
//		cell.backgroundColor = col;
//	}
//}

#pragma mark - Programmer Messages 

- (IBAction) closeView {
    [self didSelectedItem];
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark UISearchBar Delegate 

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    
    // Slide up the view 
    
    //UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(UIUserInterfaceIdiomPad != [[UIDevice currentDevice] userInterfaceIdiom]) 
    {
        
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y -= 85;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [self.view setFrame:viewFrame];
        
        [UIView commitAnimations];
    }

    theSearchBar.showsCancelButton = YES;
    if(self.ovController == nil)
        self.ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayView" bundle:[NSBundle mainBundle]];
    
    CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    //Parameters x = origion on x-axis, y = origon on y-axis.
    CGRect frame = CGRectMake(0, yaxis, width, height);
    self.ovController.view.frame = frame;
    self.ovController.view.backgroundColor = [UIColor grayColor];
    self.ovController.view.alpha = 0.5;
    
    self.ovController.rvController = self;
    
    [self.tableView insertSubview:self.ovController.view aboveSubview:self.parentViewController.view];
    
   // searching = YES;
    letUserSelectRow = NO;
    self.tableView.scrollEnabled = NO;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)theSearchBar {
    theSearchBar.showsCancelButton = NO;
    searching = NO;
    
    if(UIUserInterfaceIdiomPad != [[UIDevice currentDevice] userInterfaceIdiom]) 
    {
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y += 85;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [self.view setFrame:viewFrame];
        
        [UIView commitAnimations];
    }
} 

#pragma mark - UISearchBar Messages


- (void) searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText 
{
    
    //Remove all objects first.
    [[self listOfItemsCopy] removeAllObjects];
    
    if([searchText length] > 0) {
        [self.ovController.view removeFromSuperview];
        searching = YES;
        letUserSelectRow = YES;
        self.tableView.scrollEnabled = YES;
        [self searchTableView];
    }
    else {
        [self.tableView insertSubview:self.ovController.view aboveSubview:self.parentViewController.view];
        searching = NO;
        letUserSelectRow = NO;
        self.tableView.scrollEnabled = NO;
        [searchBar resignFirstResponder];
    }
    
    [self.tableView reloadData];
}

- (void) searchTableView {
    
    NSString *searchText = searchBar.text;
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    switch (self.searchType) {
        case 1:
            for (Machine *m in self.tableViewArray)
            {
                // NSArray *array = [dictionary objectForKey:@"Countries"];
                [searchArray addObject:[m machineDescription]];// addObjectsFromArray:array];
            }
            break;
        case 2:
            for (TicketCategory *c in self.tableViewArray) {
                [searchArray addObject:[c categoryDescription]];
            }
            break;
        case 3:
            for (Location *l in self.tableViewArray) {
                [searchArray addObject:[l locationDescription]];
            }
            break;
        case 4:
            for (Techs *t in self.tableViewArray) {
                [searchArray addObject:[t techFullName]];
            }
            break;
        default:
            break;
    }
        

//    for (int a= 0; a < searchArray.count; a++){
//        NSRange titleResultsRange = [[searchArray objectAtIndex:a] rangeOfString:searchText options:NSCaseInsensitiveSearch];
//        if (titleResultsRange.length > 0)
//            
//           
//            [[self copyListOfItems] addObject:[self.tableViewArray objectAtIndex:a]];
//    }
    
  [self setListOfItemsCopy: [NSMutableArray arrayWithCapacity:[searchArray count]]];
    for (NSString *sTemp in searchArray)
    {
        NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (titleResultsRange.length > 0)
            [[self listOfItemsCopy] addObject:[self.tableViewArray objectAtIndex:[searchArray indexOfObject:sTemp]]];
    }
    
    [searchArray release];
    searchArray = nil;
}

- (void) doneSearching_Clicked:(id) sender {
    
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    
    letUserSelectRow = YES;
    searching = NO;
   // self.navigationItem.rightBarButtonItem = nil;
    self.tableView.scrollEnabled = YES;
    [self.ovController.view removeFromSuperview];
    [self.ovController release];
    self.ovController = nil;
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar
{
    [self doneSearching_Clicked:theSearchBar];
}

@end
