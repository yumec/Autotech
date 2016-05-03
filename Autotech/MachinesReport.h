//
//  MachinesReport.h
//  Autotech
//
//  Created by hz-yumec-mac on 6/9/12.
//  Copyright (c) 2012 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MachinesReport : NSObject {
    NSString *_machineDesc;
    NSString *_totals;
}

@property (nonatomic, retain) NSString *machineDesc;
@property (nonatomic, retain) NSString *totals;

+ (id) MachinesReportWithDictionary:(NSDictionary *)aDictionary;
    
@end
