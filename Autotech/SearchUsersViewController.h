//
//  SearchUsersViewController.h
//  Autotech
//
//  Created by hz-yumec-mac on 2/24/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTicketViewController.h"
#import "Users.h"

@interface SearchUsersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

    IBOutlet UIButton *cancelButton;
    IBOutlet UIButton *searchButton;
    IBOutlet UITextField *searchTextField;
    UIActivityIndicatorView *spinner;

    NSMutableArray *_users;
    UITableView *_tableView;
    AddTicketViewController *_addTicketViewController;
}

@property (nonatomic, retain) NSMutableArray *users;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) AddTicketViewController *addTicketViewController;

- (IBAction) closeView;
- (IBAction) searchUsers;

@end
