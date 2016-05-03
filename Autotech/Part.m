//
//  Part.m
//  Autotech
//
//  Created by yumec on 6/4/13.
//  Copyright (c) 2013 Samtec. All rights reserved.
//

#import "Part.h"

@implementation Part

@synthesize partNumber = _partNumber;
@synthesize likePart = _likePart;

+(id)partWithDictionary:(NSDictionary *)aDictionary
{
    Part *p = [[[Part alloc] init] autorelease];
    [p setPartNumber:[aDictionary valueForKey:@"PartNumber"]];
    [p setLikePart:[aDictionary valueForKey:@"LikePart"]];
    return p;
}

- (void) dealloc
{
    [_partNumber release];
    [_likePart release];
    [super dealloc];
}

@end
