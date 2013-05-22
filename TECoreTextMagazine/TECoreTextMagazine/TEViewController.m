//
//  TEViewController.m
//  TECoreTextMagazine
//
//  Created by Tuấn Nguyễn Anh on 5/10/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"
#import "TEMarkupParser.h"
#import "TECTView.h"

@interface TEViewController ()

@end

@implementation TEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    TEMarkupParser *p = [[[TEMarkupParser alloc] init] autorelease];
    NSAttributedString* attString = [p attrStringFromMarkup: text];
    [(TECTView *)self.view setAttString: attString];
    [(TECTView *)[self view] buildFrames];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
