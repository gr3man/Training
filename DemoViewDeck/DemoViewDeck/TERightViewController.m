//
//  TERightViewController.m
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TERightViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "IIViewDeckController.h"

@interface TERightViewController ()

@end

@implementation TERightViewController

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
