//
//  Ticket.m
//  Autotech-1
//
//  Created by Javier Jara on 5/10/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "Ticket.h"


@implementation Ticket

@synthesize 
iD = _iD,
//subTicketId = _subTicketId,
opId = _opId,
machineId = _machineId,
categoryId = _categoryId,
dateClosed = _dateClosed,
partDescription = _partDescription,
machine = _machine, 
machineType = _machineType, 
category = _category, 
issueDescription = _issueDescription, 
statusDescription = _statusDescription, 
techAssociate = _techAssociate, 
dateEntered = _dateEntered, 
techNotes = _techNotes,
priority = _priority,
requestor = _requestor,
locationId = _locationId,
likePart = _likePart,
hasPics = _hasPics;

+(id)TicketWithDictionary:(NSDictionary *)aDictionary
{
    Ticket *t = [[[Ticket alloc] init]autorelease];
    [t setID:[aDictionary valueForKey:@"iD"]];
//    [t setSubTicketId:[aDictionary valueForKey:@"subTicketId"]];
    [t setOpId:[aDictionary valueForKey:@"opId"]];
    [t setCategoryId:[aDictionary valueForKey:@"categoryId"]];
    [t setMachineId:[aDictionary valueForKey:@"machineId"]];
    [t setDateClosed:[aDictionary valueForKey:@"dateClosed"]];   
    [t setPartDescription:[aDictionary valueForKey:@"partDesc"]];
    [t setMachine:[aDictionary valueForKey:@"machine"]];
    [t setMachineType:[aDictionary valueForKey:@"machineType"]];
    [t setCategory:[aDictionary valueForKey:@"category"]];
    [t setIssueDescription:[aDictionary valueForKey:@"issueDescription"]];
    [t setStatusDescription:[aDictionary valueForKey:@"statusDescription"]];
    [t setTechAssociate:[aDictionary valueForKey:@"techAssociate"]];
    [t setDateEntered:[aDictionary valueForKey:@"dateEntered"]];
    [t setTechNotes:[aDictionary valueForKey:@"techNotes"]];
    [t setPriority:[aDictionary valueForKey:@"priority"]];
    [t setRequestor:[aDictionary valueForKey:@"fullName"]];
    [t setLocationId:[aDictionary valueForKey:@"locationId"]];
    [t setTechId:[aDictionary valueForKey:@"techId"]];
    [t setLikePart:[aDictionary valueForKey:@"likePart"]];
    [t setHasPics:[aDictionary valueForKey:@"hasPics"]];
    return t;
}

-(void)dealloc {
    [_iD release];
//    [_subTicketId release];
    [_opId release];
    [_machineId release];
    [_categoryId release];
    [_dateClosed release];
    [_partDescription release];
    [_machine release];
    [_machineType release];
    [_category release];
    [_issueDescription release];
    [_statusDescription release];
    [_techAssociate release];
    [_dateEntered release];
    [_techNotes release];
    [_priority release];
    [_requestor release];
    [_locationId release];
    [_techId release];
    [_likePart release];
    [_hasPics release];
    [super dealloc];
}
    

@end
