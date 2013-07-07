//
//  TELeftViewController.h
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/4/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"

@protocol MenuDelegate <NSObject>

- (void) didSelectMenu : (NSString *)menuName;

@end

@interface TELeftViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    id<MenuDelegate> menuDelegate;
    NSArray *number;
    NSArray *menus;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *menus;
@property (strong, nonatomic) id<MenuDelegate> menuDelegate;


@end
