//
//  TECenterViewController.h
//  DemoViewDeck
//
//  Created by Tuan Nguyen Anh on 7/7/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "TELeftViewController.h"
#import "TERightViewController.h"

@interface TECenterViewController : UIViewController <IIViewDeckControllerDelegate, MenuDelegate>
{
    TELeftViewController* leftController;
    TERightViewController* rightController;
}

@end
