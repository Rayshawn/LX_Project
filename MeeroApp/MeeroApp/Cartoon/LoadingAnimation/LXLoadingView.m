//
//  LXLoadingView.m
//  MeeroApp
//
//  Created by shawn on 2018/6/4.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import "LXLoadingView.h"
#import "LXLoadingLayer.h"

static NSString * const kName = @"name";

static CGFloat const kStep1Duration = 1.0;
static CGFloat const kStep2Duration = 0.5;
static CGFloat const kStep3Duration = 0.15;
static CGFloat const kStep4Duration = 0.25;
static CGFloat const kStep5Duration = 0.5;
static CGFloat const kBeforeStep6SuccessDelay = 0.1;
static CGFloat const kStep6SuccessDuration = 1;
static CGFloat const kStep6FailDuration = 0.5;
static CGFloat const kStep7FailDuration = 0.1;

static CGFloat const kRadius = 40;
static CGFloat const kLineWidth = 6;
static CGFloat const kVerticalMoveLayerHeight = 15;
static CGFloat const kVerticalThinLayerWidth = 3;
static CGFloat const kMoveArcLineLayerWidth = 3;
static CGFloat const kYScale = 0.8;
static CGFloat const kVerticalFatLayerWidth = 6;

@interface LXLoadingView ()<CAAnimationDelegate>
@property (nonatomic, strong) LXLoadingLayer * circleLayer;
@property (nonatomic, strong) CAShapeLayer *moveArcLayer;
@property (nonatomic, strong) CALayer * verticalMoveLayer;

@property (nonatomic, strong) CAShapeLayer * verticalDisappearLayer;
@property (nonatomic, strong) CAShapeLayer * verticalAppearLayer;

@property (nonatomic, strong) CAShapeLayer * leftAppearLayer;
@property (nonatomic, strong) CAShapeLayer * rightAppearLayer;

@property (nonatomic, strong) CAShapeLayer * checkMarkLayer;
@property (nonatomic, strong) CAShapeLayer * exclamationMarkTopLayer;
@property (nonatomic, strong) CAShapeLayer * exclamationMarkBottomLayer;




@property (nonatomic, assign) BOOL isSuccess;


@property (nonatomic, strong) UIColor *likeBlackColor;
@property (nonatomic, strong) UIColor *likeGreenColor;
@property (nonatomic, strong) UIColor *likeRedColor;

@end

@implementation LXLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.likeBlackColor = [UIColor colorWithRed:0x46/255.0 green:0x4d/255.0 blue:0x65/255.0 alpha:1.0];
        self.likeGreenColor = [UIColor colorWithRed:0x32/255.0 green:0xa9/255.0 blue:0x82/255.0 alpha:1.0];
        self.likeRedColor = [UIColor colorWithRed:0xff/255.0 green:0x61/255.0 blue:0x51/255.0 alpha:1.0];
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.likeBlackColor = [UIColor colorWithRed:0x46/255.0 green:0x4d/255.0 blue:0x65/255.0 alpha:1.0];
        self.likeGreenColor = [UIColor colorWithRed:0x32/255.0 green:0xa9/255.0 blue:0x82/255.0 alpha:1.0];
        self.likeRedColor = [UIColor colorWithRed:0xff/255.0 green:0x61/255.0 blue:0x51/255.0 alpha:1.0];
    }
    return self;
}

