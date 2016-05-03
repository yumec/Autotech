//
//  DefaultTechNotesViewController.m
//  Autotech
//
//  Created by Javier Jara on 7/14/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "DefaultTechNotesViewController.h"
#import "User.h"
#import "AutotechAppDelegate.h"
#import "Constants.h"


@implementation DefaultTechNotesViewController

@synthesize 
defualtNotes = _defaultNotes, 
tableView = _tableView, 
cancelButton = _cancelButton, 
ticket = _ticket,
ticketDetailViewController = _ticketDetailViewController;

- (id)init {
    NSString *nibFile;
    if(UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom])
    {
        nibFile = @"DefaultTechNotesViewController_iPad";

    }else
    {
        nibFile = @"DefaultTechNotesViewController_iPhone";
    }
    
    [super  initWithNibName:nibFile bundle:nil];
    return self;
}



- (void)dealloc
{
    [_defaultNotes release];
    [_tableView release];
    [_cancelButton release];
    [_ticket release];
    [_ticketDetailViewController release];
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
    [self loadDefaultNotes];
    [self.cancelButton setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"]
                                           stretchableImageWithLeftCapWidth:8.0f
                                           topCapHeight:0.0f]
                                 forState:UIControlStateNormal];
    
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
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
    return [[self defualtNotes]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [[cell textLabel] setText:[[[self defualtNotes] objectAtIndex:indexPath.row] description]];
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self ticket] setTechNotes: [[[self defualtNotes] objectAtIndex:indexPath.row] description]];
    self.ticketDetailViewController.didSelectedTech = YES;
    self.ticketDetailViewController.didSelectedMachine = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Programmer methods 

- (IBAction) closeView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) loadDefaultNotes{
    
    NSString *techID = [[(AutotechAppDelegate *) [[UIApplication sharedApplication] delegate] currentUser] techID];
    
    NSString *techAreaID = @"0";
    
    if ([techID isEqualToString:@"227"]) {
        techAreaID = @"1";
    } else if ([techID isEqualToString:@"154"]) {
        techAreaID = @"2";
    } else if ([techID isEqualToString:@"31"]) {
        techAreaID = @"3";
    }
    
    NSString *defaultTechNotesAddress = [NSString stringWithFormat:@"http://%@/autotech/services/DefaultTechNotes.ashx?TechAreaID=%@", ConnectionString , techAreaID];
    NSURL *defaultTechNotesUrl = [NSURL URLWithString:defaultTechNotesAddress];
    NSArray *defaultTechNotesResults = [NSArray arrayWithContentsOfURL:defaultTechNotesUrl];
    [self setDefualtNotes:[NSMutableArray arrayWithCapacity:[defaultTechNotesResults count]]];
    self.defualtNotes = [defaultTechNotesResults valueForKey:@"Description"];
    
    [self.tableView reloadData];
}

@end
