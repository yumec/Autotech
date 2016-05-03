//
//  SelectPartDescViewController.h
//  Autotech
//
//  Created by Yume Chen on 2/29/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTicketViewController.h"

@interface SelectPartDescViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_machinesPriorities;
    UITableView *_tableView;
    UIButton *_cancelButton;
    AddTicketViewController *_addTicketViewController;
}

@property (nonatomic, retain) NSMutableArray *machinesPriorities;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) AddTicketViewController *addTicketViewController;

- (void) loadPartDescription;
- (IBAction) closeView;
- (void)finish;
//- (id) initWithContent: (NSMutableArray *) tableViewArray;

@end
