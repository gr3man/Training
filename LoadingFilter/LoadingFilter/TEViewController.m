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
    actiIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    viewShowImage = [[UIImageView alloc] initWithImage:img];
    [viewShowImage setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
    [viewShowImage setContentMode:UIViewContentModeScaleAspectFit];
    [viewShowImage setBackgroundColor:[UIColor blackColor]];
    actiIndicator.center = viewShowImage.center;
    actiIndicator.frame = CGRectMake(viewShowImage.frame.size.width / 2 - 20.0, viewShowImage.frame.size.height / 2 - 20.0, 40.0, 40.0);
    [viewShowImage addSubview:actiIndicator];
    [self.view addSubview:viewShowImage];
}

- (void)didSelectFilteredImage:(UIImage *)image toShow:(BOOL)isFilteredImage
{
    if(!isFilteredImage){
        [actiIndicator startAnimating];
    } else {
        [actiIndicator stopAnimating];
    }
    [viewShowImage setImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
