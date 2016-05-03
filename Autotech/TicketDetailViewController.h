//
//  TicketDetailViewController.h
//  Autotech-1
//
//  Created by Javier Jara on 5/11/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LMBSlidingViewController.h"
#import "Ticket.h"
#import "Techs.h"
#import "Constants.h"
#import "AddTicketViewController.h"

@interface TicketDetailViewController : LMBSlidingViewController <UIAlertViewDelegate,  UITextViewDelegate,  UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>   {

    Ticket *_ticket;
    Techs *_techForTicket;
    NSMutableArray *_parentTickets;
    NSMutableArray *_techs;
    UITextField *_machineTextField;
    UITextField *_partDescriptionTextField;
    UITextField *_categoryTextField;
    UITextField *_techTextField;
    UITextField *_locationTextField;
    UITextField *_likePartTextField;
    UITextView *_issueDescriptionTextView;
    UISwitch *_statusSwitch;
    UIButton *_closeTicketButton;
    UIScrollView *_scrollView;
//    UIPickerView *_techPickerView;
    UITextView *_techNotesTextView;
    UILabel *_inProcessLabel;
    UITextField *_dateEnteredTextField;
    UIButton *_playPauseButton;
    UIButton *_defaultNotesButton;
    
    UIPickerView *_statusPickerView;
    NSArray *_status;
    UIPopoverController *_popOverController;
    UILabel *_ticketIdLabel;
    UIButton *_createSubTicket;
    UILabel *_subTicketLabel;
    UILabel *_requestorLabel;
    
    UIActivityIndicatorView *_spinner;
    NSMutableArray *_locations;
    NSMutableArray *_machines;
    NSMutableArray *_categories;
    
    Location *_locationForTicket;
    Machine *_machineForTicket;
    TicketCategory *_categoryForTicket;
    
    BOOL *_didSelectedMachine;
    BOOL *_didSelectedTech;
    
    UIButton *_viewPicsButton;
    NSString *_hasPics;
    NSString *_picsStatus;
    
//    NSMutableArray *_techExceptionList;
}

@property (nonatomic, retain) Ticket *ticket;
@property (nonatomic, retain) Techs *techForTicket;
@property (nonatomic, retain) NSMutableArray *techs;
@property (nonatomic, retain) NSMutableArray *parentTickets;
@property (nonatomic, retain) IBOutlet UITextField *machineTextField;
@property (nonatomic, retain) IBOutlet UITextField *partDescriptionTextField;
@property (nonatomic, retain) IBOutlet UITextField *categoryTextField;
@property (nonatomic, retain) IBOutlet UITextField *techTextField;
@property (nonatomic, retain) IBOutlet UITextField *locationTextField;
@property (nonatomic, retain) IBOutlet UITextField *likePartTextField;
@property (nonatomic, retain) IBOutlet UITextView *issueDescriptionTextView;
@property (nonatomic, retain) IBOutlet UISwitch *statusSwitch;
@property (nonatomic, retain) IBOutlet UIButton *closeTicketButton;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
//@property (nonatomic, retain) IBOutlet UIPickerView *techPickerView; 
@property (nonatomic, retain) IBOutlet UITextView *techNotesTextView;
@property (nonatomic, retain) IBOutlet UILabel *inProcessLabel;
@property (nonatomic, retain) IBOutlet UITextField *dateEnteredTextField;
@property (nonatomic, retain) IBOutlet UIButton *playPauseButton;
@property (nonatomic, retain) IBOutlet UIButton *defaultNotesButton;

@property (nonatomic, retain) IBOutlet UIPickerView *statusPickerView;
@property (nonatomic, retain) NSArray *status;
@property (nonatomic, retain) UIPopoverController *popOverController; 
@property (nonatomic, retain) IBOutlet UILabel *ticketIdLabel;
@property (nonatomic, retain) IBOutlet UIButton *createSubTicket;
@property (nonatomic, retain) IBOutlet UILabel *subTicketLabel;
@property (nonatomic, retain) IBOutlet UILabel *requestorLabel;

@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) NSMutableArray *locations;
@property (nonatomic, retain) NSMutableArray *machines;
@property (nonatomic, retain) NSMutableArray *categories;

@property (nonatomic, retain) Location *locationForTicket;
@property (nonatomic, retain) Machine *machineForTicket;
@property (nonatomic, retain) TicketCategory *categoryForTicket;

@property (nonatomic, assign) BOOL *didSelectedMachine;
@property (nonatomic, assign) BOOL *didSelectedTech;

@property (nonatomic, retain) IBOutlet UIButton *viewPicsButton;
//@property (nonatomic, retain) NSString *hasPics;
@property (nonatomic, retain) NSString *picsStatus;

//@property (nonatomic, retain) NSMutableArray *techExceptionList;

+ (id) initWithTicket: (Ticket *) newTicket;
- (IBAction) toggleEnabledForStatusSwitch: (id) sender; 
// - (IBAction) closeTicketButtonClick: (id) sender;
- (IBAction) saveAndExitCloseTicketClick: (id) sender;
- (IBAction) pauseOrPlayButtonClick: (id) sender;
- (IBAction) showDefaultNotes;
- (IBAction) createSubTicket:(id)sender;
- (void) displayInfoAlert: (NSString *) title And: (NSString *) message;

//- (void) showPicker: (NSString *) title;
- (void) showPicker: (NSString *) title textFieldTag:(NSInteger)textFieldTag;
- (void) loadInProcessInfo;
- (void) dismissKeyboard;
- (void) popSelection:(id) sender;
- (void) loadData;
- (void) refreshMachinesArray: (NSString *) locationId;
- (void) refreshTechsArray: (NSString *) locationId;

- (NSString *) GetPicsStauts: (NSString *) ticketId;

- (IBAction)viewPicsButtonClicked:(id)sender;

@end

