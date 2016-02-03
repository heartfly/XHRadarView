//
//  XHRadarView.m
//  XHRadarView
//
//  Created by 邱星豪 on 14/10/24.
//  Copyright (c) 2014年 邱星豪. All rights reserved.
//

#import "XHRadarView.h"

#import "XHRadarIndicatorView.h"

#import <QuartzCore/QuartzCore.h>
#define RADAR_DEFAULT_SECTIONS_NUM 3
#define RADAR_DEFAULT_RADIUS 100.f
#define RADAR_ROTATE_SPEED 60.0f
#define INDICATOR_START_COLOR [UIColor colorWithRed:20.0/255.0 green:120.0/255.0 blue:40.0/255.0 alpha:1]
#define INDICATOR_END_COLOR [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0]
#define INDICATOR_ANGLE 240.0
#define INDICATOR_CLOCKWISE YES
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@implementation XHRadarView

#pragma mark - life cycle

- (id)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    if (!self.indicatorView) {
        XHRadarIndicatorView *indicatorView = [[XHRadarIndicatorView alloc] initWithFrame:self.bounds];
        [self addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    
    if (!self.textLabel) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y + self.radius, self.bounds.size.width, 30)];
        [self addSubview:textLabel];
        _textLabel = textLabel;
    }
    
    if (!self.pointsView) {
        UIView *pointsView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:pointsView];
        _pointsView = pointsView;
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    // Drawing code
    
    //An opaque type that represents a Quartz 2D drawing environment.
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*背景图片*/
    if (self.backgroundImage) {
        UIImage *image = self.backgroundImage;
        [image drawInRect:self.bounds];//在坐标中画出图片
    }
    
    NSUInteger sectionsNum = RADAR_DEFAULT_SECTIONS_NUM;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInRadarView:)]) {
        sectionsNum = [self.dataSource numberOfSectionsInRadarView:self];
    }
    
    CGFloat radius = RADAR_DEFAULT_RADIUS;
    if (self.radius) {
        radius = self.radius;
    }
    
    CGFloat indicatorAngle = INDICATOR_ANGLE;
    if (self.indicatorAngle) {
        indicatorAngle = self.indicatorAngle;
    }
    
    BOOL indicatorClockwise = INDICATOR_CLOCKWISE;
    if (self.indicatorClockwise) {
        indicatorClockwise = self.indicatorClockwise;
    }
    
    UIColor *indicatorStartColor = INDICATOR_START_COLOR;
    if (self.indicatorStartColor) {
        indicatorStartColor = self.indicatorStartColor;
    }
    
    UIColor *indicatorEndColor = INDICATOR_END_COLOR;
    if (self.indicatorEndColor) {
        indicatorEndColor = self.indicatorEndColor;
    }
    
    CGFloat sectionRadius = radius/sectionsNum;
    for (int i=0; i<sectionsNum ; i++) {
        /*画圆*/
        //边框圆
        CGContextSetRGBStrokeColor(context, 1, 1, 1, (1-(float)i/(sectionsNum + 1))*0.5);//画笔线的颜色(透明度渐变)
        CGContextSetLineWidth(context, 1.0);//线的宽度
        //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
        // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
        CGContextAddArc(context, self.center.x, self.center.y, sectionRadius - 5*(sectionsNum - i - 1), 0, 2*M_PI, 0); //添加一个圆
        CGContextDrawPath(context, kCGPathStroke); //绘制路径
        
        sectionRadius += radius/sectionsNum;
    }
    
    if (self.indicatorView) {
        self.indicatorView.frame = self.bounds;
        self.indicatorView.backgroundColor = [UIColor clearColor];
        self.indicatorView.radius = self.radius;
        self.indicatorView.angle = indicatorAngle;
        self.indicatorView.clockwise = indicatorClockwise;
        self.indicatorView.startColor = indicatorStartColor;
        self.indicatorView.endColor = indicatorEndColor;
    }
    
    if (self.textLabel) {
        self.textLabel.frame = CGRectMake(0, self.center.y + ([UIScreen mainScreen].bounds.size.height)/3.3, rect.size.width, 30);
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:13];
        if (self.labelText) {
            self.textLabel.text = self.labelText;
        }
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self bringSubviewToFront:self.textLabel];
    }
    
}

- (void)setLabelText:(NSString *)labelText {
    _labelText = labelText;
    if (self.textLabel) {
        self.textLabel.text = labelText;
    }
}

#pragma mark - Actions
- (void)scan {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    BOOL indicatorClockwise = INDICATOR_CLOCKWISE;
    if (self.indicatorClockwise) {
        indicatorClockwise = self.indicatorClockwise;
    }
    rotationAnimation.toValue = [NSNumber numberWithFloat: (indicatorClockwise?1:-1) * M_PI * 2.0 ];
    rotationAnimation.duration = 360.f/RADAR_ROTATE_SPEED;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INT_MAX;
    [_indicatorView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stop {
    [_indicatorView.layer removeAnimationForKey:@"rotationAnimation"];
}

- (void)show {
    for (UIView *subview in self.pointsView.subviews) {
        [subview removeFromSuperview];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfPointsInRadarView:)]) {
        NSUInteger pointsNum = [self.dataSource numberOfPointsInRadarView:self];
        for (int index=0; index<pointsNum; index++) {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(radarView:viewForIndex:)]) {
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(radarView:positionForIndex:)]) {
                    CGPoint point = [self.dataSource radarView:self positionForIndex:index];
                    int posDirection = point.x;     //方向(角度)
                    int posDistance = point.y;    //距离(半径)
                    
                    XHRadarPointView *pointView = [[XHRadarPointView alloc] initWithFrame:CGRectZero];
                    UIView *customView = [self.dataSource radarView:self viewForIndex:index];
                    [pointView addSubview:customView];
                    
                    pointView.tag = index;
                    
                    pointView.frame = customView.frame;
                    pointView.center = CGPointMake(self.center.x + posDistance*sin(DEGREES_TO_RADIANS(posDirection)), self.center.y + posDistance*cos(DEGREES_TO_RADIANS(posDirection)));
                    NSLog(@"sin:%f, cos:%f, self center:%@, point center:%@",sin(DEGREES_TO_RADIANS(posDirection)), cos(DEGREES_TO_RADIANS(posDirection)), NSStringFromCGPoint(self.center), NSStringFromCGPoint(pointView.center));
                    pointView.delegate = self;
                    
                    //动画
                    pointView.alpha = 0.0;
                    CGAffineTransform fromTransform =
                    CGAffineTransformScale(pointView.transform, 0.1, 0.1);
                    [pointView setTransform:fromTransform];
                    
                    CGAffineTransform toTransform = CGAffineTransformConcat(pointView.transform,  CGAffineTransformInvert(pointView.transform));
                    
                    double delayInSeconds = 0.05*index;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [UIView beginAnimations:nil context:NULL];
                        [UIView setAnimationDuration:0.3];
                        pointView.alpha = 1.0;
                        [pointView setTransform:toTransform];
                        [UIView commitAnimations];
                    });
                    
                    [self.pointsView addSubview:pointView];
                }
            }
        }
    }
    
}

- (void)hide {
    
}

#pragma mark - XHRadarPointViewDelegate
- (void)didSelectItemRadarPointView:(XHRadarPointView *)radarPointView {
    NSLog(@"select point %d", radarPointView.tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(radarView:didSelectItemAtIndex:)]) {
        [self.delegate radarView:self didSelectItemAtIndex:radarPointView.tag];
    }
}


@end
