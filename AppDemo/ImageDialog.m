//
//  ImageDialog.m
//  AppDemo
//
//  Created by Penchala, Sandeep Kumar on 6/15/15.
//  Copyright (c) 2015 Penchala, Sandeep Kumar. All rights reserved.
//

#import "ImageDialog.h"

@interface ImageDialog()
@property (nonatomic) UIView *backGroundOverlay;
@property (strong, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation ImageDialog

- (void)showImageDialogView {
    
    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    self.backGroundOverlay = [[UIView alloc] initWithFrame: window.frame];
    self.backGroundOverlay.layer.backgroundColor = [[UIColor blackColor] CGColor];
    self.backGroundOverlay.layer.opacity = 0.6f;
    self.backGroundOverlay.isAccessibilityElement = YES;
    UITapGestureRecognizer *tapOnOverLay =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.backGroundOverlay addGestureRecognizer:tapOnOverLay];
    [self setFrame:CGRectMake((window.frame.size.width - 220)/2, window.frame.origin.y + 120, 220.0f, 220.0f)];
    [window addSubview:self.backGroundOverlay];
    [window addSubview:self];
    
}



//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    if ([recognizer view] == self.backGroundOverlay) {
        [self.backGroundOverlay removeFromSuperview];
        [self removeFromSuperview];
    }
}

- (IBAction)closeWindow:(id)sender {
    [self.backGroundOverlay removeFromSuperview];
    [self removeFromSuperview];
}



@end
