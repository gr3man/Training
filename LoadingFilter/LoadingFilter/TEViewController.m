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
@synthesize viewShowImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    TEScrollFilterPicker *imageList = [[TEScrollFilterPicker alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 80)];
    imageList.delegateImage = self;
    [self.view addSubview:imageList];
    
    UIImage *img = imageList.imageToFilter;
    viewShowImage = [[UIImageView alloc] initWithImage:img];
    [viewShowImage setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
    [viewShowImage setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:viewShowImage];
}

- (void)didSelectFilteredImage:(UIImage *)filteredImage
{
    [viewShowImage setImage:filteredImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
