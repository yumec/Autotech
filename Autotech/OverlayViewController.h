//
//  OverlayViewController.h
//  Autotech
//
//  Created by Javier Jara on 7/28/11.
//  Copyright 2011 Samtec. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewWithSearchBarViewController;

@interface OverlayViewController : UIViewController {
    
    ViewWithSearchBarViewController *_rvController;
}

@property (nonatomic, retain) ViewWithSearchBarViewController *rvController;

@end
