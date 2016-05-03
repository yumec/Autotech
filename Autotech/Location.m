//
//  Location.m
//  Autotech
//
//  Created by Javier Jara on 6/8/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "Location.h"


@implementation Location

@synthesize locationId = _locationId, locationDescription = _locationDescription;



+(id) LocationWithDictionary:(NSDictionary *) aDictionary {
    Location *l = [[[Location alloc]init] autorelease ];
    [l setLocationId:[aDictionary valueForKey:@"locationId"]];
    [l setLocationDescription:[aDictionary valueForKey:@"locationDesc"]];
    return l;
}

-(void) dealloc {
    [_locationId release];
    [_locationDescription release];
    [super dealloc];
}

@end
