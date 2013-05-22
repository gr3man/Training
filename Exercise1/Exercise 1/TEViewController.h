//
//  TEViewController.h
//  Exercise 1
//
//  Created by Nguyen Anh Tuan on 4/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
- (IBAction)submitPressed:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)passwordFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end
