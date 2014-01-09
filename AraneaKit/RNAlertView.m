//
//  RNAlertView.m
//  VisionBook
//
//  Created by Aleksandar Trpeski on 7/26/13.
//  Copyright (c) 2013 ARANEA. All rights reserved.
//

#import "RNAlertView.h"

@interface RNAlertView()
@property (readwrite, copy) void (^block)(NSInteger selectedItemIndex);
@property (readwrite, copy) void (^inputBlock)(NSString *text);
@property (readwrite, copy) void (^cancelBlock)(void);
@end

@implementation RNAlertView

@synthesize block, cancelBlock;

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle items:(NSArray *)items block:(void (^)(NSInteger selectedItemIndex))block cancelBlock:(void (^)(void))cancelBlock
{
    RNAlertView *alertView = [[RNAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView setDelegate:alertView];
    
    for( NSString *title in items)
        [alertView addButtonWithTitle:title];
    
    if (cancelButtonTitle) {
        [alertView addButtonWithTitle:cancelButtonTitle];
        [alertView setCancelButtonIndex:[items count]];
    }
    
    if (block)
        [alertView setBlock:block];
    if (cancelBlock)
        [alertView setCancelBlock:cancelBlock];
    
    [alertView show];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message textFieldText:(NSString *)textFieldText cancelButtonTitle:(NSString *)cancelButtonTitle submitButtonTitle:(NSString *)submitButtonTitle block:(void (^)(NSString *))block cancelBlock:(void (^)(void))cancelBlock
{
    RNAlertView *alertView = [[RNAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:submitButtonTitle, nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alertView textFieldAtIndex:0] setText:textFieldText];
    [alertView setDelegate:alertView];
    
    if (block)
        [alertView setInputBlock:block];
    if (cancelBlock)
        [alertView setCancelBlock:cancelBlock];
    
    [alertView show];
}


#pragma mark - UIAlertViewDelegate Methods

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (self.cancelBlock)
        [self cancelBlock]();
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.cancelBlock && buttonIndex == alertView.cancelButtonIndex)
        [self cancelBlock]();
    else if (self.block)
        [self block](buttonIndex);
    else if (self.inputBlock)
        [self inputBlock]([alertView textFieldAtIndex:0].text);
}


@end
