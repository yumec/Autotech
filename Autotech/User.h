//
//  User.h
//  Autotech
//
//  Created by Javier Jara on 6/21/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    
    NSString * _name;
    NSString * _email;
    NSString * _userMasterId;
    NSString *_techID;
    NSString *_loginTechID;
    NSString *_techName;
    NSString *_plantID;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *userMasterId;
@property (nonatomic, copy) NSString *techID;
@property (nonatomic, copy) NSString *loginTechID;
@property (nonatomic,copy) NSString *techName;
@property (nonatomic, copy) NSString *plantID;

+(id)UserWithDictionary: (NSDictionary *) aDictionary;
//-(NSString *) getTechAdminID;
//-(NSInteger) getTechAdminIDInt;
//-(NSString *) getTechAreaID;
//-(NSString *) getWorkCenterID;

@end
