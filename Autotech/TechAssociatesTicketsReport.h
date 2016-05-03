//
//  TechAssociatesTicketsReport.h
//  Autotech
//
//  Created by hz-yumec-mac on 2/27/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TechAssociatesTicketsReport : NSObject {
    NSString *_techID;
    NSString *_fullName;
    NSString *_numberOfTickets;
}

@property (nonatomic, retain) NSString *techID;
@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) NSString *numberOfTickets;

+ (id) TechAssociatesTicketsReportWithDictionary:(NSDictionary *) aDictionary;

@end
