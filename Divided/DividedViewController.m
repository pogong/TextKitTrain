//
//  ZCViewController.m
//  TextKitDemo
//
//  Created by pogong on 16/7/13.
//  Copyright © 2016年 pogong. All rights reserved.
//

#import "DividedViewController.h"

@interface DividedViewController ()
@property (weak, nonatomic) UITextView *twoTextView;
@property (weak, nonatomic) UITextView *thrTextView;
@end

@implementation DividedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	self.title = @"Divided";
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.edgesForExtendedLayout = UIRectEdgeAll;
	
	// Load text
	NSTextStorage *sharedTextStorage = [NSTextStorage new];
	[sharedTextStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"show" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
	
	// Create a new text view on the original text storage
	NSLayoutManager *otherLayoutManager = [NSLayoutManager new];
	[sharedTextStorage addLayoutManager: otherLayoutManager];
	
	NSTextContainer *otherTextContainer = [NSTextContainer new];
	[otherLayoutManager addTextContainer: otherTextContainer];
	
	UITextView *twoTextView = [[UITextView alloc] initWithFrame:self.twoContainerView.bounds textContainer:otherTextContainer];
	twoTextView.backgroundColor = self.twoContainerView.backgroundColor;
	twoTextView.translatesAutoresizingMaskIntoConstraints = YES;
	twoTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	twoTextView.scrollEnabled = NO;
	
	[self.twoContainerView addSubview: twoTextView];
	self.twoTextView = twoTextView;
	
	
	// Create a second text view on the new layout manager text storage
	NSTextContainer *thirdTextContainer = [NSTextContainer new];
	[otherLayoutManager addTextContainer: thirdTextContainer];
	
	UITextView *thrTextView = [[UITextView alloc] initWithFrame:self.thrContainerView.bounds textContainer:thirdTextContainer];
	thrTextView.backgroundColor = self.thrContainerView.backgroundColor;
	thrTextView.translatesAutoresizingMaskIntoConstraints = YES;
	thrTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[self.thrContainerView addSubview: thrTextView];
	self.thrTextView = thrTextView;
	
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
