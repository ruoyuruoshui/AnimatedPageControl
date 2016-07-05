//
//  LEGooeyLayer.h
//  AnimatedPageControl
//
//  Created by 陈记权 on 7/5/16.
//  Copyright © 2016 LeEco. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

static const CGFloat kOutsideRectSize = 100.0f;

typedef NS_ENUM(NSUInteger, LEMovingPoint) {
    LEMovingPointB,
    LEMovingPointD
};

@interface LEGooeyLayer : CALayer

@property (nonatomic, assign) CGFloat progress;

@end
