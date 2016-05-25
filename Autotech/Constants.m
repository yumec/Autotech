//
//  Constants.m
//  Autotech-2
//
//  Created by Javier Jara on 5/17/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "Constants.h"

@implementation Constants

#ifdef IS_LIVE
    NSString * const ConnectionString = @"sgnapp";
#elif IS_STAG
    NSString * const ConnectionString = @"sgnstage";
#elif IS_TEST
    NSString * const ConnectionString = @"sgntest";
#elif IS_DEV
    NSString * const ConnectionString = @"sgndev";
#endif

NSString * const TicketDeatilViewController_Iphone = @"TicketDetailViewController_iPhone";
NSString * const AddTicketViewController_iPhone = @"AddTicketViewController_iPhone";

NSString * const TicketDeatilViewController_Ipad = @"TicketDetailViewController_iPad";
NSString * const AddTicketViewController_iPad = @"AddTicketViewController_iPad";

NSString * const TicketsViewController_iPad = @"TicketsViewController_iPad";
NSString * const TicketsViewController_iPhone = @"TicketsViewController_iPhone";
NSString * const TechMoldAdmin = @"Mold Process";
NSString * const TechHDRAdmin = @"HDR1";
NSString * const TechAutomationAdmin = @"dc002";

NSString * cStatusNew = @"New"; 
NSString * cStatusInProcess = @"In-Process";
NSString * cStatusClosed = @"Closed"; 

@end