//
//  TEViewController.m
//  Exercise6_2
//
//  Created by Tuan Nguyen Anh on 4/18/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import "TEViewController.h"
#import "TEInputCell.h"

@interface TEViewController ()

@end

@implementation TEViewController

static NSString *CellTableIdentifier = @"CellTableIdentifier";
static NSString *CellTableRanking = @"CellTableRanking";
BOOL keyboardIsVisible;
CGSize keyboardSize;
//NSMutableArray *Cells;
UITextField *activeField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView numberOfRowsInSection:1]*[self.tableView.]
    
	// Do any additional setup after loading the view, typically from a nib.
    self.fields = [[NSMutableArray alloc] initWithObjects:@"Ranking",@"Phone",@"Country",@"State",@"City",@"Sex", nil];
    NSArray *temp = @[@"111",@"",@"",@"",@"",@""];
    self.data = [[NSDictionary alloc] initWithObjects:temp forKeys:self.fields];
    self.mutableDic = [[NSMutableDictionary alloc] initWithObjects:temp forKeys:self.fields];
    //NSLog([NSString stringWithFormat:@"%@",[self.data objectForKey:@"Ranking"]]);
    UIButton *btnFinish = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnFinish setTitle:@"Finish" forState:(UIControlStateNormal)];
    [btnFinish setFrame:CGRectMake(self.view.frame.size.width/2 - 50, self.tableView.rowHeight * ([self.fields count]) + 45 + self.tableView.sectionHeaderHeight, 100, 40)];
    [btnFinish addTarget:self action:@selector(btnFinishPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:btnFinish];
    
    UINib *nib = [UINib nibWithNibName:@"TEInputCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    self.tableView.allowsSelection = NO;
    //UITapGestureRecognizer xử lý sự kiện khi người dùng thao tác với thành phần nào đó.
    //Target: đổi tượng người dùng tương tác.
    //action: hàm xử lý sự kiện.
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    //Cells = [[NSMutableArray alloc] init];
    [self registerForKeyboardNotifications];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.fields count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Additional information";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableRanking];
        if(cell == nil){
            NSArray *arrRanking = @[@"Professional",@"Amateur",@"Hobbyist"];
            UISegmentedControl *segRank = [[UISegmentedControl alloc] initWithItems:arrRanking];
            [segRank addTarget:self action:@selector(selectedRank:) forControlEvents:UIControlEventValueChanged];
            [segRank setSegmentedControlStyle:UISegmentedControlStyleBar];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableRanking];
            [segRank setFrame:CGRectMake(5, 5, cell.frame.size.width - 30, cell.frame.size.height - 10)];
            [cell.contentView addSubview:segRank];
        }
        return cell;
    }
    else if(indexPath.row == [self.fields count]-1){
        NSArray *arrSex = @[@"Female",@"Male"];
        UISegmentedControl *segSex = [[UISegmentedControl alloc] initWithItems:arrSex];
        [segSex addTarget:self action:@selector(selectedSex:) forControlEvents:UIControlEventValueChanged];
        [segSex setSegmentedControlStyle:UISegmentedControlStyleBar];
        TEInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        [cell.textView removeFromSuperview];
        cell.labelView.text = @"Sex";
        CGFloat dis = cell.labelView.frame.origin.x + cell.labelView.frame.size.width + 8;
        [segSex setFrame:CGRectMake(dis, 5, cell.frame.size.width - dis - 30, cell.frame.size.height - 10)];
        [cell.contentView addSubview:segSex];
        return cell;
    }
    else{
        TEInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        [cell.textView addTarget:self action:@selector(returnKeyPressed:) forControlEvents:(UIControlEventEditingDidEndOnExit)];
        //[Cells addObject:cell];
        //NSLog([NSString stringWithFormat:@"%d",indexPath.row]);
        cell.labelView.text = self.fields[indexPath.row];
        cell.textView.tag = indexPath.row;
        cell.textView.delegate = self;
        
        if([cell.labelView.text isEqualToString:@"Phone"]){
            [cell.textView setKeyboardType:UIKeyboardTypeNumberPad];
        }
//        if(indexPath.row == [self.fields count]-1){
//            cell.textView.returnKeyType = UIReturnKeyDone;
//        }
//        else {
//            cell.textView.returnKeyType = UIReturnKeyNext;
//        }
        return cell;
    }
}

- (IBAction)returnKeyPressed:(id)sender{
    UITextField *textField = (UITextField *)sender;
    if(textField.tag == [self.fields count]-1){
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
    keyboardIsVisible = NO;
}


- (void) resetContentInset{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.tableView.contentOffset = CGPointZero;
    [UIView commitAnimations];
}

- (void) changeContentInset:(CGSize)kbSize{
    UIEdgeInsets contentInsets;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 20, 0.0);
    } else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.width + 20, 0.0);
    }
    [self.tableView setContentInset:contentInsets];
}

- (void) changeFrame:(CGSize)kbSize{
    //get cell of currently active textField.
    TEInputCell *c = (TEInputCell *)activeField.superview.superview;
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
    if(self.tableView.contentOffset.y > c.frame.origin.y){
        CGPoint scrollPoint = CGPointMake(0.0, c.frame.origin.y - 10);
        [self.tableView setContentOffset:scrollPoint animated:YES];
    }
    //Kiểm tra textfield có bị bàn phím che mất không, nếu có thì dịch lên.
    else if (screen.size.height + self.tableView.contentOffset.y < c.frame.origin.y + c.frame.size.height) {
        CGPoint scrollPoint = CGPointMake(0.0, c.frame.size.height + c.frame.origin.y - screen.size.height + 10);
        [self.tableView setContentOffset:scrollPoint animated:YES];
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
    TEInputCell *c = (TEInputCell *)textField.superview.superview;
    activeField = nil;
    [self.mutableDic setObject:textField.text forKey:c.labelView.text];
    //NSLog([NSString stringWithFormat:@"%@",[self.mutableDic objectForKey:c.labelView.text]]);
    //if keyboard invisible, reset tableview
    if(!keyboardIsVisible){
        [self resetContentInset];
    }
}

- (IBAction)selectedRank:(UISegmentedControl *)sender{
    [self.mutableDic setObject:[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]] forKey:@"Ranking"];
}

- (IBAction)selectedSex:(UISegmentedControl *)sender{
    [self.mutableDic setObject:[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]] forKey:@"Sex"];
}

- (IBAction)btnFinishPressed:(UIButton *)sender{

    //NSLog([NSString stringWithFormat:@"%@",c.textView.text]);
    BOOL chk = YES;
    [self hideKeyboard];
    NSString *temp;
    for (id key in self.mutableDic) {
        temp = [self.mutableDic objectForKey:key];
        if(temp.length == 0){
            chk = NO;
        }
    }
    if(!chk){
        [[[UIAlertView alloc] initWithTitle:@"Login" message:@"please fill in all fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else{
        NSString *mes = [NSString stringWithFormat:@"Ranking: %@\nPhone: %@\nCountry: %@\nState: %@\nCity: %@\nSex: %@",[self.mutableDic objectForKey:@"Ranking"],[self.mutableDic objectForKey:@"Phone"],[self.mutableDic objectForKey:@"Country"],[self.mutableDic objectForKey:@"State"],[self.mutableDic objectForKey:@"City"],[self.mutableDic objectForKey:@"Sex"]];
        [[[UIAlertView alloc] initWithTitle:@"Login" message:mes delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
