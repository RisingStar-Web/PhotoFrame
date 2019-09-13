//
//  KKIndicatorView.h
//  ReverseVideo
//
//  Created by ShreeJi on 10/17/15.
//  Copyright (c) 2015 Devkrushna Infotech. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>



@interface KKIndicatorView : UIView

{
    UIView *backsmall;
    UIActivityIndicatorView *indiView;
}


-(id)init;
-(void)hideIndicatorview;
-(void)showfilterIndicator;
-(void)showdownloadIndicator;
-(void)showSmallIndicator;
-(void)showBlankIndicator;

@end
