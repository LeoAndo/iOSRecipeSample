//
//  DrawPathView.m
//  ch4DrawPath
//
//  Created by shoeisha on 2013/11/04.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "DrawPathView.h"

typedef enum {
    DRAW_PATH_NOTHING,
    DRAW_PATH_LINE,
    DRAW_PATH_FAT_LINE,
    DRAW_PATH_LINE_CAP,
    DRAW_PATH_LINE_JOIN_BEVEL,
    DRAW_PATH_LINE_JOIN_MITER,
    DRAW_PATH_DASH_LINE,
    DRAW_PATH_CURVE_LINE,
    DRAW_PATH_ARC,
    DRAW_PATH_RECT,
    DRAW_PATH_ECLIPSE,
    DRAW_PATH_GRAPH,
} DrawPathKind;

@implementation DrawPathView
{
    DrawPathKind drawPathKind;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        drawPathKind = DRAW_PATH_NOTHING;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    switch(drawPathKind) {
        case DRAW_PATH_LINE:
            [self drawPathLine];
            break;
        case DRAW_PATH_FAT_LINE:
            [self drawPathFatLine];
            break;
        case DRAW_PATH_LINE_CAP:
            [self drawPathLineCap];
            break;
        case DRAW_PATH_LINE_JOIN_BEVEL:
            [self drawPathLineJoinBevel];
            break;
        case DRAW_PATH_LINE_JOIN_MITER:
            [self drawPathLineJoinMiter];
            break;
        case DRAW_PATH_DASH_LINE:
            [self drawPathDashlLine];
            break;
        case DRAW_PATH_CURVE_LINE:
            [self drawPathCurveLine];
            break;
        case DRAW_PATH_ARC:
            [self drawPathArc];
            break;
        case DRAW_PATH_RECT:
            [self drawPathRectangle];
            break;
        case DRAW_PATH_ECLIPSE:
            [self drawPathEclipse];
            break;
        case DRAW_PATH_GRAPH:
            [self drawPathGraph];
            break;
        default:;
    }
    drawPathKind = DRAW_PATH_NOTHING;
}

- (IBAction)drawLine:(id)sender {
    [self drawSelect:DRAW_PATH_LINE];
}

- (IBAction)drawFatLine:(id)sender {
    [self drawSelect:DRAW_PATH_FAT_LINE];
}

- (IBAction)drawLineCap:(id)sender {
    [self drawSelect:DRAW_PATH_LINE_CAP];
}

- (IBAction)drawLineJoinBevel:(id)sender {
    [self drawSelect:DRAW_PATH_LINE_JOIN_BEVEL];
}

- (IBAction)drawLineJoinMiter:(id)sender {
    [self drawSelect:DRAW_PATH_LINE_JOIN_MITER];
}

- (IBAction)drawDashLine:(id)sender {
    [self drawSelect:DRAW_PATH_DASH_LINE];
}

- (IBAction)drawCurveLine:(id)sender {
    [self drawSelect:DRAW_PATH_CURVE_LINE];
}

- (IBAction)drawArc:(id)sender {
    [self drawSelect:DRAW_PATH_ARC];
}

- (IBAction)drawGraph:(id)sender {
    [self drawSelect:DRAW_PATH_GRAPH];
}

- (IBAction)drawEclipse:(id)sender {
    [self drawSelect:DRAW_PATH_ECLIPSE];
}

- (IBAction)drawRectangle:(id)sender {
    [self drawSelect:DRAW_PATH_RECT];
}

-(void)drawSelect:(DrawPathKind) kind {
    drawPathKind = kind;
    [self setNeedsDisplay];
}

// 直線を描画する
-(void) drawPathLine {
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // パスに始点を設定する
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 描画実行
    [path stroke];
}

// 太い線を描画する
-(void) drawPathFatLine {
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 線の太さを設定する
    path.lineWidth = 8.0;
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // パスに始点を設定する
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 描画実行
    [path stroke];
}


// 先の丸い線を描画する
-(void) drawPathLineCap {
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 線の太さを設定する
    [path setLineWidth:8.0];
    
    // 線の先端スタイルを設定する
    [path setLineCapStyle:kCGLineCapRound];
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // パスに始点を設定する
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 描画実行
    [path stroke];
}

// 折れ線の角をカットして描画する
-(void) drawPathLineJoinBevel {
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 線の太さを設定する
    [path setLineWidth:8.0];
    
    // 角をカットする
    [path setLineJoinStyle:kCGLineJoinBevel];
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // パスに始点を設定する
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 描画実行
    [path stroke];
}

// 折れ線の角を尖らせて描画する
-(void) drawPathLineJoinMiter {
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 線の太さを設定する
    [path setLineWidth:8.0];
    
    // 角を尖らせる
    [path setLineJoinStyle:kCGLineJoinMiter];
    
    float startX = 100;
    float startY = 200;
    float pointX1 = 200;
    float pointY1 = 300;
    float pointX2 = 100;
    float pointY2 = 400;
    
    // パスに始点を設定する
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX1, pointY1)];
    
    // パスに直線を追加する
    [path addLineToPoint:CGPointMake(pointX2, pointY2)];
    
    // 描画実行
    [path stroke];
}

// 破線を描画する
-(void) drawPathDashlLine {
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float startX = 100;
    float startY = 200;
    float pointX = 200;
    float pointY = 300;
    float endX = 100;
    float endY = 400;
    
    // 始点を設定する
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 中点を設定する
    [path addLineToPoint:CGPointMake(pointX, pointY)];
    
    // 終点を設定する
    [path addLineToPoint:CGPointMake(endX, endY)];
    
    // 破線パターンを設定
    const CGFloat lengths[] = {5,5,5,5,10,5};
    [path setLineDash:lengths count:5 phase:6];
    
    // 描画実行
    [path stroke];
}

