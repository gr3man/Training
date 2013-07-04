//
//  TERootViewController.h
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "TELeftViewController.h"
#import "TERightViewController.h"

@interface TERootViewController : UITableViewController<IIViewDeckControllerDelegate, MenuDelegate>
{
    TELeftViewController* leftController;
    TERightViewController* rightController;
}

@end
