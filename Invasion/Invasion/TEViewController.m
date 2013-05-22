//
//  TEViewController.m
//  Invasion
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
    CTFontRef fontBlack = CTFontCreateWithName((CFStringRef)@"Didot", 20.0f, NULL);
    
    NSDictionary *attrDictionaryBlack = [NSDictionary dictionaryWithObjectsAndKeys:
                                    (id)fontBlack,kCTFontAttributeName,
                                    (id)[[UIColor blackColor] CGColor], kCTForegroundColorAttributeName,
                                    nil];
    CFRelease(fontBlack);
    
    CTFontRef fontBlue = CTFontCreateWithName((CFStringRef)@"Palatino-Italic", 20.0f, NULL);
    
    NSDictionary *attrDictionaryBlue = [NSDictionary dictionaryWithObjectsAndKeys:
                                        (id)fontBlue, kCTFontAttributeName,
                                        (id)[[UIColor blueColor] CGColor], kCTForegroundColorAttributeName,
                                        nil];
    CFRelease(fontBlue);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"txt"];
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text attributes:attrDictionaryBlack];
    [attString addAttributes:attrDictionaryBlue range:NSMakeRange(414, 492)];
    
    [attString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:20] range:
     NSMakeRange(907, 370)];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(907,370)];
    [(TECustomView *) [self view] setAttString:attString];
    [attString release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
