//
//  TEViewController.h
//  Exercise4_2
//
//  Created by Tuan Nguyen Anh on 4/10/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property (copy, nonatomic) NSArray *fields;
- (IBAction)returnKeyPressed:(id)sender;

- (void)hideKeyboard;

- (void)registerForKeyboardNotifications;

- (void)keyboardWasShown:(NSNotification *)aNotification;

- (void)keyboardWillChangeFrame:(NSNotification *)aNotification;

- (void)keyboardDidChangeFrame:(NSNotification *)aNotification;

- (void)keyboardWillBeHidden:(NSNotification*)aNotification;

- (void) resetContentInset;

- (void) changeFrame:(CGSize)kbSize;

- (void) changeContentInset:(CGSize)kbSize;

@end
