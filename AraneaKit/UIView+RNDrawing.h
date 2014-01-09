//
//  UIView+RNDrawing.h
//  Connect
//
//  Created by Aleksandar Trpeski on 12/23/13.
//  Copyright (c) 2013 Aranea Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RNDrawing)

- (void)drawLine:(NSArray *)points withKey:(NSString *)key color:(UIColor *)color width:(CGFloat)width;
- (void)removeLineWithKey:(NSString *)key;

@end
