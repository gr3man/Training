//
//  TEViewController.h
//  Exercise6_2
//
//  Created by Tuan Nguyen Anh on 4/18/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) NSMutableArray *fields;
@property (strong, nonatomic) NSMutableArray *fields;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSMutableDictionary *mutableDic;

- (IBAction)selectedRank:(UISegmentedControl *)sender;
- (IBAction)selectedSex:(UISegmentedControl *)sender;
- (IBAction)btnFinishPressed:(UIButton *)sender;
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
