//
//  TEViewController.m
//  Exercise8_2
//
//  Created by Tuấn Nguyễn Anh on 5/14/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"
#import "TECustomView.h"

@interface TEViewController ()

@end

@implementation TEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    TECustomView *label = [[[TECustomView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)] autorelease];
    [label setString:@"2 There are 62 new notifications 542"];
    [self.view addSubview:label.imageView];
    [self.view addSubview:label];
    [label release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
