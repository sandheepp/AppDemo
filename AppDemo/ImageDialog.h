//
//  ImageDialog.h
//  AppDemo
//
//  Created by Penchala, Sandeep Kumar on 6/15/15.
//  Copyright (c) 2015 Penchala, Sandeep Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageDialog : UIView
@property (strong, nonatomic) IBOutlet UIImageView *appImage;
@property (strong, nonatomic) IBOutlet UILabel *imageName;
- (void)showImageDialogView ;
@end
