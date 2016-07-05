//
//  LEGooeyLayer.m
//  AnimatedPageControl
//
//  Created by 陈记权 on 7/5/16.
//  Copyright © 2016 LeEco. All rights reserved.
//

#import "LEGooeyLayer.h"
#import <UIKit/UIKit.h>

@interface LEGooeyLayer ()

@property (nonatomic, assign) CGRect outsideRect;

@property (nonatomic, assign) LEMovingPoint movingPoint;

@end

@implementation LEGooeyLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.progress = 0.5f;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

- (instancetype)initWithLayer:(LEGooeyLayer *)layer
{
    self = [super initWithLayer:layer];
    
    if (self) {
        self.progress = layer.progress;
        self.outsideRect = layer.outsideRect;
        self.movingPoint = layer.movingPoint;
    }
    
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGFloat offset = CGRectGetWidth(self.outsideRect) / 3.6f;
    
    CGFloat movedDistance = CGRectGetWidth(self.outsideRect) * 1 / 6.0f * fabs(self.progress - 0.5f) * 2;
    
    CGPoint rectCenter = CGPointMake(CGRectGetMidX(self.outsideRect), CGRectGetMidY(self.outsideRect));
    
    CGPoint pointA = CGPointMake(rectCenter.x, CGRectGetMinY(self.outsideRect) + movedDistance);
    
    CGPoint pointB = CGPointMake(_movingPoint == LEMovingPointD ?
                                 rectCenter.x  + CGRectGetWidth(_outsideRect) / 2.0f : rectCenter.x + CGRectGetWidth(_outsideRect) / 2.0f + movedDistance * 2 ,
                                 rectCenter.y);
    
    CGPoint pointC = CGPointMake(rectCenter.x, CGRectGetMaxY(_outsideRect) - movedDistance);
    
    CGPoint pointD = CGPointMake(_movingPoint == LEMovingPointB ?
                                 rectCenter.x - CGRectGetWidth(_outsideRect) / 2.0f : rectCenter.x - CGRectGetWidth(_outsideRect) / 2.0f - movedDistance * 2,
                                 rectCenter.y);
    
    
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, _movingPoint == LEMovingPointB ? pointB.y - offset + movedDistance : pointB.y - offset);
    
    CGPoint c3 = CGPointMake(pointB.x, _movingPoint == LEMovingPointB ? pointB.y + offset - movedDistance : pointB.y + offset);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, _movingPoint == LEMovingPointD ? pointD.y + offset - movedDistance : pointD.y + offset);
    
    CGPoint c7 = CGPointMake(pointD.x, _movingPoint == LEMovingPointD ? pointD.y - offset + movedDistance : pointD.y - offset);
    CGPoint c8  = CGPointMake(pointA.x - offset, pointA.y);
    
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
    
    [ovalPath moveToPoint:pointA];
    [ovalPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [ovalPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [ovalPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [ovalPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    
    [ovalPath closePath];
    
    
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:_outsideRect];
    
    CGContextAddPath(ctx, rectPath.CGPath);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    CGContextSetLineWidth(ctx, 1.0f);
    
    CGFloat dash[] = {5,5};
    
    CGContextSetLineDash(ctx, 0.0f, dash, 2);
    
    CGContextStrokePath(ctx);
    
    CGContextAddPath(ctx, ovalPath.CGPath);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextSetLineDash(ctx, 0, NULL, 0);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    NSArray *points = @[[NSValue valueWithCGPoint:pointA], [NSValue valueWithCGPoint:pointB],
                        [NSValue valueWithCGPoint:pointC], [NSValue valueWithCGPoint:pointD],
                        [NSValue valueWithCGPoint:c1], [NSValue valueWithCGPoint:c2],
                        [NSValue valueWithCGPoint:c3], [NSValue valueWithCGPoint:c4],
                        [NSValue valueWithCGPoint:c5], [NSValue valueWithCGPoint:c6],
                        [NSValue valueWithCGPoint:c7], [NSValue valueWithCGPoint:c8]];
    
    [self drawPoints:points withContext:ctx];
    
    UIBezierPath *helperLine = [UIBezierPath bezierPath];
    [helperLine moveToPoint:pointA];
    [helperLine addLineToPoint:c1];
    [helperLine addLineToPoint:c2];
    [helperLine addLineToPoint:pointB];
    [helperLine addLineToPoint:c3];
    [helperLine addLineToPoint:c4];
    [helperLine addLineToPoint:pointC];
    [helperLine addLineToPoint:c5];
    [helperLine addLineToPoint:c6];
    [helperLine addLineToPoint:pointD];
    [helperLine addLineToPoint:c7];
    [helperLine addLineToPoint:c8];
    [helperLine closePath];
    
    CGContextAddPath(ctx, helperLine.CGPath);
    CGFloat dash2[] = {2.0f, 2.0f};
    CGContextSetLineDash(ctx, 0.0f, dash2, 2);
    CGContextStrokePath(ctx);
}

- (void)drawPoints:(NSArray *)points withContext:(CGContextRef)ctx
{
    for (NSValue *vPoint in points) {
        CGPoint point = [vPoint CGPointValue];
        
        CGContextFillRect(ctx, CGRectMake(point.x - 2, point.y - 2, 4, 4));
    }
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (progress <= 0.5) {
        self.movingPoint = LEMovingPointB;
    } else {
        self.movingPoint = LEMovingPointD;
    }
    
    CGFloat originX = self.position.x - kOutsideRectSize / 2.0f +
                        (progress - 0.5) * (CGRectGetWidth(self.frame) - kOutsideRectSize);
    CGFloat originY = self.position.y - kOutsideRectSize / 2.0f;
    
    self.outsideRect = CGRectMake(originX, originY, kOutsideRectSize, kOutsideRectSize);
    
    [self setNeedsDisplay];
}


- (void)layoutSublayers
{
    [super layoutSublayers];
    self.progress = 0.5;
}

@end
