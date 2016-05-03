//
//  ResultViewController.h
//  Autotech
//
//  Created by hz-yumec-mac on 2/27/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindViewController.h"

@interface ResultViewController : UITableViewController {
    FindViewController *_reportView;
    NSMutableArray *_tableViewArray;
    NSString  *_searchType;
}

@property (nonatomic, retain) FindViewController *reportView;
@property (nonatomic, retain) NSMutableArray *tableViewArray;
@property (nonatomic, retain) NSString *searchType;

- (id) initWithContent: (NSMutableArray *) tableViewArray : (NSString *) searchType;

@end
