//
//  TEDisclosureViewController.h
//  DemoViewDeck
//
//  Created by Tuan Nguyen Anh on 7/7/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECenterViewController.h"

@interface TEDisclosureViewController : TECenterViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *movies;
}

@property (copy, nonatomic) NSArray *movies;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
