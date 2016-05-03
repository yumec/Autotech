//
//  Techs.h
//  Autotech
//
//  Created by Javier Jara on 5/30/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Techs : NSObject {
    NSString *_techID; 
    NSString *_techFullName;
    NSString *_plantID;
}


@property (nonatomic, retain) NSString *techID; 
@property (nonatomic, retain) NSString *techFullName; 
@property (nonatomic, retain) NSString *plantID;

+ (id)techWithDictionary:(NSDictionary *)aDictionary;

@end
