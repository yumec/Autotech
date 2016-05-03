//
//  TicketActivity.m
//  Autotech
//
//  Created by Javier Jara on 7/4/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "TicketActivity.h"


@implementation TicketActivity

@synthesize enteredBy = _enteredBy, dateEntered = _dateEntered, description = _description;

-(void) dealloc {
    [_enteredBy release];
    [_dateEntered release];
    [_description release];
   // [_ticketId release];
    [super dealloc];
}


+(id)TicketActivityWithDictionary: (NSDictionary *) aDictionary {
    TicketActivity *activity = [[[TicketActivity alloc] init] autorelease];
    [activity setDateEntered:[aDictionary valueForKey:@"dateEntered"]];
    [activity setEnteredBy:[aDictionary valueForKey:@"enteredBy"]];
    [activity setDescription:[aDictionary valueForKey:@"description"]];
    return activity;
}



@end
