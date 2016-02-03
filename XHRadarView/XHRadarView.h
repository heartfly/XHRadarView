//
//  XHRadarView.h
//  XHRadarView
//
//  Created by 邱星豪 on 14/10/24.
//  Copyright (c) 2014年 邱星豪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHRadarPointView.h"

@class XHRadarIndicatorView;

@protocol XHRadarViewDataSource;
@protocol XHRadarViewDelegate;

@interface XHRadarView : UIView <XHRadarPointViewDelegate> {
    
}

@property (nonatomic, assign) CGFloat radius;           //半径
@property (nonatomic, strong) UIColor *indicatorStartColor;      //渐变开始颜色
@property (nonatomic, strong) UIColor *indicatorEndColor;        //渐变结束颜色
@property (nonatomic, assign) CGFloat indicatorAngle;            //指针渐变角度
@property (nonatomic, assign) BOOL indicatorClockwise;           //是否顺时针
@property (nonatomic, strong) UIImage *backgroundImage; //背景图片
@property (nonatomic, strong) UILabel *textLabel;      //提示标签
@property (nonatomic, strong) NSString *labelText;      //提示文字
@property (nonatomic, strong) UIView *pointsView;       //目标点视图
@property (nonatomic, strong) XHRadarIndicatorView *indicatorView;      //指针

@property (nonatomic, assign) id <XHRadarViewDataSource> dataSource;    //数据源
@property (nonatomic, assign) id <XHRadarViewDelegate> delegate;        //委托

-(void)scan;    //扫描
-(void)stop;    //停止
-(void)show;    //显示目标
-(void)hide;    //隐藏目标

@end


@protocol XHRadarViewDataSource <NSObject>              //数据源

@optional

- (NSInteger)numberOfSectionsInRadarView:(XHRadarView *)radarView;
- (NSInteger)numberOfPointsInRadarView:(XHRadarView *)radarView;
- (UIView *)radarView:(XHRadarView *)radarView viewForIndex:(NSUInteger)index;       //自定义目标点视图
- (CGPoint)radarView:(XHRadarView *)radarView positionForIndex:(NSUInteger)index;    //目标点所在位置

@end

@protocol XHRadarViewDelegate <NSObject>

@optional

- (void)radarView:(XHRadarView *)radarView didSelectItemAtIndex:(NSUInteger)index; //点击事件

@end
