//
//  NSString+size.m
//  xiangyue
//
//  Created by pogong on 15/8/17.
//  Copyright (c) 2016年 pogong. All rights reserved.
//

#import "NSString+size.h"

@implementation NSString (size)

-(CGSize)calculateSizeWithLimitSize:(CGSize)limitSize font:(UIFont *)font lineSpace:(CGFloat)lineSpace
{
	
	NSDictionary * attributes = nil;
	
	if (lineSpace > 0) {
		NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
		paragraphStyle.lineSpacing = lineSpace;
		attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
	}else{
		attributes = @{NSFontAttributeName:font};
	}
	
	return [self boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
	
}

@end
