//
//  Constants.h
//  Autotech-2
//
//  Created by Javier Jara on 5/17/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const ConnectionString;
extern NSString * const SGNConnectionString;
extern NSString * const TicketDeatilViewController_Iphone;
extern NSString * const TicketDeatilViewController_Ipad;
extern NSString * const AddTicketViewController_iPad; 
extern NSString * const AddTicketViewController_iPhone; 
extern NSString * const TicketsViewController_iPad; 
extern NSString * const TicketsViewController_iPhone;
extern NSString * cStatusNew; 
extern NSString * cStatusInProcess; 
extern NSString * cStatusClosed ; 
extern NSString * const TechMoldAdmin;
extern NSString * const TechHDRAdmin;
extern NSString * const TechAutomationAdmin;

#define KStatusNew  1
#define KStatusInProcess 3
#define KStatusClosed 6

#define kTechMoldAdminID 227 
#define kTechHDRAdminID 154
#define kTechAutomationAdminID 31
#define kTechCRFacilitiesID 510
//#define KTechSMEID 717 // dev 644
#define KTechPNHandfillID 748 // dev 645
#define KTechPN2ndOpsID 749 // dev 646
#define KTechPNFacilitiesID 750 // dev 647

#define KTechPNAutomationID 812
#define KTechCR1FloorID 403
#define KTechCRHDR1ID 248
#define KTechCRAutomationID 296

#define KTechSMETechID 705
#define KTechSMEEngID 717

@interface Constants : NSObject {
}

@end
