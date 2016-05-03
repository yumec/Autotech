//
//  SettingsViewController.h
//  Autotech
//
//  Created by Javier Jara on 6/23/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMBSlidingViewController.h"
#import "Techs.h"

@interface SettingsViewController : LMBSlidingViewController <UIPopoverControllerDelegate, UITextFieldDelegate ,UIPickerViewDelegate, UIActionSheetDelegate> {
    UIButton *_logOffButton;
    UILabel *_loginNameLabel;
    UILabel *_techAreaLabel;
    UITextField *_ticketListTextField;
    UIPopoverController *_popOverController;
    NSArray *_ticketLists;
    UILabel *_clientVersionStr;
    UIPickerView *_thePicker;
    Techs *_techForUser;
    NSMutableArray *_techs;
    UISwitch *_techSwitch;
    UILabel *_techLabel;
}

@property (nonatomic, retain) IBOutlet UIButton *logOffButton;
@property (nonatomic, retain) IBOutlet UILabel *loginNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *techAreaLabel;
@property (nonatomic, retain) UIPopoverController *popOverController;
@property (nonatomic, retain) IBOutlet UITextField *ticketListTextField;
@property (readonly, nonatomic, retain)  NSArray *ticketLists;
@property (retain, readwrite) IBOutlet UILabel *clientVersionStr;
@property (nonatomic, retain) UIPickerView *thePicker;

@property (nonatomic, retain) Techs *techForUser;
@property (nonatomic, retain) NSMutableArray *techs;
@property (nonatomic, retain) IBOutlet UISwitch *techSwitch;
@property (nonatomic, retain) IBOutlet UILabel *techLabel;

-(IBAction) logOff;

- (void) showPicker: (NSString *) title
       textFieldTag: (NSInteger) textFieldTag;

- (void) selectedTechArea;
- (void) loadTechs: (NSInteger) type;

- (IBAction)techSwithClicked;

@end
