//
//  MyphotosView.m
//  PIP Effect
//
//  Created by ShreeJi on 9/30/15.
//  Copyright (c) 2015 Devkrushna. All rights reserved.
//

#import "MyphotosView.h"
#import "CenterView.h"

@interface MyphotosView ()

@end

@implementation MyphotosView


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect Rect = _Topnavi.frame;
    Rect.size.height = [CenterView navigationSize] - 10;
    _Topnavi.frame = Rect;
    
    _image_view.frame = CGRectMake(30, [CenterView navigationSize], ScreenSize.width-60, ScreenSize.height - [CenterView navigationSize] - F_ADHeight - 10);

}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskLandscapeRight;
}

- (BOOL)shouldAutorotate {
    return false;
}


-(IBAction)backClick:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}



- (IBAction)share:(id)sender
{
    UIViewController *shreview = [KKShareView shareWithitem:@[_image_view.image] inview:self.view];
    if (shreview != nil)
        [self presentViewController:shreview animated:true completion:nil];
    
}



@end
