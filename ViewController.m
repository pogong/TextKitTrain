//
//  ViewController.m
//  TextKitTrain
//
//  Created by pogong on 16/7/12.
//  Copyright © 2016年 pogong. All rights reserved.
//

#import "ViewController.h"
#import "DividedViewController.h"
#import "LinkSelectViewController.h"
#import "AnomalousViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
	
	self.title = @"TextKitTrain";
	
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = @[@"文字分View排版",@"文字在不规则的区域内显示",@"链接点击"];
    
    CGRect frame = self.view.bounds;
    frame.size.height -= 64;
    frame.origin.y = 64;
    
    _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        DividedViewController * de = [[DividedViewController alloc]init];
        [self.navigationController pushViewController:de animated:YES];
	}else if (indexPath.row == 1){
		AnomalousViewController * an = [[AnomalousViewController alloc]init];
		[self.navigationController pushViewController:an animated:YES];
	}else{
		LinkSelectViewController * linktap = [[LinkSelectViewController alloc]init];
		[self.navigationController pushViewController:linktap animated:YES];
	}
}

@end
