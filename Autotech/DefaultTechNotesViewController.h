//
//  DefaultTechNotesViewController.h
//  Autotech
//
//  Created by Javier Jara on 7/14/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"
#import "TicketDetailViewController.h"

@interface DefaultTechNotesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *_defaultNotes;
    UITableView *_tableView;
    UIButton *_cancelButton;
    Ticket *_ticket;
    TicketDetailViewController *_ticketDetailViewController;
}

@property (nonatomic, retain) NSArray *defualtNotes;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) Ticket *ticket;
@property (nonatomic, retain) TicketDetailViewController *ticketDetailViewController;

- (IBAction) closeView;
- (void) loadDefaultNotes;

@end
