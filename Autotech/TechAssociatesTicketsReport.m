//
//  TechAssociatesTicketsReport.m
//  Autotech
//
//  Created by hz-yumec-mac on 2/27/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import "TechAssociatesTicketsReport.h"


@implementation TechAssociatesTicketsReport

@synthesize techID = _techID;
@synthesize fullName = _fullName;
@synthesize numberOfTickets = _numberOfTickets;

+ (id) TechAssociatesTicketsReportWithDictionary:(NSDictionary *)aDictionary
{
    TechAssociatesTicketsReport *t = [[[TechAssociatesTicketsReport alloc] init] autorelease];
    t.techID = [aDictionary valueForKey:@"TechID"];
    t.fullName = [aDictionary valueForKey:@"FullName"];
    t.numberOfTickets = [aDictionary valueForKey:@"NumberOfTickets"];
    return t;
}

- (void) dealloc
{
    [_techID release];
    [_fullName release];
    [_numberOfTickets release];
    [super dealloc];
}

@end
