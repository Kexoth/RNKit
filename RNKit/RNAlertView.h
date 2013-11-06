//
//  RNAlertView.h
//  VisionBook
//
//  Created by Aleksandar Trpeski on 7/26/13.
//  Copyright (c) 2013 ARANEA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNAlertView : UIAlertView <UIAlertViewDelegate>

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle items:(NSArray *)items block:(void (^)(NSInteger selectedItemIndex))block cancelBlock:(void (^)(void))cancelBlock;

@end
