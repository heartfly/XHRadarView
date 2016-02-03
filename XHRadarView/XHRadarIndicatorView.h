//
//  XHRadarIndicatorView.h
//  XHRadarView
//
//  Created by 邱星豪 on 14/10/27.
//  Copyright (c) 2014年 邱星豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHRadarIndicatorView : UIView

@property (nonatomic, assign) CGFloat radius;           //半径
@property (nonatomic, strong) UIColor *startColor;      //渐变开始颜色
@property (nonatomic, strong) UIColor *endColor;        //渐变结束颜色
@property (nonatomic, assign) CGFloat angle;            //渐变角度
@property (nonatomic, assign) BOOL clockwise;           //是否顺时针

@end
