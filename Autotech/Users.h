//
//  Users.h
//  Autotech
//
//  Created by Yume Chen on 2/24/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Users : NSObject {
    NSString *_userMasterID;
    NSString *_fullName;
}

@property (nonatomic, retain) NSString *userMasterID;
@property (nonatomic, retain) NSString *fullName;

+ (id)UsersWithDictionary:(NSDictionary *)aDictionary;

@end
