//
//  PrioritiesViewController.h
//  Autotech
//
//  Created by Javier Jara on 8/11/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PrioritiesViewController : UITableViewController {
    NSMutableArray * _machinePriorities;
    UITableView *_tableView;
    NSArray *_keys;
}

@property (nonatomic, retain) NSMutableArray *machinesPriorities;
@property (nonatomic, retain) NSArray *keys;
- (void) loadData;
- (void)finish;
@end
