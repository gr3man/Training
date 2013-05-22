//
//  TEViewController.m
//  Exercise 1
//
//  Created by Nguyen Anh Tuan on 4/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "TEViewController.h"

@implementation TEViewController
@synthesize passWordField;
@synthesize userNameField;
@synthesize btnSubmit;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 40, 20)];
    [btn1 setTitle:@"Submit" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(submitPressed:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:btn1];
}

- (void)viewDidUnload
{
    [self setUserNameField:nil];
    [self setPassWordField:nil];
    [self setBtnSubmit:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)submitPressed:(id)sender {
    NSString *userName = userNameField.text;
    NSString *passWord = passWordField.text;
    
    UIAlertView *alert;
    if([userName isEqualToString:@"tung"] && [passWord isEqualToString:@"12345"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Login Successed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    } 
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Login Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    [alert show];
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
    [self.passWordField becomeFirstResponder];
}

- (IBAction)passwordFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
    [self submitPressed:nil];
    
}

- (IBAction)backgroundTap:(id)sender{
    [self.userNameField resignFirstResponder];
    [self.passWordField resignFirstResponder];
}
@end