#pragma mark - public
- (void)startSuccess {
    [self reset];
    self.isSuccess = YES;
    [self doStep1];
}
- (void)startFail {
    [self reset];
    self.isSuccess = NO;
    [self doStep1];
}
#pragma mark - reset
- (void)reset {
    [self.circleLayer removeFromSuperlayer];
    [self.moveArcLayer removeFromSuperlayer];
    [self.verticalMoveLayer removeFromSuperlayer];
    [self.verticalDisappearLayer removeFromSuperlayer];
    [self.verticalAppearLayer removeFromSuperlayer];
    [self.leftAppearLayer removeFromSuperlayer];
    [self.rightAppearLayer removeFromSuperlayer];
    [self.checkMarkLayer removeFromSuperlayer];
    [self.exclamationMarkTopLayer removeFromSuperlayer];
    [self.exclamationMarkBottomLayer removeFromSuperlayer];
    [self.layer removeAllAnimations];
}
#pragma mark - step1  画圆
- (void)doStep1 {
    self.circleLayer = [LXLoadingLayer layer];
    self.circleLayer.contentsScale = [UIScreen mainScreen].scale;
    self.circleLayer.color = self.likeBlackColor;
    self.circleLayer.lineWidth = kLineWidth;
    self.circleLayer.bounds = CGRectMake(0, 0, kRadius * 2 + kLineWidth, kRadius * 2 + kLineWidth);
    self.circleLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [self.layer addSublayer:self.circleLayer];
    self.circleLayer.progress = 1;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.duration = kStep1Duration;
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.delegate = self;
    [animation setValue:@"step1" forKey:kName];
    [self.circleLayer addAnimation:animation forKey:nil];
}
#pragma mark - step2  移动的小圆弧
- (void)doStep2 {
    self.moveArcLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.moveArcLayer];
    self.moveArcLayer.frame = self.layer.bounds;
    // 轨迹path
    UIBezierPath *moveArcPath = [UIBezierPath bezierPath];
    // 圆心
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    // d
    CGFloat d = kRadius / 2.f;
    CGPoint arcCenter = CGPointMake(center.x - kRadius - d, center.y);
    CGFloat arcRadius = kRadius * 2 + d;
    CGFloat origin = M_PI * 2;
    CGFloat dest = M_PI * 2 - asin(kRadius * 2 / arcRadius);
    
    [moveArcPath addArcWithCenter:arcCenter radius:arcRadius startAngle:origin endAngle:dest clockwise:NO];
    self.moveArcLayer.path = moveArcPath.CGPath;
    self.moveArcLayer.lineWidth = kMoveArcLineLayerWidth;
    self.moveArcLayer.strokeColor = self.likeBlackColor.CGColor;
    self.moveArcLayer.fillColor = nil;
    
    CGFloat SSFrom = 0;
    CGFloat SSTo = 0.9;
    
    CGFloat SEFrom = 0.1;
    CGFloat SETo = 1;
    
    // CAShapeLayer 的属性值赋值都为结束值
    self.moveArcLayer.strokeStart = SSTo;
    self.moveArcLayer.strokeEnd = SETo;
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @(SSFrom);
    startAnimation.toValue = @(SSTo);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @(SEFrom);
    endAnimation.toValue = @(SETo);
    
    
    CAAnimationGroup *step2 = [CAAnimationGroup animation];
    step2.animations = @[startAnimation, endAnimation];
    step2.duration = kStep2Duration;
    step2.delegate = self;
    [step2 setValue:@"step2" forKey:kName];
    step2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.moveArcLayer addAnimation:step2 forKey:nil];
}
#pragma mark - step3 最高处下降的线 最高点为 View的中心点 + kRadius * 2
- (void)doStep3 {
    [self.moveArcLayer removeFromSuperlayer];
    
    self.verticalMoveLayer = [CALayer layer];
    self.verticalMoveLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.verticalMoveLayer];
    
    self.verticalMoveLayer.bounds = CGRectMake(0, 0, kVerticalFatLayerWidth, kVerticalMoveLayerHeight);
    self.verticalMoveLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - kRadius * 2 + kVerticalMoveLayerHeight / 2.f);
    self.verticalMoveLayer.backgroundColor = self.likeBlackColor.CGColor;
    
    // position
    CGPoint originPosition = self.verticalMoveLayer.position;
    CGPoint destPosition = CGPointMake(originPosition.x, CGRectGetMidY(self.bounds) - kRadius - kVerticalMoveLayerHeight / 2.f);
    
    // end status
    self.verticalMoveLayer.position = destPosition;
    
    CABasicAnimation *step3 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    step3.fromValue = @(originPosition.y);
    step3.toValue = @(destPosition.y);
    step3.duration = kStep3Duration;
    step3.delegate = self;
    [step3 setValue:@"step3" forKey:kName];
    [self.verticalMoveLayer addAnimation:step3 forKey:nil];
}

#pragma mark - step4
- (void)doStep4 {
    [self prepareForStep4];
    [self doStep4a];
    [self doStep4b];
    [self doStep4c];
}

// 4阶段a小圆变形
- (void)doStep4a {
    CGRect frame = self.circleLayer.frame;
    self.circleLayer.anchorPoint = CGPointMake(0.5, 1);// 底部
    self.circleLayer.frame = frame;// frame是根据bounds、anchorPoint和position这3个属性算出来，anchorPoint 改变会导致frame的改变，frame重新赋值，避免突变
    CGFloat yFromScale = 1.0;
    CGFloat yToScale = kYScale;
    
    CGFloat xFromScale = 1.0;
    CGFloat xToScale = 1.1;
    
    // end status
    self.circleLayer.transform = CATransform3DMakeScale(xToScale, yToScale, 1);
    
    // animation
    CABasicAnimation *yAnima = [CABasicAnimation animationWithKeyPath:@"transForm.scale.y"];
    yAnima.fromValue = @(yFromScale);
    yAnima.toValue = @(yToScale);
    
    CABasicAnimation *xAnima = [CABasicAnimation animationWithKeyPath:@"transForm.scale.x"];
    xAnima.fromValue = @(xFromScale);
    xAnima.toValue = @(xToScale);
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[yAnima,xAnima];
    anima.duration = kStep4Duration;
    anima.delegate = self;
    [anima setValue:@"step4" forKey:kName];
    [self.circleLayer addAnimation:anima forKey:nil];
}

