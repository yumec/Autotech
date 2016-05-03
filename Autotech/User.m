//
//  User.m
//  Autotech
//
//  Created by Javier Jara on 6/21/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import "User.h"
#import "Constants.h"

@implementation User

@synthesize name = _name, 
email = _email, 
userMasterId = _userMasterId, 
techID = _techID,  
loginTechID = _loginTechID,
techName = _techName,
plantID = _plantID;


-(void)dealloc{
    [_email release];
    [_name release];
    [_techID release];
    [_userMasterId release];
    [_loginTechID release];
    [_techName release];
    [_plantID release];
    [super dealloc];
}


+(id)UserWithDictionary: (NSDictionary *) aDictionary {
    User *user = [[[User alloc] init] autorelease];
    [user setName:[aDictionary valueForKey:@"Name"]];
    [user setEmail:[aDictionary valueForKey:@"Email"]];
    [user setUserMasterId:[aDictionary valueForKey:@"UserMasterId"]];
    [user setTechID:[aDictionary valueForKey:@"techID"]];
    [user setTechName:[aDictionary valueForKey:@"techName"]];
    [user setPlantID:[aDictionary valueForKey:@"plantID"]];
    [user setLoginTechID:[aDictionary valueForKey:@"loginTechID"]];
    return user;
}

