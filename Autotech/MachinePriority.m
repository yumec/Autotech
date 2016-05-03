//
//  MachinePriority.m
//  Autotech
//
//  Created by Javier Jara on 8/12/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "MachinePriority.h"


@implementation MachinePriority
@synthesize machineDesc = _machineDesc, machinePriority = _machinePriority;


+(id)MachinePriorityWithDictionary:(NSDictionary *)aDictionary
{
    
    MachinePriority *mp = [[[MachinePriority alloc] init]autorelease];
    [mp setMachineDesc:[aDictionary valueForKey:@"MachineDesc"]];
    [mp setMachinePriority:[aDictionary valueForKey:@"Priority"]];
    return mp;
}

- (void) dealloc {
    [_machineDesc release];
    [_machinePriority release];
    [super dealloc];
}

@end
