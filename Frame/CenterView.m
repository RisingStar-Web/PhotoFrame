//
//  CenterView.m
//  PIPEffect
//
//  Created by ShreeJi on 1/7/16.
//  Copyright © 2016 Devkrushna. All rights reserved.
//





#import "CenterView.h"

@implementation CenterView


int frame_H;
int frame_W;
    
int new_H;
int new_W;

CGFloat KKMaster;

UIImage *galleryimage;

NSInteger frameNO;
NSInteger EffectNO;

int AdCount;
int AdCount2;

NSMutableArray *ImageAraay;

BOOL isNew;


+(CGRect)MasterSizeWith:(UIImage*)img
{
     frame_H = ScreenSize.height;
     frame_W = (img.size.width * frame_H)/img.size.height;
    
   
    int  maxH;
    int  maxW;
    
    if (IsIpad)
    {
        maxW = ScreenSize.width - 60;
        maxH = ScreenSize.height - [self navigationSize] - 120;
    }
    else
    {
        maxW = ScreenSize.width - 30;
        maxH = ScreenSize.height - [self navigationSize]-10;
    }

    
    if (frame_H > frame_W)
        KKMaster = (maxH * 100)/frame_H;
    else
        KKMaster = (maxW * 100)/frame_W;

    
    [self setNewmaster];
    
    if (new_H > maxH)
        KKMaster = (maxH * 100)/frame_H;
    else if (new_W > maxW)
        KKMaster = (maxW * 100)/frame_W;
    
    [self setNewmaster];

    
    int new_Y = (ScreenSize.height - F_ADHeight - new_H)/2;
    int new_X = (ScreenSize.width - new_W)/2;
    
    if (IsIpad)
         new_Y = F_ADHeight + (ScreenSize.height - new_H - [self navigationSize] - F_ADHeight)/2;
    
    return CGRectMake(new_X, new_Y, new_W, new_H);
}

+(void)setNewmaster
{
    if (KKMaster > 100.)
        KKMaster = 100.;
    
    new_H = (KKMaster * frame_H)/100;
    new_W = (KKMaster * frame_W)/100;
}


+(void)resetGalleryView:(UIImageView*)imageView
{
    float scaleFactor = MAX(imageView.image.size.width/imageView.bounds.size.width, imageView.image.size.height/imageView.bounds.size.height);
    
    CGRect ivFrame = imageView.frame;
    ivFrame.size.height = imageView.image.size.height/scaleFactor;
    ivFrame.size.width = imageView.image.size.width/scaleFactor;
    imageView.frame = ivFrame;
}

+(UIImage*)saveImagewith:(UIImage*)result
{
    CGSize newSize = CGSizeMake(1300, 1734);
    
    if (result.size.height > newSize.height || result.size.width > newSize.width)
    {
        if (result.size.height > result.size.width)
        {
            newSize.height = newSize.height;
            newSize.width = (result.size.width * newSize.height)/result.size.height;
        }
        else
        {
            newSize.width = newSize.width;
            newSize.height = (result.size.height * newSize.width)/result.size.width;
        }
        
        UIGraphicsBeginImageContext(newSize);
        [result drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    
    return result;

}

+(float)navigationSize
{
    if (IsIpad)
        return 70;
    
    else if (ScreenSize.width == 320 || ScreenSize.width == 568)
        return 50;
    
    else if (ScreenSize.width == 414 || ScreenSize.width == 736)
        return 60;
    
    return 50;
}







@end
