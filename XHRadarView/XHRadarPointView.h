//
//  XHRadarPointView.h
//  XHRadarView
//
//  Created by 邱星豪 on 14/10/27.
//  Copyright (c) 2014年 邱星豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHRadarPointViewDelegate;

@interface XHRadarPointView : UIView

@property (nonatomic, assign) id <XHRadarPointViewDelegate> delegate;        //委托

@end

@protocol XHRadarPointViewDelegate <NSObject>

@optional

- (void)didSelectItemRadarPointView:(XHRadarPointView *)radarPointView; //点击事件

@end
