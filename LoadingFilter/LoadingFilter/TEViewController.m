//
//  TEViewController.m
//  LoadingFilter
//
//  Created by Tuấn Nguyễn Anh on 6/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"

@interface TEViewController ()

@end

@implementation TEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    TEScrollFilterPicker *a = [[TEScrollFilterPicker alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 70)];
    a.pagingEnabled = YES;
    [self.view addSubview:a];
    UIImage *img = [UIImage imageNamed:@"img1.jpg"];
     UIImageView *view = [[UIImageView alloc] initWithImage:img];
    [view setFrame:CGRectMake(0, 100, self.view.frame.size.width, img.size.height/img.size.width * self.view.frame.size.width)];
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
