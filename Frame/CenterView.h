//
//  CenterView.h
//  PIPEffect
//
//  Created by ShreeJi on 1/7/16.
//  Copyright © 2016 Devkrushna. All rights reserved.
//


#define IsIpad  UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define ScreenSize [UIScreen mainScreen].bounds.size
#define FramesPath [[NSBundle mainBundle] pathForResource:@"frame" ofType:@"bundle"]
#define ThumbPath [[NSBundle mainBundle] pathForResource:@"thumb" ofType:@"bundle"]

#define F_ADHeight ((IsIpad) ? 90 : 50)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CenterView : NSObject

extern NSMutableArray *ImageAraay;

extern UIImage *galleryimage;

extern NSInteger frameNO;
extern NSInteger EffectNO;

extern BOOL isNew;

extern int AdCount;
extern int AdCount2;

+(CGRect)MasterSizeWith:(UIImage*)img;
+(UIImage*)saveImagewith:(UIImage*)result;
+(void)resetGalleryView:(UIImageView*)imageView;

+(float)navigationSize;


@end
