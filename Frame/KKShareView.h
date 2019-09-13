//
//  KKShareView.h
//  PIP Effect
//
//  Created by ShreeJi on 10/21/15.
//  Copyright (c) 2015 Devkrushna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol KKShareDelegate <NSObject>

-(void)kkSharePresent:(UIViewController*)shreView;

@end

@interface KKShareView : NSObject

@property (nonatomic, retain) id <KKShareDelegate> delegate;


+(UIViewController*)shareWithitem:(NSArray*)items inview:(UIView*)view;

@end
