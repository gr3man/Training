//
//  BIDViewController.m
//  Exercise2 PlainTable
//
//  Created by Tuan Nguyen Anh on 4/8/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import "BIDViewController.h"

@interface BIDViewController ()

@end

@implementation BIDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    number = @[@"one",@"two",@"three",@"four",@"five"];
    detailText = @[@"first detail",@"second detail",@"third detail",@"fouth detail",@"fifth detail"];
    
    CGRect frm = [[UIScreen mainScreen] applicationFrame];
    UITableView *table = [[UITableView alloc] initWithFrame:frm style:UITableViewStylePlain];
    table.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    table.delegate = self;
    table.dataSource = self;
    //[table reloadData];
    //[self.view addSubview:table];
    self.view = table;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [number count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",number[indexPath.row]]];
    cell.imageView.image = image;
    cell.detailTextLabel.text = detailText[indexPath.row];
    cell.textLabel.text = number[indexPath.row];
    return cell;
}

@end
