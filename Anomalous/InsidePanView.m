//
//  InsidePanView.m
//  TextKitTrain
//
//  Created by pogong on 16/7/14.
//  Copyright © 2016年 pogong. All rights reserved.
//

#import "InsidePanView.h"

@implementation InsidePanView

- (void)drawRect:(CGRect)rect
{
	[self.tintColor setFill];
	[[UIBezierPath bezierPathWithOvalInRect: self.bounds] fill];
}


@end
