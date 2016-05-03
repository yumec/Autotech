//
//  TicketActivity.h
//  Autotech
//
//  Created by Javier Jara on 7/4/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TicketActivity : NSObject {
    
    NSString *_description;
    //NSString *_ticketId;
    NSString *_dateEntered;
    NSString *_enteredBy;
    
}

@property (nonatomic, copy) NSString *description;
//@property (nonatomic, copy) NSString *ticketId;
@property (nonatomic, copy) NSString *dateEntered;
@property (nonatomic, copy) NSString *enteredBy;

+(id)TicketActivityWithDictionary: (NSDictionary *) aDictionary ;
@end
