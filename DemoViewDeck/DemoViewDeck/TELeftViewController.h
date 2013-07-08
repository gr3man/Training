//
//  TELeftViewController.h
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/4/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "TERightViewController.h"

@protocol MenuDelegate <NSObject>

- (void) didSelectMenu : (NSString *)menuName;

@end

@interface TELeftViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    id<MenuDelegate> menuDelegate;
    NSArray *number;
    NSMutableArray *menus;
    TERightViewController *rightMenu;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *menus;
@property (strong, nonatomic) id<MenuDelegate> menuDelegate;


@end
