//
//  KKIndicatorView.m
//  ReverseVideo
//
//  Created by ShreeJi on 10/17/15.
//  Copyright (c) 2015 Devkrushna Infotech. All rights reserved.
//

#import "KKIndicatorView.h"
#import "CenterView.h"

@interface KKIndicatorView()

- (void)initializeDefaults;

@end


@implementation KKIndicatorView


- (id)init {
    if ((self = [super init])) {
        [self initializeDefaults];
    }
    
    return self;
}

-(void)initializeDefaults
{
    
    self.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height);
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.60];
    

    
    
    backsmall = [[UIView alloc] initWithFrame:CGRectMake(ScreenSize.width/2 - 40, ScreenSize.height/2 - 40, 80, 80)];
    backsmall.layer.cornerRadius = 10.;
    backsmall.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.80];
    [self addSubview:backsmall];
    
    indiView =[[UIActivityIndicatorView alloc]initWithFrame:
               CGRectMake(ScreenSize.width/2-18.5,ScreenSize.height/2 - 18.5, 37, 37)];
    
    indiView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self addSubview:indiView];
    
    [self hideIndicatorview];

}



-(void)showBlankIndicator
{
    self.hidden = false;
}


-(void)showfilterIndicator
{
    self.backgroundColor = [UIColor clearColor];
    [self show];
}


-(void)showdownloadIndicator
{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.60];
    [self show];
}

-(void)showSmallIndicator
{
    self.backgroundColor = [UIColor clearColor];
    backsmall.hidden = false;
    [self show];
}


-(void)show
{
    self.hidden = false;
    indiView.hidden = false;
    [indiView startAnimating];
}


-(void)hideIndicatorview
{
    [indiView stopAnimating];
    self.hidden = true;
    indiView.hidden = true;
    backsmall.hidden = true;
}




@end
