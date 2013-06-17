//
//  TEViewController.m
//  Exercise4_2
//
//  Created by Tuan Nguyen Anh on 4/10/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import "TEViewController.h"
#import "TELoginCell.h"

@interface TEViewController ()

@end

@implementation TEViewController

static NSString *CellTableIdentifier = @"CellTableIdentifier";
BOOL keyboardIsVisible;
UITableView *tableView;
CGSize keyboardSize;
//NSMutableArray *Cells;
UITextField *activeField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.fields = @[@[@{@"label":@"Name", @"placeHolder":@"John "}],
                    @[@{@"label":@"Address", @"placeHolder":@"example@gmail.com"}],
                    @[@{@"label":@"Password", @"placeHolder":@"Required"}],
                    @[@{@"label":@"Description", @"placeHolder":@"My Gmail Account"}],
                    @[@{@"label":@"Description", @"placeHolder":@"My Gmail Account"}],
                    @[@{@"label":@"Description", @"placeHolder":@"My Gmail Account"}]];
    tableView = (id)[self.view viewWithTag:10];
    UINib *nib = [UINib nibWithNibName:@"TELoginCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    tableView.allowsSelection = NO;
    //UITapGestureRecognizer xử lý sự kiện khi người dùng thao tác với thành phần nào đó.
    //Target: đổi tượng người dùng tương tác.
    //action: hàm xử lý sự kiện.
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [tableView addGestureRecognizer:gestureRecognizer];
    //Cells = [[NSMutableArray alloc] init];
    [self registerForKeyboardNotifications];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.fields count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TELoginCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    NSDictionary *rowData = self.fields[indexPath.section][0];
    [cell.textView addTarget:self action:@selector(returnKeyPressed:) forControlEvents:(UIControlEventEditingDidEndOnExit)];
    //[Cells addObject:cell];
    cell.labelView.text = rowData[@"label"];
    cell.textView.placeholder = rowData[@"placeHolder"];
    cell.textView.tag = indexPath.section;
    cell.textView.delegate = self;

    if([cell.labelView.text isEqualToString:@"Password"]){
        [cell.textView setSecureTextEntry:YES];
    }
    if(indexPath.section == [self.fields count]-1){
        cell.textView.returnKeyType = UIReturnKeyDone;
    }
    else {
        cell.textView.returnKeyType = UIReturnKeyNext;
    }
    
    return cell;
}

- (IBAction)returnKeyPressed:(id)sender{
    UITextField *textField = (UITextField *)sender;
    if(textField.tag == [self.fields count] -1 ){
        //cell = Cells[textField.tag+1];
        [[[UIAlertView alloc] initWithTitle:@"Login" message:@"Done" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else{
        //[self resetContentInset];
        
        UITextField *nextTextField = (UITextField *)[self.view viewWithTag:textField.tag+1];
        [nextTextField becomeFirstResponder];
    }
}

- (void)hideKeyboard{

    [self.view endEditing:YES];
//    TELoginCell *cell;
//    for (NSInteger j = 0; j < [tableView numberOfSections]; ++j)
//    {
//        for (NSInteger i = 0; i < [tableView numberOfRowsInSection:j]; ++i)
//        {
//            cell = (TELoginCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
//            [cell.textView resignFirstResponder];
//        }
//    }
    [self resetContentInset];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    keyboardSize = kbSize;
    [self changeContentInset:kbSize];
    
}

- (void)keyboardDidChangeFrame:(NSNotification *)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    keyboardSize = kbSize;
    [self changeFrame:kbSize];
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
    keyboardIsVisible = YES;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    //tableView.contentInset = contentInsets;
    //tableView.scrollIndicatorInsets = contentInsets;
    //[self resetContentInset];
    keyboardIsVisible = NO;
}

- (void) resetContentInset{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    tableView.contentInset = UIEdgeInsetsZero;
    tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    tableView.contentOffset = CGPointZero;
    [UIView commitAnimations];
}

- (void) changeContentInset:(CGSize)kbSize{
    UIEdgeInsets contentInsets;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height - 20, 0.0);
    } else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.width - 20, 0.0);
    }
    [tableView setContentInset:contentInsets];
}

//- (void) changeFrame:(CGSize)kbSize{
//    
//    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
//    
//    TELoginCell *c = (TELoginCell *)activeField.superview.superview;
//    //TELoginCell *c = Cells[activeField.tag];
//    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
//    CGRect aRect = [[UIScreen mainScreen] bounds];
//    aRect.size.height -= statusBarFrame.size.height;
//    NSLog([NSString stringWithFormat:@"%f %f", kbSize.height, aRect.size.width]);
//    aRect.size.height -= kbSize.height;
//    if(tableView.contentOffset.y > c.frame.origin.y){
//        CGPoint scrollPoint = CGPointMake(0.0, c.frame.origin.y - 10);
//        [tableView setContentOffset:scrollPoint animated:YES];
//    }
//    else if (aRect.size.height + tableView.contentOffset.y < c.frame.origin.y + c.frame.size.height) {
//        CGPoint scrollPoint = CGPointMake(0.0, c.frame.size.height + c.frame.origin.y - aRect.size.height + 10);
//        [tableView setContentOffset:scrollPoint animated:YES];
//        NSLog([NSString stringWithFormat:@"%f 1 %f 2 %f", c.frame.size.height, c.frame.origin.y,aRect.size.height]);
//    }
//}


- (void) changeFrame:(CGSize)kbSize{
    //get cell of currently active textField.
    TELoginCell *c = (TELoginCell *)activeField.superview.superview;
    //Get screen size. This screen include tableView and statusBar
    CGRect aRect = [[UIScreen mainScreen] bounds];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect screen; //This is tableView size.
    CGSize keyboard;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    //Căn chỉnh theo chiều.
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        aRect.size.height -= statusBarFrame.size.height;
        screen.size = CGSizeMake(aRect.size.width, aRect.size.height);
        keyboard = kbSize;
    } else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        //If orientation is landspace, height and width swap.
        aRect.size.width -= statusBarFrame.size.width;
        screen.size = CGSizeMake(aRect.size.height, aRect.size.width);
        keyboard.height = kbSize.width;
        keyboard.width = kbSize.height;
    }
    
    screen.size.height -= keyboard.height;
    //Kiểm tra xem textField có ở cao hơn màn hình không, nếu có thì dịch xuống.
    if(tableView.contentOffset.y > c.frame.origin.y){
        CGPoint scrollPoint = CGPointMake(0.0, c.frame.origin.y - 10);
        [tableView setContentOffset:scrollPoint animated:YES];
    }
    //Kiểm tra textfield có bị bàn phím che mất không, nếu có thì dịch lên.
    else if (screen.size.height + tableView.contentOffset.y < c.frame.origin.y + c.frame.size.height) {
        CGPoint scrollPoint = CGPointMake(0.0, c.frame.size.height + c.frame.origin.y - screen.size.height + 10);
        [tableView setContentOffset:scrollPoint animated:YES];
        //NSLog([NSString stringWithFormat:@"%f 1 %f 2 %f", c.frame.size.height, c.frame.origin.y,screen.size.height]);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    //Check if keyboard is visible change the contenOffset and contentInset of tableView.
    if(keyboardIsVisible){
        [self changeFrame:keyboardSize];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
    //if keyboard invisible, reset tableview
    if(!keyboardIsVisible){
        [self resetContentInset];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations{
    //support all orientation
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //when device in lanspace mode, only show landspaceright mode.
    //when device in portrait or portraitupsidedown, only show Portrait mode.
    return UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortrait;
}
- (BOOL)shouldAutorotate{
    return YES;
}

@end
