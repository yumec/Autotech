//
//  TicketCategory.m
//  Autotech
//
//  Created by Javier Jara on 6/7/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "TicketCategory.h"


@implementation TicketCategory

@synthesize categoryId = _categoryId, 
categoryDescription = _categoryDescription;



- (void) dealloc {
    [_categoryDescription release];
    [_categoryId release];
    [super dealloc];
}


+(id)TicketCategoryWithDictionary: (NSDictionary *) aDictionary {
    TicketCategory *category = [[[TicketCategory alloc] init] autorelease];
    [category setCategoryId:[aDictionary valueForKey:@"categoryId"]];
    [category setCategoryDescription:[aDictionary valueForKey:@"categoryDesc"]];
    return category;
}


@end
