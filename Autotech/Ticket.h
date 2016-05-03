//
//  Ticket.h
//  Autotech-1
//
//  Created by Javier Jara on 5/10/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject {
    NSString *_iD;
//    NSString *_subTicketId;
    NSString *_opId;
    NSString *_categoryId;  
    NSString *_machineId;  
    NSString *_dateClosed;
    NSString *_statusDescription;
    NSString *_techAssociate;
    NSString *_partDescription;
    NSString *_machine;
    NSString *_machineType;
    NSString *_category;
    NSString *_issueDescription;
    NSString *_dateEntered;
    NSString *_techNotes;
    NSString *_priority;
    NSString *_requestor;
    NSString *_locationId;
    NSString *_techId;
    NSString *_likePart;
    NSString *_hasPics;
}

@property (nonatomic, copy) NSString *iD;
//@property (nonatomic, copy) NSString *subTicketId;
@property (nonatomic, copy) NSString *opId;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *machineId;
@property (nonatomic, copy) NSString *dateClosed;
@property (nonatomic, copy) NSString *partDescription;
@property (nonatomic, copy) NSString *statusDescription;
@property (nonatomic, copy) NSString *techAssociate;
@property (nonatomic, copy) NSString *machine;
@property (nonatomic, copy) NSString *machineType;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *issueDescription;
@property (nonatomic, copy) NSString *dateEntered;
@property (nonatomic, copy) NSString *techNotes;
@property (nonatomic, copy) NSString *priority;
@property (nonatomic, copy) NSString *requestor;
@property (nonatomic, copy) NSString *locationId;
@property (nonatomic, copy) NSString *techId;
@property (nonatomic, copy) NSString *likePart;
@property (nonatomic, copy) NSString *hasPics;

+(id)TicketWithDictionary:(NSDictionary *)aDictionary;
- (void)dealloc;

@end
