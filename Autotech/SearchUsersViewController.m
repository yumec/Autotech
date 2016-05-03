//
//  SearchUsersViewController.m
//  Autotech
//
//  Created by hz-yumec-mac on 2/24/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import "SearchUsersViewController.h"

@implementation SearchUsersViewController

@synthesize users = _users;
@synthesize tableView = _tableView;
@synthesize addTicketViewController = _addTicketViewController;

- (id)init {
    NSString *nibFile;
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
        nibFile = @"SearchUsersViewController_iPad";  
    }else {
        nibFile = @"SearchUsersViewController_iPhone";
    }
    
    [super  initWithNibName:nibFile bundle:nil];
    return self;
}

- (void)dealloc
{
    [cancelButton release];
    [searchButton release];
    [searchTextField release];
    [spinner release];
    
    [_users release];
    [_tableView release];
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
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [spinner setCenter:CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height / 3)];
    [self.view addSubview:spinner];
    
    [cancelButton setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    searchButton.titleLabel.shadowColor = [UIColor lightGrayColor];
    searchButton.titleLabel.shadowOffset = CGSizeMake(0, -1);

    [searchButton setBackgroundImage:[[UIImage imageNamed:@"iPhone_Orange_Button.png"]
                                                   stretchableImageWithLeftCapWidth:8.0f
                                                   topCapHeight:0.0f]
                                         forState:UIControlStateNormal];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ / %@",[[self.users objectAtIndex:indexPath.row] fullName], [[self.users objectAtIndex:indexPath.row] userMasterID]];
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
    self.addTicketViewController.userForTicket = [self.users objectAtIndex:indexPath.row];
    self.addTicketViewController.didSelectedMachine = YES;
    self.addTicketViewController.didSelectedTech = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction) searchUsers
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [spinner startAnimating];
    
    [self.users removeAllObjects];
    
    NSString *usersAddress = [NSString stringWithFormat:@"http://%@/autotech/services/SearchUsers.ashx?option=%@", ConnectionString, searchTextField.text];
    NSArray *usersResult = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:usersAddress]];
    [self setUsers:[NSMutableArray arrayWithCapacity:[usersResult count]]];
    for (NSDictionary *u in usersResult) {
        [self.users addObject:[Users UsersWithDictionary:u]];
    }
    
    [self.tableView reloadData];
    
    [spinner stopAnimating];
    [searchTextField resignFirstResponder];
    [pool release];
}

- (IBAction) closeView
{
    self.addTicketViewController.didSelectedMachine = YES;
    self.addTicketViewController.didSelectedTech = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
