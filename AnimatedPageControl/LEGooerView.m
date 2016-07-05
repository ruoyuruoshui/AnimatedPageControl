//
//  LEGooerView.m
//  AnimatedPageControl
//
//  Created by 陈记权 on 7/5/16.
//  Copyright © 2016 LeEco. All rights reserved.
//

#import "LEGooerView.h"

@implementation LEGooerView

- (void)awakeFromNib
{
    self.circleGooerLayer = [LEGooeyLayer layer];
    [self.layer addSublayer:self.circleGooerLayer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.circleGooerLayer = [LEGooeyLayer layer];
        self.circleGooerLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.layer addSublayer:self.circleGooerLayer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.circleGooerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
