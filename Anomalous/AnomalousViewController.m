//
//  AnomalousViewController.m
//  TextKitTrain
//
//  Created by pogong on 16/7/12.
//  Copyright © 2016年 pogong. All rights reserved.
//

#import "AnomalousViewController.h"
#import "InsidePanView.h"

@interface AnomalousViewController ()
{
	UITextView * _textView;
	InsidePanView * _panView;
	CGPoint _panOffset;
}
@end

@implementation AnomalousViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"Anomalous";
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.edgesForExtendedLayout = UIRectEdgeAll;
	
	_textView = [[UITextView alloc]init];
	_textView.frame = CGRectMake(0.0, 64.0, MAIN_SCREEN_W, MAIN_SCREEN_H - 64.0);
	[self.view addSubview:_textView];
	
	[_textView.textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"show" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
	
	_panView = [[InsidePanView alloc]initWithFrame:CGRectMake((MAIN_SCREEN_W - 150.0)/2, 64.0, 150.0, 150.0)];
	[_panView setTitle:@"pan" forState:UIControlStateNormal];
	_panView.backgroundColor = [UIColor clearColor];
	[_textView addSubview:_panView];
	UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAct:)];
	[_panView addGestureRecognizer:pan];
	
	[self updateShowZone];
}

-(void)updateShowZone
{
	CGRect ovalFrame = [_textView convertRect:_panView.bounds fromView:_panView];
	
	// Simply set the exclusion path
	UIBezierPath * ovalPath = [UIBezierPath bezierPathWithOvalInRect:ovalFrame];
	_textView.textContainer.exclusionPaths = @[ovalPath];
	[_textView setNeedsDisplay];
}

-(void)panAct:(UIPanGestureRecognizer *)pan
{
	// Capute offset in view on begin
	if (pan.state == UIGestureRecognizerStateBegan)
		_panOffset = [pan locationInView:_panView];
	
	// Update view location
	CGPoint location = [pan locationInView: self.view];
	CGPoint circleCenter = _panView.center;
	
	circleCenter.x = location.x - _panOffset.x + _panView.frame.size.width / 2;
	circleCenter.y = location.y - _panOffset.y + _panView.frame.size.width / 2;
	_panView.center = circleCenter;
	
	// Update exclusion path
	[self updateShowZone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
