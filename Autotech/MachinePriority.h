//
//  MachinePriority.h
//  Autotech
//
//  Created by Javier Jara on 8/12/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MachinePriority : NSObject {
    NSString *_machineDesc;
    NSString *_machinePriority;
    
}

@property (nonatomic,retain) NSString *machineDesc;
@property (nonatomic,retain) NSString *machinePriority;

+(id)MachinePriorityWithDictionary:(NSDictionary *)aDictionary;

@end
