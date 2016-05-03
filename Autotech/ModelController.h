//
//  ModelController.h
//  Autotech
//
//  Created by Javier Jara on 6/15/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ModelController : NSObject {
    NSArray *_setupTickets; 
    NSArray *_AdjustmentTickets;
    NSArray *_MaintenanceTickets;
    NSArray *_ToolsPartsTickets;
    NSArray *_Training; 
    NSArray *_CallBack;
    NSArray *_electrical;
    NSArray *_calibrationTesting;
    NSArray *_brokenBlade;
    NSArray *_misc;
    NSArray *_mis;
    NSArray *_prototypeMods;
    NSArray *_assemblyFixtures;   
    NSArray *_facilityWilsonville;
    NSArray *_facilityVancouver;  
    NSArray *_safety;            
    NSArray *_cableEngineering ;  
    NSArray *_assemblyEngineering;
    NSArray *_cabToolsFixt;    
    NSArray *_moldPrep;           
    NSArray *_materialPreparation;
    NSArray *_diePrep;            
    NSArray *_nRSetup;          
    NSArray *_nRAdjustment;     
    NSArray *_extrusionLineRequest;
    NSArray *_pM;
}

@property (nonatomic, retain)  NSArray *setupTickets; 
@property (nonatomic, retain)  NSArray *AdjustmentTickets;
@property (nonatomic, retain)  NSArray *MaintenanceTickets;
@property (nonatomic, retain)  NSArray *ToolsPartsTickets;
@property (nonatomic, retain)  NSArray *Training; 
@property (nonatomic, retain)  NSArray *CallBack;
@property (nonatomic, retain)  NSArray *electrical;
@property (nonatomic, retain)  NSArray *calibrationTesting;
@property (nonatomic, retain)  NSArray *brokenBlade;
@property (nonatomic, retain)  NSArray *misc;
@property (nonatomic, retain)  NSArray *mis;
@property (nonatomic, retain)  NSArray *prototypeMods;
@property (nonatomic, retain)  NSArray *assemblyFixtures;   
@property (nonatomic, retain)  NSArray *facilityWilsonville;
@property (nonatomic, retain)  NSArray *facilityVancouver;  
@property (nonatomic, retain)  NSArray *safety;            
@property (nonatomic, retain)  NSArray *cableEngineering ;  
@property (nonatomic, retain)  NSArray *assemblyEngineering;
@property (nonatomic, retain)  NSArray *cabToolsFixt;    
@property (nonatomic, retain)  NSArray *moldPrep;           
@property (nonatomic, retain)  NSArray *materialPreparation;
@property (nonatomic, retain)  NSArray *diePrep;            
@property (nonatomic, retain)  NSArray *nRSetup;          
@property (nonatomic, retain)  NSArray *nRAdjustment;     
@property (nonatomic, retain)  NSArray *extrusionLineRequest;
@property (nonatomic, retain)  NSArray *pM;

@end
