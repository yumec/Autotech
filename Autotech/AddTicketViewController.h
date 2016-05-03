//
//  AddTicketViewController.h
//  Autotech
//
//  Created by Javier Jara on 6/7/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"
#import "Techs.h"
#import "Machine.h"
#import "LMBSlidingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "TicketCategory.h"
#import "Location.h"
#import "User.h"
#import "AutotechAppDelegate.h"
#import "Users.h"
#import "Ticket.h"
#import "Part.h"

@interface AddTicketViewController : LMBSlidingViewController <UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate> {
 
    Techs *_techForTicket;
    Machine *_machineForTicket;
    TicketCategory *_categoryForTicket;
    Location *_locationForTicket;
    Users *_userForTicket;
    
    NSMutableArray *_techs;
    NSMutableArray *_machines;
    NSMutableArray *_categories;
    NSMutableArray *_locations;
    
    UIScrollView *_scrollView;
    UIButton *_addTicketButton;
    UIButton *_selectPartDescButton;
    UITextField *_techAssociateTextField; 
    UITextField *_machineTextField;
    UITextField *_categoryTextField;
    UITextField *_locationTextField;
    UITextView *_issueDescriptionTextView;
    UIPopoverController *_popOverController;
    
    UITextField *_orderNumberTextField;
    UITextField *_lineNumberTextField; 
    UITextField *_opIdTextField;
    UITextField *_partDescTextField;
    UITextField *_likePartTextField;
    UIActivityIndicatorView *_spinner;
    
    BOOL *_didSelectedMachine;
    BOOL *_didSelectedTech;
}


@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *techAssociateTextField;
@property (nonatomic, retain) IBOutlet UITextField *machineTextField;
@property (nonatomic, retain) IBOutlet UITextField *categoryTextField;
@property (nonatomic, retain) IBOutlet UITextField *locationTextField;
@property (nonatomic, retain) IBOutlet UITextView *issueDescriptionTextView;
@property (nonatomic, retain) IBOutlet UITextField *orderNumberTextField;
@property (nonatomic, retain) IBOutlet UITextField *lineNumberTextField;
@property (nonatomic, retain) IBOutlet UITextField *opIdTextField;
@property (nonatomic, retain) IBOutlet UITextField *partDescTextField;
@property (nonatomic, retain) IBOutlet UITextField *likePartTextField;
@property (nonatomic, retain) UIPopoverController *popOverController; 

@property (nonatomic, retain) IBOutlet UIButton *addTicketButton;
@property (nonatomic, retain) IBOutlet UIButton *selectPartDescButton;

@property (nonatomic, retain) Techs *techForTicket;
@property (nonatomic, retain) Machine *machineForTicket;
@property (nonatomic, retain) TicketCategory *categoryForTicket;
@property (nonatomic, retain) Location *locationForTicket;
@property (nonatomic, retain) Users *userForTicket;

@property (nonatomic, retain) NSMutableArray *techs;
@property (nonatomic, retain) NSMutableArray *machines;
@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) NSMutableArray *locations;

@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) Ticket *ticket;
@property (nonatomic, retain) NSMutableArray *parentTickets;

@property (nonatomic, assign) BOOL *didSelectedMachine;
@property (nonatomic, assign) BOOL *didSelectedTech;

- (IBAction) createTicketButtonClick: (id) sender;

- (void) loadData;
- (void) showPicker: (NSString *) title textFieldTag
                   : (NSInteger) textFieldTag;
- (void) refreshMachinesArray: (NSString *) locationId;
- (void)refreshTechsArray:(NSString *)locationId;
- (void) saveTicket;
- (void) displayInfoAlert: (NSString *) title
                         : (NSString *) message;

- (BOOL) validateFields;

- (void) popSelection:(id) sender;

- (void)dismissKeyboard;
- (IBAction) showPartDescription;
- (Part *) getPartInfo:(NSString *) orderNumber And: (NSString *) lineNumber;

@end
