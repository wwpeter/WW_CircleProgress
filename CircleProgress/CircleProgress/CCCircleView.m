//
//  CCCircleView.m
//  WWCycleProgress
//
//  Created by 王威 on 16/8/19.
//  Copyright © 2016年 WW. All rights reserved.
//

#import "CCCircleView.h"

#define GreenColor [UIColor colorWithRed:98/255.0 green:200/255.0 blue:166/255.0 alpha:1]
// rgb颜色转换（16进制->10进制）
#define KHexColor(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define kFont(size) [UIFont systemFontOfSize:size]

@interface CCCircleView()
@property(nonatomic, strong) UILabel *labProgress;
//红色的layer
@property(nonatomic, strong) CAShapeLayer *progressLayer;
//灰色的layer
@property(nonatomic, strong) CAShapeLayer *grayProgressLayer;

@end


@implementation CCCircleView
{
    float _p;
    NSTimer *_timer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
         [self drawProgressCircleWithEndAngle:-M_PI_2 + M_PI * 2 isGrayCircle:YES];
    }
    return self;
}

- (void)setProgress:(double)progress {
    _progress = progress;
    NSString *s = @"%";
    self.labProgress.text = [NSString stringWithFormat:@"%0.1f%@",progress*100,s];
    if (_progress == 1.0) {
       self.labProgress.text = @"100%";
    }
    [self performSelector:@selector(delay) withObject:nil afterDelay:0.5];
    [self drawProgressCircleWithEndAngle:- M_PI_2 + M_PI * 2* (_progress) isGrayCircle:NO];
}

- (void)delay {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.020 target:self selector:@selector(drawProgress) userInfo:nil repeats:YES];
}

- (void)drawProgress {
    if (_p > self.progress + 0.01) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    [self drawProgressCircleWithEndAngle:- M_PI_2 + M_PI * 2* (_p) isGrayCircle:NO];
    _p += 0.05;
}

- (void)drawProgressCircleWithEndAngle:(CGFloat)endAngle isGrayCircle:(BOOL)isGrayCircle  {
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2);
    CGFloat radius = self.frame.size.width / 2;
    CGFloat startA = -M_PI_2;
    CGFloat endA = endAngle;
    
    CAShapeLayer *layer;
    if(isGrayCircle) {
        layer = self.grayProgressLayer;
    }
    else {
        layer = self.progressLayer;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    layer.path =[path CGPath];
}

- (UILabel *)labProgress {
    if (!_labProgress) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, self.frame.size.width-2, self.frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2);
        label.textColor = KHexColor(0xf23f3f);
        label.font = kFont(14);
        [self addSubview:label];
        _labProgress = label;
    }
    return _labProgress;
}

- (CAShapeLayer *)grayProgressLayer {
    if(!_grayProgressLayer) {
        _grayProgressLayer = [CAShapeLayer layer];
        _grayProgressLayer.frame = self.bounds;
        _grayProgressLayer.fillColor = [[UIColor clearColor] CGColor];
        _grayProgressLayer.strokeColor = [KHexColor(0xffe8e8) CGColor];
        _grayProgressLayer.opacity = 1;
        _grayProgressLayer.lineCap = kCALineCapRound;
        _grayProgressLayer.lineWidth = 4.0;
        [self.layer addSublayer:_grayProgressLayer];
    }
    return _grayProgressLayer;
}

- (CAShapeLayer *)progressLayer {
    if(!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor = [[UIColor clearColor] CGColor];
        _progressLayer.strokeColor = [KHexColor(0xf23f3f) CGColor];
        _progressLayer.opacity = 1;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineWidth = 4.0;
        [self.layer addSublayer:_progressLayer];
    }
    return _progressLayer;
}

#pragma mark - setter


- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}
@end
