//
//  TECenterViewController.m
//  DemoViewDeck
//
//  Created by Tuan Nguyen Anh on 7/7/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECenterViewController.h"

@interface TECenterViewController ()

@end

@implementation TECenterViewController

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
    // Do any additional setup after loading the view from its nib.
    
    leftController = [[TELeftViewController alloc] init];
    rightController = [[TERightViewController alloc] init];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleRightView)];
    
    self.viewDeckController.rightSize = 400;
    self.viewDeckController.leftController = leftController;
    leftController.menuDelegate = self;
    self.viewDeckController.leftSize = self.view.frame.size.width - 400;
}

- (void) didSelectMenu:(NSString *)menuName
{
    if ([menuName isEqualToString:@"menu 2"] || [menuName isEqualToString:@"menu 4"]) {
        self.navigationItem.rightBarButtonItem = nil;
        [self.viewDeckController closeOpenView];
        //haveRightMenu = NO;
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleRightView)];
        [self.viewDeckController closeOpenView];
        //haveRightMenu = YES;
        rightController.labelDetail.text = [NSString stringWithFormat:@"This is details for %@", menuName];
        self.viewDeckController.rightController = rightController;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
