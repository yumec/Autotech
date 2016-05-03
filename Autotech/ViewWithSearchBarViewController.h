//
//  ComboBoxWithSearchBarViewController.h
//  Autotech
//
//  Created by Javier Jara on 7/27/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"
#import "AddTicketViewController.h"
#import "TicketDetailViewController.h"
#import "SettingsViewController.h"
#import "OverlayViewController.h"

@interface ViewWithSearchBarViewController : UIViewController <UISearchBarDelegate> {
    NSMutableArray *_tableViewArray;
    NSMutableArray *_listOfItemsCopy;
    OverlayViewController *_ovController;
    UITableView *_tableView;
    //  UIButton *_selectButton;
    UIButton *_cancelButton;
    IBOutlet UISearchBar *searchBar;
    BOOL searching;
    BOOL letUserSelectRow;
    AddTicketViewController *_addTicketViewController;
    TicketDetailViewController *_ticketDetailViewController;
    SettingsViewController *_settingsViewController;
    CGFloat animatedDistance;
    NSUInteger _searchType;
    NSUInteger _searchView;
    UILabel *_viewTitle;
}

@property (nonatomic, retain) NSMutableArray *tableViewArray;
@property (nonatomic, retain) NSMutableArray *listOfItemsCopy;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
//@property (nonatomic, retain) IBOutlet UIButton *selectButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) AddTicketViewController *addTicketViewController;
@property (nonatomic, retain) TicketDetailViewController *ticketDetailViewController;
@property (nonatomic, retain) SettingsViewController *settingsViewController;
@property (nonatomic, retain) OverlayViewController *ovController;
@property (nonatomic, assign) NSUInteger searchType;
@property (nonatomic, assign) NSUInteger searchView;
@property (nonatomic, retain) IBOutlet UILabel *viewTitle;

- (void) doneSearching_Clicked: (id) sender;
- (id) initWithContent:(NSMutableArray *) tableViewArray AndSearchType: (NSUInteger *) searchType AndSearchView: (NSUInteger *) searchView;
- (IBAction) closeView;
- (void) searchTableView;

@end
