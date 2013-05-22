//
//  BIDViewController.h
//  Exercise2 PlainTable
//
//  Created by Tuan Nguyen Anh on 4/8/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *number;
    NSArray *detailText;
}

@end
