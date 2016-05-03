//
//  SortedTicketsViewController.h
//  Autotech
//
//  Created by Yumec Chen on 1/20/12.
//  Copyright 2012 Samtec. All rights reserved.


#import <UIKit/UIKit.h>
#import "Ticket.h"
#import "User.h"
#import "LogonViewController.h"
#import "AutotechAppDelegate.h"
#import "AddTicketViewController.h"
#import "TicketsViewController.h"

@interface SortedTicketsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableDictionary *_sortedTicketsDictionary;
    NSArray *_keys;
    UIActivityIndicatorView *_spinner;
    UITableView *_tableView;
    UISegmentedControl *_sortedAreaTicketsSegmentedControl;
    UISegmentedControl *_sortedPersonalTicketsSegementControl;
}

@property (nonatomic, retain) NSMutableDictionary *sortedTicketsDictionary;
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sortedAreaTicketsSegmentedControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sortedPersonalTicketsSegementControl;

- (void) loadData;
- (IBAction) handledAddTapped;
- (IBAction) handledRefreshTapped;
- (IBAction) segmentedControlIndexChanged;

@end
