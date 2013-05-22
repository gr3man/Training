//
//  TEViewController.m
//  Exercise6
//
//  Created by Tuan Nguyen Anh on 4/17/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import "TEViewController.h"

@interface TEViewController ()

@end

@implementation TEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.segmentBar2 setFrame:CGRectMake(self.segmentBar2.frame.origin.x, self.segmentBar2.frame.origin.y, self.segmentBar2.frame.size.width, self.segmentPlain.frame.size.height)];
    //self.segmentPlain.state;
    //NSLog([NSString stringWithFormat:@"%f",self.segmentBar.frame.size.height]);
    [self.segmentBar2 setSegmentedControlStyle:UISegmentedControlStyleBezeled];
    
//    NSDictionary *colorSelected= [NSDictionary dictionaryWithObjectsAndKeys:
//                          nil, UITextAttributeTextColor,
//                          nil];
    
    NSDictionary *colorUnselected= [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor lightGrayColor], UITextAttributeTextColor,
                          nil];
    
//    NSArray *arr= @[@"one",@"two",@"three"];
//    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:arr];
//    seg.frame = CGRectMake(100, 100,seg.frame.size.width,100);
//    [seg setSegmentedControlStyle:UISegmentedControlStyleBar];
//        [self.view addSubview:seg];
    
    //[self.segmentBar2 setTitleTextAttributes:colorUnselected forState:UIControlStateNormal];
    //[self.segmentBar2 setTitleTextAttributes:colorUnselected forState:UIControlStateSelected];
}

- (IBAction)segmentClicked:(UISegmentedControl *)sender{
    NSInteger index = sender.selectedSegmentIndex;
    [self.segmentPlain setSelectedSegmentIndex:index];
    [self.segmentBorder setSelectedSegmentIndex:index];
    [self.segmentBar setSelectedSegmentIndex:index];
    [self.segmentBar2 setSelectedSegmentIndex:index];
    //[self.segmentBar2 setTintColor:self.segmentPlain.tintColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
