//
//  TicketsViewController.h
//  Autotech-1
//
//  Created by Javier Jara on 5/10/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketDetailViewController.h"
#import "AddTicketViewController.h"
#import "Ticket.h"
#import "Constants.h"

@interface TicketsViewController : UITableViewController {
    NSMutableArray *_tickets;
    NSMutableArray *_ticketsNew;
    NSMutableArray *_ticketsInProc;
    UISegmentedControl *_statusSegmentedControl;
}

@property (nonatomic, retain) NSMutableArray *tickets;
@property (nonatomic, retain) NSMutableArray *ticketsNew;
@property (nonatomic, retain) NSMutableArray *ticketsInProc;
@property (nonatomic, retain) UISegmentedControl *statusSegmentedControl;

- (void) loadData;
- (void) loadDataFromTickets;
- (void) finish;
- (IBAction) handledAddTapped;
- (IBAction) segmentedControlIndexChanged;

-(NSString *) loadInProcessInfoByTicketId:(NSString *) ticketId;

@end
