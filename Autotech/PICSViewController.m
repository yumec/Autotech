//
//  PICSViewController.m
//  Autotech
//
//  Created by yumec on 8/10/13.
//  Copyright (c) 2013 Samtec. All rights reserved.
//

#import "PICSViewController.h"

@interface PICSViewController ()

@end

@implementation PICSViewController

@synthesize webView;
@synthesize partDesc;
@synthesize languageId;
@synthesize languageSegementedControl;
@synthesize confirmStatus;
@synthesize ticketId;
@synthesize ticketDetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    
    UIBarButtonItem *confirmBarButton = [[UIBarButtonItem alloc] init];
    confirmBarButton.title = @"Confirm";
    confirmBarButton.target = self;
    confirmBarButton.action = @selector(confirmPics:);
    
    self.navigationItem.rightBarButtonItem = confirmBarButton;
    if ([confirmStatus isEqualToString:@"1"]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.tintColor = self.navigationController.navigationBar.tintColor;
    }
    [confirmBarButton release];
    
//    self.languageSegementedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.languageSegementedControl.tintColor = self.navigationController.navigationBar.tintColor;
    
    self.languageId = @"1";
    [self loadPicsWithLanuage:self.languageId AndPartDesc:self.partDesc];
}



- (IBAction)confirmPics:(id)sender
{
    User *u = [(AutotechAppDelegate *)[[UIApplication sharedApplication] delegate] currentUser];
    NSString *address = [NSString stringWithFormat:@"http://%@/PicsConfirm.ashx?ticketId=%@&ticketConfirmationStepTypeId=1&enteredById=%@&type=ConfirmedPics",ConnectionString, self.ticketId, u.userMasterId];
    NSURL *url = [NSURL URLWithString:address];
    NSError *error;
    NSString *result = [NSString stringWithContentsOfURL:url encoding: NSASCIIStringEncoding error:&error];
    
    if ([result isEqualToString:@"1"]) {// Confirmed Pics Successfully

        ticketDetail.viewPicsButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [ticketDetail.viewPicsButton setTitle:@"This Ticket had been confirmed!" forState:UIControlStateNormal];
        ticketDetail.picsStatus = @"1";
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error occurred while closing the ticket, please try again or contact MIS." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void) loadPicsWithLanuage: (NSString *) _languageId AndPartDesc:  (NSString *) _partDesc
{
    NSString *address = nil;
    _partDesc = [partDesc stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    address = [NSString stringWithFormat:@"http://%@/ViewPics.aspx?languageId=%@&partNumber=%@&isPrintout=false&isOperator=false", PicsPreviewConnectionString, _languageId, _partDesc];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:address]];
    [self.view addSubview:webView];
    [webView loadRequest:request];

     webView.scalesPageToFit = YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (IBAction)languageSegementedControlIndexChanged:(id)sender
{
    NSString *_languageId = [NSString stringWithFormat:@"%d", (int)self.languageSegementedControl.selectedSegmentIndex + 1];
     
    [self loadPicsWithLanuage:_languageId AndPartDesc:self.partDesc];
}

- (void)viewDidUnload
{
    [webView release];
    [partDesc release];
    [languageId release];
    [languageSegementedControl release];
    [confirmStatus release];
    [ticketId release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
