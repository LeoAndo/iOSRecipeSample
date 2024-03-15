//
//  DrawTextView.m
//  ch4DrawText
//
//  Created by shoeisha on 2013/11/07.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "DrawTextView.h"

typedef enum {
    DRAW_TEXT_NOTHING,
    DRAW_TEXT_TEXT,
    DRAW_TEXT_COLOR,
    DRAW_TEXT_FONT,
    DRAW_TEXT_RECT,
} DrawTextKind;

@implementation DrawTextView {
    DrawTextKind drawTextKind;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        drawTextKind = DRAW_TEXT_NOTHING;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    switch(drawTextKind) {
        case DRAW_TEXT_TEXT:
            [self drawTextText];
            break;
        case DRAW_TEXT_COLOR:
            [self drawTextColor];
            break;
        case DRAW_TEXT_FONT:
            [self drawTextFont];
            break;
        case DRAW_TEXT_RECT:
            [self drawTextRect:rect];
            break;
        default:;
    }
}

- (IBAction)drawText:(id)sender {
    [self drawSelect:DRAW_TEXT_TEXT];
}

- (IBAction)drawTextWithColor:(id)sender {
    [self drawSelect:DRAW_TEXT_COLOR];
}

- (IBAction)drawTextWithFont:(id)sender {
    [self drawSelect:DRAW_TEXT_FONT];
}

- (IBAction)drawTextWithRect:(id)sender {
    [self drawSelect:DRAW_TEXT_RECT];
}

-(void)drawSelect:(DrawTextKind) kind {
    drawTextKind = kind;
    [self setNeedsDisplay];
}

// テキストを描画
- (void)drawTextText {
    // 文字列を生成
    NSString *string = @"あめんぼ赤いなあいうえお";
    
    // 表示座標
    float x = 10;
    float y = 200;

    // 文字列を描画
    [string drawAtPoint:CGPointMake(x, y) withAttributes:nil];
}

// 色を指定して文字列を描画
- (void)drawTextColor {
    // 文字列を生成
    NSString *string = @"あめんぼ赤いなあいうえお";
    
    // 表示座標
    float x = 10;
    float y = 200;
    
    // 色データを生成
    UIColor *color = [UIColor colorWithRed:1.0f green:0.0f blue: 0.0f alpha:1.0f];

    // 文字列の属性を生成
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                            color, NSForegroundColorAttributeName, nil];
    
    // 文字列を描画
    [string drawAtPoint:CGPointMake(x, y)
         withAttributes:attrs];
}

// フォントを指定して文字列を描画
- (void)drawTextFont {
    // 文字列を生成
    NSString *string = @"あめんぼ赤いなあいうえお";
    
    // 表示座標
    float x = 10;
    float y = 200;
    
    // フォントパラメータを生成
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:20];
    
    // 属性を生成
    NSDictionary* attrs=[NSDictionary dictionaryWithObjectsAndKeys:
                         font,NSFontAttributeName, nil];
    
    // 文字列を描画
    [string drawAtPoint:CGPointMake(x, y)
         withAttributes:attrs];
    
}

// 矩形内に文字列を描画
- (void)drawTextRect:(CGRect)rect {
    // 文字列を生成
    NSString *string = @"吾輩わがはいは猫である。名前はまだ無い。どこで生れたかとんと見当けんとうがつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。";
    
    // 描画範囲の矩形を設定
    float x = 100;
    float y = 200;
    float width = 100;
    float height = 100;
    
    // 描画範囲の矩形を生成
    CGRect textrect = CGRectMake(x, y, width, height);
    
    // 矩形内に文字列を描画
    [string drawInRect:textrect
        withAttributes:nil];
    

    // 描画範囲を示すため、描画範囲の矩形を表示
    // 文字列を囲む矩形のパスを生成
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:textrect];
    
    // 矩形を描画
    [path stroke];
}

@end

