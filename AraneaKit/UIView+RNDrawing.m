//
//  UIView+RNDrawing.m
//  Connect
//
//  Created by Aleksandar Trpeski on 12/23/13.
//  Copyright (c) 2013 Aranea Apps. All rights reserved.
//

#import "UIView+RNDrawing.h"
#import <QuartzCore/QuartzCore.h>

static NSString * const kRNLayerKey = @"kRNLayerKey";

@implementation UIView (RNDrawing)

- (void)drawLine:(NSArray *)points withKey:(NSString *)key color:(UIColor *)color width:(CGFloat)width
{
    //draw the line
    CGMutablePathRef linePath = CGPathCreateMutable();
    CAShapeLayer *lineShapeLayer = [CAShapeLayer layer];
    [lineShapeLayer setValue:key forKey:kRNLayerKey];
    
    lineShapeLayer.lineWidth = width;
    lineShapeLayer.lineCap = kCALineCapRound;
    lineShapeLayer.strokeColor = color.CGColor;
    lineShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    if ([points firstObject]) {
        CGPoint point = [(NSValue *)[points firstObject] CGPointValue];
        CGPathMoveToPoint(linePath, NULL, point.x, point.y);
    }
    
    for (int i = 1; i < [points count]; i++) {
        CGPoint point = [(NSValue *)[points objectAtIndex:i] CGPointValue];
        CGPathAddLineToPoint(linePath, NULL, point.x, point.y);
    }
    
    lineShapeLayer.path = linePath;
    CGPathRelease(linePath);
    [self.layer addSublayer:lineShapeLayer];
    
    if (key) {
        [lineShapeLayer setValue:key forKey:kRNLayerKey];
    }
}

- (void)removeLineWithKey:(NSString *)key
{
    for (CALayer *currentLayer in self.layer.sublayers) {
        if ([currentLayer valueForKey:kRNLayerKey] && [[currentLayer valueForKey:kRNLayerKey] isEqualToString:key]) {
            [currentLayer removeFromSuperlayer];
        }
    }
}

@end