// 4阶段b：逐渐消失的细线
- (void)doStep4b {
    self.verticalDisappearLayer = [CAShapeLayer layer];
    self.verticalDisappearLayer.frame = self.bounds;
    [self.layer addSublayer:self.verticalDisappearLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = kVerticalMoveLayerHeight;
    CGFloat originY = CGRectGetMidY(self.bounds) - kRadius - height;
    CGFloat pathHeight = height + kRadius * 2 * (1-kYScale);
    CGFloat destY = originY + pathHeight;
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY)];
    self.verticalDisappearLayer.path = path.CGPath;
    self.verticalDisappearLayer.lineWidth = kVerticalThinLayerWidth;
    self.verticalDisappearLayer.strokeColor = self.likeBlackColor.CGColor;
    self.verticalDisappearLayer.fillColor = nil;
    
    CGFloat SSFrom = 0;
    CGFloat SSTo = 1.0;
    
    CGFloat SEFrom = height / pathHeight;
    CGFloat SETo = 1.0;
    
    self.verticalDisappearLayer.strokeStart = SSTo;
    self.verticalDisappearLayer.strokeEnd = SETo;
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @(SSFrom);
    startAnimation.toValue = @(SSTo);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @(SEFrom);
    endAnimation.toValue = @(SETo);
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[startAnimation, endAnimation];
    anima.duration = kStep4Duration;
    [self.verticalDisappearLayer addAnimation:anima forKey:nil];
}

// 4阶段c: 逐渐出现的粗线
- (void)doStep4c {
    self.verticalAppearLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.verticalAppearLayer];
    self.verticalAppearLayer.frame = self.bounds;
    
    UIBezierPath *step4cPath = [UIBezierPath bezierPath];
    CGFloat originY = CGRectGetMidY(self.bounds) - kRadius;
    CGFloat destY = CGRectGetMidY(self.bounds) + kRadius;
    [step4cPath moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [step4cPath addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY)];
    self.verticalAppearLayer.path = step4cPath.CGPath;
    self.verticalAppearLayer.lineWidth = kVerticalFatLayerWidth;
    self.verticalAppearLayer.strokeColor = self.likeBlackColor.CGColor;
    self.verticalAppearLayer.fillColor = nil;
    
    // SS(strokeStart)
    CGFloat SSFrom = 0;
    CGFloat SSTo = 1 - kYScale;
    
    // SE(strokeEnd)
    CGFloat SEFrom = 0;
    CGFloat SETo = 0.5;
    
    // end status
    self.verticalAppearLayer.strokeStart = SSTo;
    self.verticalAppearLayer.strokeEnd = SETo;
    
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @(SSFrom);
    startAnimation.toValue = @(SSTo);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @(SEFrom);
    endAnimation.toValue = @(SETo);
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[startAnimation, endAnimation];
    anima.duration = kStep4Duration;
    [self.verticalAppearLayer addAnimation:anima forKey:nil];
}

- (void)prepareForStep4 {
    [self.verticalMoveLayer removeFromSuperlayer];
}

#pragma mark - step5
- (void)doStep5 {
    [self prepareForStep5];
    [self doStep5a];
    [self doStep5b];
    [self doStep5c];
    [self doStep5d];
}
- (void)prepareForStep5 {
    [self.verticalDisappearLayer removeFromSuperlayer];
}

- (void)doStep5a {// 圆圈复原
    //
    self.circleLayer.transform = CATransform3DIdentity;
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    anima.duration = kStep5Duration;
    anima.fromValue = @(kYScale);
    anima.toValue = @1;
    anima.delegate = self;
    [anima setValue:@"step5" forKey:kName];
    [self.circleLayer addAnimation:anima forKey:nil];
}