/*
- (NSString *) getTechAdminID {
    NSString *techAssocId = [NSString stringWithFormat:@"%d", kTechMoldAdminID];
    if ([self.techAreaDescription isEqualToString:@"Automation"]) {
        techAssocId = [NSString stringWithFormat:@"%d", kTechAutomationAdminID];
    } else if ([self.techAreaDescription isEqualToString:@"HDR"]) {
        techAssocId = [NSString stringWithFormat:@"%d", kTechHDRAdminID];
    } else if ([self.techAreaDescription isEqualToString:@"My Tickets List"]) {
        techAssocId = self.techID;
    } else if ([self.techAreaDescription isEqualToString:@"CR Facilities"]) {
        techAssocId = [NSString stringWithFormat:@"%d", kTechCRFacilitiesID];
    } else if ([self.techAreaDescription isEqualToString:@"PN Handfill"]) {
        techAssocId = [NSString stringWithFormat:@"%d", KTechPNHandfillID];
    } else if ([self.techAreaDescription isEqualToString:@"PN 2nd Ops"]) {
        techAssocId = [NSString stringWithFormat:@"%d", KTechPN2ndOpsID];
    } else if ([self.techAreaDescription isEqualToString:@"PN Facilities"]) {
        techAssocId = [NSString stringWithFormat:@"%d", KTechPNFacilitiesID];
    } else if ([self.techAreaDescription isEqualToString:@"PN Automation"]) {
        techAssocId = [NSString stringWithFormat:@"%d", KTechPNAutomationID];
    } else if ([self.techAreaDescription isEqualToString:@"CR 1 Floor"]) {
        techAssocId = [NSString stringWithFormat:@"%d", KTechCR1FloorID];
    } else if ([self.techAreaDescription isEqualToString:@"CR HDR1"]) {
        techAssocId = [NSString stringWithFormat:@"%d", KTechCRHDR1ID];
    } else if ([self.techAreaDescription isEqualToString:@"CR Automation"]) {
        techAssocId = [NSString stringWithFormat:@"%d", KTechCRAutomationID];
    } else if ([self.techAreaDescription isEqualToString:@"SME Tech Group"]) {
        techAssocId = [NSString stringWithFormat:@"%d", KTechSMETechID];
    } else if ([self.techAreaDescription isEqualToString:@"SME Engineering"]) {
        techAssocId = [NSString stringWithFormat:@"%d", KTechSMEEngID];
    }
    return techAssocId;
}

- (NSInteger) getTechAdminIDInt {
    NSInteger techAssocId =  kTechMoldAdminID;
    if ([self.techAreaDescription isEqualToString:@"Automation"]) {
        techAssocId =  kTechAutomationAdminID;
    } else if ([self.techAreaDescription isEqualToString:@"HDR"]) {
        techAssocId = kTechHDRAdminID;
    } else if ([self.techAreaDescription isEqualToString:@"My Tickets List"]) {
        techAssocId = [self.techID intValue];
    } else if ([self.techAreaDescription isEqualToString:@"CR Facilities"]) {
        techAssocId = kTechCRFacilitiesID;
    } else if ([self.techAreaDescription isEqualToString:@"PN Handfill"]) {
        techAssocId = KTechPNHandfillID;
    } else if ([self.techAreaDescription isEqualToString:@"PN 2nd Ops"]) {
        techAssocId = KTechPN2ndOpsID;
    } else if ([self.techAreaDescription isEqualToString:@"PN Facilities"]) {
        techAssocId = KTechPNFacilitiesID;
    } else if ([self.techAreaDescription isEqualToString:@"PN Automation"]) {
        techAssocId = KTechPNAutomationID;
    } else if ([self.techAreaDescription isEqualToString:@"CR 1 Floor"]) {
        techAssocId = KTechCR1FloorID;
    } else if ([self.techAreaDescription isEqualToString:@"CR HDR1"]) {
        techAssocId = KTechCRHDR1ID;
    } else if ([self.techAreaDescription isEqualToString:@"SME Tech Group"]) {
        techAssocId = KTechSMETechID;
    } else if ([self.techAreaDescription isEqualToString:@"SME Engineering"]) {
        techAssocId = KTechSMEEngID;
    }
    return techAssocId;
}

-(NSString *) getTechAreaID
{
    NSString *techAreaID;
    
    if ([self.techAreaDescription isEqualToString:@"Mold Process"]) {
        techAreaID = @"1";
    } else if ([self.techAreaDescription isEqualToString:@"HDR"]) {
        techAreaID = @"2";
    } else if ([self.techAreaDescription isEqualToString:@"Automation"]) {
        techAreaID = @"3";
    } else if ([self.techAreaDescription isEqualToString:@"My Tickets List"]) {
        techAreaID = @"0";
    } else if ([self.techAreaDescription isEqualToString:@"CR Facilities"]){
        techAreaID = @"5";
    } else if ([self.techAreaDescription isEqualToString:@"PN Handfill"]){
        techAreaID = @"7";
    } else if ([self.techAreaDescription isEqualToString:@"PN 2nd Ops"]){
        techAreaID = @"8";
    } else if ([self.techAreaDescription isEqualToString:@"PN Facilities"]){
        techAreaID = @"9";
    } else if ([self.techAreaDescription isEqualToString:@"PN Automation"]){
        techAreaID = @"10";
    } else if ([self.techAreaDescription isEqualToString:@"CR 1 Floor"]){
        techAreaID = @"11";
    } else if ([self.techAreaDescription isEqualToString:@"CR HDR1"]){
        techAreaID = @"12";
    } else if ([self.techAreaDescription isEqualToString:@"CR Automation"]){
        techAreaID = @"13";
    } else if ([self.techAreaDescription isEqualToString:@"SME Tech Group"]) {
        techAreaID = @"6";
    } else if ([self.techAreaDescription isEqualToString:@"SME Engineering"]) {
        techAreaID = @"14";
    }
    
    return techAreaID;
}

- (NSString *) getWorkCenterID
{
    NSString *workCenterID;
    if ([self.techAreaDescription isEqualToString:@"Mold Process"]) {
        workCenterID = @"53";
    } else if ([self.techAreaDescription isEqualToString:@"HDR"]) {
        workCenterID = @"37";
    } else if ([self.techAreaDescription isEqualToString:@"Automation"]) {
        workCenterID = @"4";
    } else if ([self.techAreaDescription isEqualToString:@"Samtec Microelectronics"]){
        workCenterID = @"58";
    } else {
//        workCenterID = self.plantID;
        workCenterID = @"4";
    } 
    return workCenterID;
}
*/

@end
