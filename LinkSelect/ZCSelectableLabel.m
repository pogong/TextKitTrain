//
//  ZCSelectableLabel.m
//  ZCSelectableLabel
//
//  Created by pogong on 16/6/4.
//  Copyright © 2016年 pogong. All rights reserved.
//

#import "ZCSelectableLabel.h"
#import "ZCSelectableLabelRange.h"

@interface ZCSelectableLabel ()<NSLayoutManagerDelegate>

@property(nonatomic,strong)NSTextStorage * textStorage;
@property(nonatomic,strong)NSLayoutManager * textLayoutManager;
@property(nonatomic,strong)NSTextContainer * textContainer;

@property(nonatomic)BOOL isTouchMove;
@property(nonatomic)NSRange selectRange;

@end
@implementation ZCSelectableLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectableRanges = [NSMutableArray array];
        [self setUpTextSys];
    }
    return self;
}

-(void)setUpTextSys
{
    self.textStorage = [[NSTextStorage alloc] init];
    self.textLayoutManager = [[NSLayoutManager alloc] init];
    self.textContainer = [[NSTextContainer alloc]init];
    
    [self.textStorage addLayoutManager:self.textLayoutManager];
    [self.textLayoutManager addTextContainer:self.textContainer];
    
    self.textLayoutManager.delegate = self;
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self.textStorage setAttributedString:[ZCSelectableLabel sanitizeAttributedString:attributedText]];
    [self setNeedsDisplay];
}

//加入分行 消息
+ (NSAttributedString *)sanitizeAttributedString:(NSAttributedString *)attributedString
{
    NSRange range;
    NSParagraphStyle * paragraphStyle = [attributedString attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
    
    if (paragraphStyle == nil)
    {
        return attributedString;
    }
    
    NSMutableParagraphStyle * mutableParagraphStyle = [paragraphStyle mutableCopy];
    mutableParagraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableAttributedString * restyled = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    [restyled addAttribute:NSParagraphStyleAttributeName value:mutableParagraphStyle range:NSMakeRange(0, restyled.length)];
    
    return restyled;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isTouchMove = NO;
    CGPoint point = [[touches anyObject] locationInView:self];
    ZCSelectableLabelRange * selectRange = [self  getSelectRangeWithPoint:point];
    if (selectRange) {
        [self updateShowTextWithRange:selectRange.range color:selectRange.color];
    }else{
        [super touchesBegan:touches withEvent:event];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isTouchMove = YES;
    [super touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isTouchMove == NO) {
        CGPoint point = [[touches anyObject] locationInView:self];
        ZCSelectableLabelRange * selectRange = [self getSelectRangeWithPoint:point];
        if (selectRange) {
            if (_tapHander) {
                _tapHander([[self.attributedText string]substringWithRange:selectRange.range],selectRange.range);
            }
        }else{
            [super touchesEnded:touches withEvent:event];
        }
    }
    [self updateShowTextWithRange:NSMakeRange(0, 0) color:nil];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isTouchMove = NO;
    [super touchesCancelled:touches withEvent:event];
}

-(void)updateShowTextWithRange:(NSRange)range color:(UIColor *)color
{
    NSMutableAttributedString * muAttr = [self.attributedText mutableCopy];
    if (range.length <= 0) {
        [muAttr removeAttribute:NSBackgroundColorAttributeName range:self.selectRange];
    }else{
        [muAttr addAttribute:NSBackgroundColorAttributeName value:color range:range];
    }
    self.attributedText = [muAttr copy];
    self.selectRange = range;
}

-(ZCSelectableLabelRange *)getSelectRangeWithPoint:(CGPoint)location
{
    if (self.attributedText.string.length == 0)
    {
        return nil;
    }
    
    //空白偏移
    CGPoint textOffset;
    NSRange glyphRange = [self.textLayoutManager glyphRangeForTextContainer:self.textContainer];
    textOffset = [self calcTextOffsetForGlyphRange:glyphRange];
    
    location.x -= textOffset.x;
    location.y -= textOffset.y;
    
    //点击字符的index
    NSUInteger touchedChar = [self.textLayoutManager glyphIndexForPoint:location inTextContainer:self.textContainer];
    
    //由点字符的index反拿字符所在位置
    NSRange lineRange;
    CGRect lineRect = [self.textLayoutManager lineFragmentUsedRectForGlyphAtIndex:touchedChar effectiveRange:&lineRange];
    
    //确认点击点在字符所在位置的区域内
    if (CGRectContainsPoint(lineRect, location) == NO)
    {
        return nil;
    }
    
    //由字符的index确认在哪个selectableRange.range内
    for (ZCSelectableLabelRange * selectableRange in self.selectableRanges)
    {
        NSRange range = selectableRange.range;
        if ((touchedChar >= range.location) && touchedChar < (range.location + range.length))
        {
            return selectableRange;
        }
    }
    
    return nil;
}

- (CGPoint)calcTextOffsetForGlyphRange:(NSRange)glyphRange
{
    CGPoint textOffset = CGPointZero;
    
    CGRect textBounds = [self.textLayoutManager boundingRectForGlyphRange:glyphRange inTextContainer:self.textContainer];
    CGFloat paddingHeight = (self.bounds.size.height - textBounds.size.height) / 2.0f;
    if (paddingHeight > 0)
    {
        textOffset.y = paddingHeight;//横向书写的文字,两侧留白,空白偏移也是0
    }
    
    return textOffset;
}

- (void)drawTextInRect:(CGRect)rect
{
    CGPoint textOffset;
    NSRange glyphRange = [self.textLayoutManager glyphRangeForTextContainer:self.textContainer];
    textOffset = [self calcTextOffsetForGlyphRange:glyphRange];
    
    //绘制背景
    [self.textLayoutManager drawBackgroundForGlyphRange:glyphRange atPoint:textOffset];
    //绘制字符
    [self.textLayoutManager drawGlyphsForGlyphRange:glyphRange atPoint:textOffset];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.textContainer.size = self.bounds.size;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.textContainer.size = self.bounds.size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textContainer.size = self.bounds.size;
}

////保持链接不被打断
//- (BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex
//{
//    NSRange range;
//    UIColor * color = [layoutManager.textStorage attribute:NSForegroundColorAttributeName
//                                                   atIndex:charIndex
//                                            effectiveRange:&range];
//    
//    return !(color && charIndex > range.location && charIndex <= NSMaxRange(range));
//}
@end
