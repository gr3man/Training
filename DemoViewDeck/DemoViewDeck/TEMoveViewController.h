//
//  TEMoveViewController.h
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/8/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECenterViewController.h"

@interface TEMoveViewController : TECenterViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *words;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *words;

@end
