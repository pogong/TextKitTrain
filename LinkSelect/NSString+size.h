//
//  NSString+size.h
//  xiangyue
//
//  Created by pogong on 15/8/17.
//  Copyright (c) 2016年 pogong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (size)

-(CGSize)calculateSizeWithLimitSize:(CGSize)limitSize font:(UIFont *)font lineSpace:(CGFloat)lineSpace;

@end
