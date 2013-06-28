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
    TEScrollFilterPicker *imageList = [[TEScrollFilterPicker alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 70)];
    imageList.pagingEnabled = YES;
    [self.view addSubview:imageList];
    UIImage *img = imageList.imageToFilter;
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
