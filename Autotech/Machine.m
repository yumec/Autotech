//
//  Machine.m
//  Autotech
//
//  Created by Javier Jara on 6/7/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "Machine.h"


@implementation Machine

@synthesize machineId = _machineId, machineDescription = _machineDescription;

- (void) dealloc {
    [_machineDescription release];
    [_machineId release];
    [super dealloc];
}


+(id) machineWithDictionary:(NSDictionary *) aDictionary {
    Machine *m = [[[Machine alloc]init] autorelease ];
    [m setMachineId:[aDictionary valueForKey:@"machineId"]];
    [m setMachineDescription:[aDictionary valueForKey:@"machineDesc"]];
    return m;
}

@end
