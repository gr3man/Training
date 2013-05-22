//
//  TEViewController.m
//  FunnyText
//
//  Created by Tuấn Nguyễn Anh on 5/14/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"
#import "TECustomView.h"
#import <CoreText/CoreText.h>

@interface TEViewController ()

@end

@implementation TEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"Chalkduster", 22.0f, NULL);
    NSDictionary *attrDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    (id)fontRef,kCTFontAttributeName,
                                    (id)[[UIColor blueColor] CGColor], kCTForegroundColorAttributeName,
                                    (id)[[UIColor redColor] CGColor], kCTStrokeColorAttributeName,
                                    (id)[NSNumber numberWithFloat:-3.0], kCTStrokeWidthAttributeName,
                                    nil];
    CFRelease(fontRef);
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Everybody loves iNVASIVECODE!" attributes:attrDictionary];
    [(TECustomView *) [self view] setAttString:attString];
    [attString release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
