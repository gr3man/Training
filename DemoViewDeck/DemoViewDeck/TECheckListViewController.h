//
//  TECheckListViewController.h
//  DemoViewDeck
//
//  Created by Tuan Nguyen Anh on 7/7/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECenterViewController.h"

@interface TECheckListViewController : TECenterViewController
{
    NSArray *snacks;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *snacks;

@end
