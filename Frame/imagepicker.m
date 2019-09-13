//
//  imagepicker.m
//  MyBook
//
//  Created by ShreeJi on 1/13/16.
//  Copyright © 2016 Devkrushna. All rights reserved.
//

#import "imagepicker.h"

@interface imagepicker ()

@end

@implementation imagepicker

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskLandscapeRight;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return false;
}



@end
