//
//  LinktapViewController.m
//  TextKitTrain
//
//  Created by pogong on 16/7/12.
//  Copyright © 2016年 pogong. All rights reserved.
//

#import "LinkSelectViewController.h"
#import "ZCSelectableLabel.h"
#import "ZCSelectableLabelRange.h"
#import "NSString+size.h"

@interface LinkSelectViewController ()
{
	ZCSelectableLabel * _selectableLabel;
}
@end

@implementation LinkSelectViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.title = @"LinkSelect";
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.edgesForExtendedLayout = UIRectEdgeAll;
	
	NSString * showText = @"Lilei 回复 韩梅梅:How are you?I am fine!And you?Me too";
	
	_selectableLabel = [[ZCSelectableLabel alloc]init];
	_selectableLabel.layer.borderWidth = 0.5;
	_selectableLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_selectableLabel.userInteractionEnabled = YES;
	_selectableLabel.numberOfLines = 0;
	_selectableLabel.font = [UIFont systemFontOfSize:16.0];
	_selectableLabel.text = showText;
	_selectableLabel.tapHander = ^(NSString * str,NSRange range){
		NSLog(@"-----%@",str);
	};
	CGSize size =[showText calculateSizeWithLimitSize:CGSizeMake(MAIN_SCREEN_W - 80.0, 500.0) font:_selectableLabel.font lineSpace:0];
	_selectableLabel.frame = CGRectMake(40.0, 64.0+10.0, size.width, size.height);
	[self.view addSubview:_selectableLabel];
	
	NSRange range1 = [showText rangeOfString:@"Lilei"];
	NSRange range2 = [showText rangeOfString:@"韩梅梅"];
	
    NSMutableAttributedString * attributedString = [_selectableLabel.attributedText mutableCopy];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:127/255.0 green:145/255.0 blue:255/255.0 alpha:1.0] range:range1];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:127/255.0 green:145/255.0 blue:255/255.0 alpha:1.0] range:range2];
    
    _selectableLabel.attributedText = attributedString;
    
	ZCSelectableLabelRange * selectRange1 = [[ZCSelectableLabelRange alloc]init];
	selectRange1.range = range1;
	selectRange1.color = [UIColor colorWithRed:191/255.0 green:223/255.0 blue:254/255.0 alpha:1.0];
	
	ZCSelectableLabelRange * selectRange2 = [[ZCSelectableLabelRange alloc]init];
	selectRange2.range = range2;
	selectRange2.color = [UIColor colorWithRed:191/255.0 green:223/255.0 blue:254/255.0 alpha:1.0];
	
	[_selectableLabel.selectableRanges addObject:selectRange1];
	[_selectableLabel.selectableRanges addObject:selectRange2];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
