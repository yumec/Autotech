//
//  PICSViewController.h
//  Autotech
//
//  Created by yumec on 8/10/13.
//  Copyright (c) 2013 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "TicketDetailViewController.h"

@interface PICSViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *partDesc;
@property (nonatomic, retain) NSString *languageId;
@property (nonatomic, retain) IBOutlet UISegmentedControl *languageSegementedControl;
@property (nonatomic, retain) NSString *confirmStatus;
@property (nonatomic, retain) NSString *ticketId;
@property (nonatomic, retain) TicketDetailViewController *ticketDetail;

- (IBAction)languageSegementedControlIndexChanged:(id)sender;

@end
