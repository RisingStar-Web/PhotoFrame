//
//  KKShareView.m
//  PIP Effect
//
//  Created by ShreeJi on 10/21/15.
//  Copyright (c) 2015 Devkrushna. All rights reserved.
//

#import "KKShareView.h"


@implementation KKShareView

+(UIViewController*)shareWithitem:(NSArray*)items inview:(UIView*)view
{
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        return activity;
        
    else
    {
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activity];
        
        [popup presentPopoverFromRect:CGRectMake(view.frame.size.width/2 - 100,view.frame.size.height/2 - 100,200, 200) inView:view permittedArrowDirections:0 animated:YES];
        
    }
    
    return nil;
}


@end
