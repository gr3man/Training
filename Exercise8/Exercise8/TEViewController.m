//
//  TEViewController.m
//  Exercise8
//
//  Created by Tuấn Nguyễn Anh on 5/8/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"
#import "TECustomLabel.h"

@interface TEViewController ()

@end

@implementation TEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    TECustomLabel *lab = [[TECustomLabel alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 30)];
    [lab setText:@"There are 9 new notifications"];
    [self.view addSubview:lab];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
