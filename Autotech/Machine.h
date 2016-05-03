//
//  Machine.h
//  Autotech
//
//  Created by Javier Jara on 6/7/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Machine : NSObject {
    NSString *_machineId;
    NSString *_machineDescription;
}

@property (nonatomic, retain) NSString *machineId; 
@property (nonatomic, retain) NSString *machineDescription;

+(id) machineWithDictionary:(NSDictionary *) aDictionary ;

@end
