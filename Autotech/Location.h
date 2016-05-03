//
//  Location.h
//  Autotech
//
//  Created by Javier Jara on 6/8/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Location : NSObject {
    NSString *_locationId; 
    NSString *_locationDescription;
}


@property (nonatomic, retain) NSString *locationId;
@property (nonatomic, retain) NSString *locationDescription;

+(id) LocationWithDictionary:(NSDictionary *) aDictionary;

@end
