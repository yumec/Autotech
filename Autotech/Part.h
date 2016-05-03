//
//  Part.h
//  Autotech
//
//  Created by yumec on 6/4/13.
//  Copyright (c) 2013 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Part : NSObject {
    NSString *_partNumber;
    NSString *_likePart;
}

@property (nonatomic, retain) NSString *partNumber;
@property (nonatomic, retain) NSString *likePart;

+ (id)partWithDictionary:(NSDictionary *)aDictionary;

@end
