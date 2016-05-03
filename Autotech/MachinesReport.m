//
//  MachinesReport.m
//  Autotech
//
//  Created by hz-yumec-mac on 6/9/12.
//  Copyright (c) 2012 Samtec. All rights reserved.
//

#import "MachinesReport.h"

@implementation MachinesReport

@synthesize machineDesc = _machineDesc;
@synthesize totals = _totals;

+ (id) MachinesReportWithDictionary:(NSDictionary *)aDictionary
{
    MachinesReport *m = [[[MachinesReport alloc] init] autorelease];
    m.machineDesc = [aDictionary valueForKey:@"Machine_Desc"];
    m.totals = [aDictionary valueForKey:@"Totals"];
    return m;
}

- (void) dealloc
{
    [_machineDesc release];
    [_totals release];
    
    [super dealloc];
}

@end
