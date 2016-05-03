//
//  FindViewController.h
//  Autotech
//
//  Created by hz-yumec-mac on 2/27/12.
//  Copyright 2012 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "LMBSlidingViewController.h"
#import "TechAssociatesTicketsReport.h"
#import "MachinesReport.h"
#import "Constants.h"

@interface FindViewController : LMBSlidingViewController <UIActionSheetDelegate, UIPickerViewDelegate> {
    UITextField *_startDateTextField;
    UITextField *_endDateTextField;
    UISwitch *_statusSwitch;
    NSMutableArray *_report;
    UIPopoverController *_popOverController;
    UIDatePicker *_datePicker;
    UISegmentedControl *_segmentControl;
    UIView *_searchByUserOptionView;
    UIButton *_find;
}

@property (nonatomic, retain) IBOutlet UITextField *startDateTextField;
@property (nonatomic, retain) IBOutlet UITextField *endDateTextField;
@property (nonatomic, retain) IBOutlet UISwitch *statusSwitch;
@property (nonatomic, retain) NSMutableArray *report;
@property (nonatomic, retain) UIPopoverController *popOverController;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic, retain) IBOutlet UIView *searchByUserOptionView;
@property (nonatomic, retain) IBOutlet UIButton *find;

- (IBAction) searchReault;
- (IBAction) selectSearchOption:(id)sender;
- (void) popSelection:(id) sender;
- (void) showPicker: (NSString *) title textFieldTag
                   : (NSInteger) textFieldTag;
-(void)dismissKeyboard;

@end
