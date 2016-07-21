//
//  ZCSelectableLabel.h
//  ZCSelectableLabel
//
//  Created by pogong on 16/6/4.
//  Copyright © 2016年 pogong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZCSelectableLabelTapHander)(NSString * str,NSRange range);

@interface ZCSelectableLabel : UILabel

@property(nonatomic,copy)ZCSelectableLabelTapHander tapHander;

@property (nonatomic, copy) NSMutableArray * selectableRanges;

@end
