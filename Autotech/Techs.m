//
//  Techs.m
//  Autotech
//
//  Created by Javier Jara on 5/30/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "Techs.h"


@implementation Techs

@synthesize techID = _techID, techFullName = _techFullName, plantID = _plantID;


+(id)techWithDictionary:(NSDictionary *)aDictionary
{
    Techs *t = [[[Techs alloc] init]autorelease];
    [t setTechID:[aDictionary valueForKey:@"techID"]];
    [t setTechFullName:[aDictionary valueForKey:@"techFullName"]];
    [t setPlantID:[aDictionary valueForKey:@"plantID"]];
    return t;
}

- (void) dealloc 
{
    [_techID release];
    [_techFullName release];
    [_plantID release];
    [super dealloc];
}

@end
