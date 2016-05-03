//
//  TicketCategory.h
//  Autotech
//
//  Created by Javier Jara on 6/7/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TicketCategory : NSObject {
    NSString *_categoryId; 
    NSString *_categoryDescription;
}

@property (nonatomic, retain) NSString *categoryId; 
@property (nonatomic, retain) NSString *categoryDescription;

+(id)TicketCategoryWithDictionary: (NSDictionary *) aDictionary;

@end