// 曲線を描画する
-(void) drawPathCurveLine {
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float startX = 200;
    float startY = 200;
    float controlPointX = 180;
    float controlPointY = 300;
    float endX = 50;
    float endY = 300;
    
    // 始点を設定する
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 終点とコントロールポイントを設定する
    [path addQuadCurveToPoint:CGPointMake(endX, endY)
                 controlPoint:CGPointMake(controlPointX, controlPointY)];
    
    // 描画実行
    [path stroke];
}

// 曲線を描画する(補助線付き)
-(void) drawPathCurveLineWithAsistLine {
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float startX = 200;
    float startY = 200;
    float controlPointX = 180;
    float controlPointY = 300;
    float endX = 50;
    float endY = 300;
    
    // 始点を設定する
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 終点とコントロールポイントを設定する
    [path addQuadCurveToPoint:CGPointMake(endX, endY)
                 controlPoint:CGPointMake(controlPointX, controlPointY)];
    
    // 描画実行
    [path stroke];
    
    // 補助線を描画する
    [path removeAllPoints];
    
    // 始点を設定する
    [path moveToPoint:CGPointMake(startX, startY)];
    
    // 中点を設定する
    [path addLineToPoint:CGPointMake(controlPointX, controlPointY)];
    
    // 終点を設定する
    [path addLineToPoint:CGPointMake(endX, endY)];
    
    // 破線パターンを設定
    const CGFloat lengths[] = {5,5,5,5,10,5};
    [path setLineDash:lengths count:5 phase:6];
    
    // 補助線に赤色を指定
    [[UIColor redColor] setStroke];
    
    // 描画実行
    [path stroke];
    
}

// 円弧を描画する（中心点、半径、開始角、終了角、回転方向を指定）
-(void) drawPathArc {
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 円弧のパラメータを作成する
    float centerX = 160;        // 中心点
    float centerY = 300;
    CGPoint center = CGPointMake(centerX, centerY);
    float radius = 100;         // 半径
    float startAngle = 0;       // 開始角 単位はラジアン
    float endAngle = M_PI*1.5;  // 終了角 単位はラジアン
    BOOL clockwise = YES;       // 時計回り
    
    // 円弧のパスを追加する
    [path addArcWithCenter:center
                    radius:radius
                startAngle:startAngle
                  endAngle:endAngle
                 clockwise:clockwise];
    
    // 描画実行
    [path stroke];
}

// 矩形を描画する
-(void) drawPathRectangle {
    // 矩形のパラメータを生成する
    int x = 100;        // 矩形のx座標
    int y = 150;        // 矩形のy座標
    int width = 100;    // 矩形の高さ
    int height = 200;   // 矩形の幅
    CGRect rect = CGRectMake(x, y, width, height);
    
    // 矩形のパスを生成する
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    // 線の色を設定する
    [[UIColor redColor] setStroke];
    
    // 描画実行
    [path stroke];
}

// 楕円を描画する
-(void) drawPathEclipse {
    // 矩形のパラメータを生成する
    int x = 100;        // 矩形のx座標
    int y = 150;        // 矩形のy座標
    int width = 100;    // 矩形の高さ
    int height = 200;   // 矩形の幅
    CGRect rect = CGRectMake(x, y, width, height);
    
    // 楕円のパスを生成する
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    // 線の色を設定する
    [[UIColor greenColor] setStroke];
    
    // 描画実行
    [path stroke];
}


// 円グラフを描画する
-(void) drawPathGraph {
    
    // 円グラフの中心点
    float centerX = 160;
    float centerY = 300;
    CGPoint center = CGPointMake(centerX, centerY);
    
    // 円グラフの半径
    float radius = 100;
    
    // グラフ内容の割合テーブル（％）
    int parcentTable[] = {15,26,40,19};
    
    // 開始角、０は３時の方向
    float startAngle = 0;
    
    // テーブルの内容分、扇形を描画する
    for (int i=0; i<4; i++) {
        // グラフの割合
        int percent = parcentTable[i];
        
        // 割合から角度を算出
        float angle = M_PI*2 * percent / 100.0;

        // 塗りつぶし色を設定する
        UIColor *color;
        switch (i) {
            case 0:
                color = [UIColor blueColor];
                break;
            case 1:
                color = [UIColor yellowColor];
                break;
            case 2:
                color = [UIColor greenColor];
                break;
            case 3:
                color = [UIColor redColor];
                break;
        }
        
        // 扇形を描画する
        [self drawFunShapeWithCenter:center radius:radius startAngle:startAngle angle:angle color:color];
        
        // 次の開始角を算出
        startAngle += angle;
    }
}

// 扇型を描画する
-(void) drawFunShapeWithCenter:(CGPoint)center      // 中心点
                        radius:(float)radius        // 半径
                    startAngle:(float)startAngle    // 開始角
                         angle:(float) angle        // 角度
                         color:(UIColor *)color     // 色
{
    
    // UIBezierPath のインスタンスを生成する
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 終了角を算出s
    float endAngle = startAngle + angle;
    
    // PATH に円グラフの扇形を設定
    [path addArcWithCenter:center       // 中心点
                    radius:radius       // 半径
                startAngle:startAngle   // 開始角
                  endAngle:endAngle     // 終了角
                 clockwise:YES];        // 時計回りを指定
    
    // 円弧から中心点への直線を追加する
    [path addLineToPoint:center];
    
    // パスを閉じて扇型を作成する
    [path closePath];
    
    // 塗りつぶし色を設定する
    if (color) {
        [color setFill];
    }

    // 描画実行
    // 塗りつぶし
    [path fill];
    
    // 縁を描画
    [path stroke];
}


@end
