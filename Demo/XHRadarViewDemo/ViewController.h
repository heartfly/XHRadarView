//
//  ViewController.h
//  XHRadarViewDemo
//
//  Created by 邱星豪 on 15/1/22.
//  Copyright (c) 2015年 邱星豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHRadarView.h"

@interface ViewController : UIViewController <XHRadarViewDataSource, XHRadarViewDelegate>

@property (nonatomic, strong) XHRadarView *radarView;

@end

