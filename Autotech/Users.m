//
//  Users.m
//  Autotech
//
//  Created by Yume Chen on 2/24/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import "Users.h"


@implementation Users

@synthesize userMasterID = _userMasterID;
@synthesize fullName = _fullName;

+ (id) UsersWithDictionary:(NSDictionary *)aDictionary
{
    Users *a = [[[Users alloc] init] autorelease];
    a.userMasterID = [aDictionary valueForKey:@"userMasterID"];
    a.fullName = [aDictionary valueForKey:@"fullName"];
    return a;
}

- (void) dealloc
{
    [_userMasterID release];
    [_fullName release];
    [super dealloc];
}

@end