// 竖线全长
- (void)doStep5b {
    // SS(strokeStart)
    CGFloat SSFrom = 1 - kYScale;
    CGFloat SSTo = 0;
    
    // SE(strokeEnd)
    CGFloat SEFrom = 0.5;
    CGFloat SETo = 1;
    
    // end status
    self.verticalAppearLayer.strokeStart = SSTo;
    self.verticalAppearLayer.strokeEnd = SETo;
    
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @(SSFrom);
    startAnimation.toValue = @(SSTo);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @(SEFrom);
    endAnimation.toValue = @(SETo);
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[startAnimation, endAnimation];
    anima.duration = kStep5Duration;
    [self.verticalAppearLayer addAnimation:anima forKey:nil];
}
// 坐下斜线
- (void)doStep5c {
    self.leftAppearLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.leftAppearLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint originPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [path moveToPoint:originPoint];
    CGFloat deltaX = kRadius * sin(M_PI / 3);
    CGFloat deltaY = kRadius * cos(M_PI / 3);
    CGPoint destPoint = CGPointMake(originPoint.x - deltaX, originPoint.y + deltaY);
    [path addLineToPoint:destPoint];
    
    self.leftAppearLayer.path = path.CGPath;
    self.leftAppearLayer.lineWidth = kLineWidth;
    self.leftAppearLayer.strokeColor = self.likeBlackColor.CGColor;
    self.leftAppearLayer.fillColor = nil;
    
    // end status
    self.leftAppearLayer.strokeEnd = 1;
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.duration = kStep5Duration;
    anima.fromValue = @0;
    anima.toValue = @1;
    [self.leftAppearLayer addAnimation:anima forKey:nil];
}

// 右下斜线成长到全长
- (void)doStep5d {
    self.rightAppearLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.rightAppearLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint originPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [path moveToPoint:originPoint];
    CGFloat deltaX = kRadius * sin(M_PI / 3);
    CGFloat deltaY = kRadius * cos(M_PI / 3);
    CGPoint destPoint = originPoint;
    destPoint.x += deltaX;
    destPoint.y += deltaY;
    [path addLineToPoint:destPoint];
    self.rightAppearLayer.path = path.CGPath;
    self.rightAppearLayer.lineWidth = kLineWidth;
    self.rightAppearLayer.strokeColor = self.likeBlackColor.CGColor;
    self.rightAppearLayer.fillColor = nil;
    
    // end status
    CGFloat strokeEnd = 1;
    
    // animation
    self.rightAppearLayer.strokeEnd = strokeEnd;
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.duration = kStep5Duration;
    anima.fromValue = @0;
    anima.toValue = @(strokeEnd);
    [self.rightAppearLayer addAnimation:anima forKey:nil];
}

#pragma mark - step6 success
- (void)doStep6Success {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kBeforeStep6SuccessDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{// 1毫秒(ms)=0.001秒(s) NSEC_PER_SEC 为秒
        [self prepareForStep6Success];
        [self processStep6SuccessA];
        [self processStep6SuccessB];
    });
}

- (void)prepareForStep6Success {
    [self.verticalAppearLayer removeFromSuperlayer];
    [self.leftAppearLayer removeFromSuperlayer];
    [self.rightAppearLayer removeFromSuperlayer];
}
// 圆变色
- (void)processStep6SuccessA {
    self.circleLayer.color = self.likeGreenColor;
}
// 对号
- (void)processStep6SuccessB {
    self.checkMarkLayer = [CAShapeLayer layer];
    self.checkMarkLayer.frame = self.bounds;
    [self.layer addSublayer:self.checkMarkLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint firstPoint = CGPointMake(centerPoint.x - kRadius / 2.f, centerPoint.y);
    [path moveToPoint:firstPoint];
    CGPoint secondPoint = CGPointMake(centerPoint.x - kRadius / 8.f, centerPoint.y + kRadius / 2.f);
    [path addLineToPoint:secondPoint];
    CGPoint thirdPoint = CGPointMake(centerPoint.x + kRadius / 2.f, centerPoint.y - kRadius / 2.f);
    [path addLineToPoint:thirdPoint];
    
    self.checkMarkLayer.path = path.CGPath;
    self.checkMarkLayer.strokeColor = self.likeGreenColor.CGColor;
    self.checkMarkLayer.lineWidth = kLineWidth;
    self.checkMarkLayer.fillColor = nil;
    
    // end status
    self.checkMarkLayer.strokeEnd = 1;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = kStep6SuccessDuration;
    animation.fromValue = @0;
    animation.toValue = @1;
    [self.checkMarkLayer addAnimation:animation forKey:nil];
}

#pragma mark - step6 fail
- (void)doStep6Fail {
    [self prepareForStep6Fail];
    [self processStep6FailA];
    [self processStep6FailB];
    [self processStep6FailC];
}

- (void)prepareForStep6Fail {
    [self.verticalMoveLayer removeFromSuperlayer];
}
// 圆变色
- (void)processStep6FailA {
    self.circleLayer.color = self.likeRedColor;
}

// 叹号上半部分出现
- (void)processStep6FailB {
    self.exclamationMarkTopLayer = [CAShapeLayer layer];
    self.exclamationMarkTopLayer.frame = self.bounds;
    [self.layer addSublayer:self.exclamationMarkTopLayer];

    CGFloat partLength = kRadius * 2 / 8;
    CGFloat pathPartCount = 5;
    CGFloat visualPathPartCount = 4;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat originY = CGRectGetMidY(self.bounds) - kRadius;
    CGFloat destY = originY + partLength * pathPartCount;
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY)];

    self.exclamationMarkTopLayer.path = path.CGPath;
    self.exclamationMarkTopLayer.lineWidth = kLineWidth;
    self.exclamationMarkTopLayer.strokeColor = self.likeRedColor.CGColor;
    self.exclamationMarkTopLayer.fillColor = nil;

    // end status
    CGFloat strokeStart = (pathPartCount - visualPathPartCount ) / pathPartCount;
    CGFloat strokeEnd = 1.0;
    self.exclamationMarkTopLayer.strokeStart = strokeStart;
    self.exclamationMarkTopLayer.strokeEnd = strokeEnd;

    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @0;
    startAnimation.toValue = @(strokeStart);

    CABasicAnimation *endAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnim.fromValue = @0;
    endAnim.toValue = @(strokeEnd);

    CAAnimationGroup *anim = [CAAnimationGroup animation];
    anim.animations = @[startAnimation, endAnim];
    anim.duration = kStep6FailDuration;
    [anim setValue:@"step6Fail" forKey:kName];
    anim.delegate = self;
    [self.exclamationMarkTopLayer addAnimation:anim forKey:nil];
}

// 叹号下半部分出现
- (void)processStep6FailC {
    self.exclamationMarkBottomLayer = [CAShapeLayer layer];
    self.exclamationMarkBottomLayer.frame = self.bounds;
    [self.layer addSublayer:self.exclamationMarkBottomLayer];
    
    CGFloat partLength = kRadius * 2 / 8;
    CGFloat pathPartCount = 2;
    CGFloat visualPathPartCount = 1;
    
    self.exclamationMarkBottomLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat originY = CGRectGetMidY(self.bounds) + kRadius;
    CGFloat destY = originY - partLength * pathPartCount;
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY)];
    self.exclamationMarkBottomLayer.path = path.CGPath;
    self.exclamationMarkBottomLayer.lineWidth = kLineWidth;
    self.exclamationMarkBottomLayer.strokeColor = self.likeRedColor.CGColor;
    self.exclamationMarkBottomLayer.fillColor = nil;
    
    // end status
    CGFloat strokeStart = (pathPartCount - visualPathPartCount) / pathPartCount;
    CGFloat strokeEnd = 1;
    self.exclamationMarkBottomLayer.strokeStart = strokeStart;
    self.exclamationMarkBottomLayer.strokeEnd = strokeEnd;
    
    // anima
    CABasicAnimation *startAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnim.fromValue = @0;
    startAnim.toValue = @(strokeStart);
    CABasicAnimation *endAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnim.fromValue = @0;
    endAnim.toValue = @(strokeEnd);
    
    CAAnimationGroup *anim = [CAAnimationGroup animation];
    anim.animations = @[startAnim, endAnim];
    anim.duration = kStep6FailDuration;
    
    [self.exclamationMarkBottomLayer addAnimation:anim forKey:nil];
}

#pragma mark - step7 fail
- (void)doStep7Fail {
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima.fromValue = @(-M_PI / 12);
    anima.toValue = @(M_PI / 12);
    anima.duration = kStep7FailDuration;
    anima.autoreverses = YES;
    anima.repeatCount = 4;
    [self.layer addAnimation:anima forKey:nil];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:kName] isEqualToString:@"step1"]) {
        [self doStep2];
    } else if ([[anim valueForKey:kName] isEqualToString:@"step2"]) {
        [self doStep3];
    } else if ([[anim valueForKey:kName] isEqualToString:@"step3"]) {
        if (self.isSuccess) {
            [self doStep4];
        } else {
            [self doStep6Fail];
        }
    } else if ([[anim valueForKey:kName] isEqualToString:@"step4"]) {
        [self doStep5];
    } else if ([[anim valueForKey:kName] isEqualToString:@"step5"]) {
        [self doStep6Success];
    } else if ([[anim valueForKey:kName] isEqualToString:@"step6Fail"]) {
        [self doStep7Fail];
    }
}

@end
