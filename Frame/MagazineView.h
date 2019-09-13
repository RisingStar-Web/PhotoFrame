//
//  MagazineView.h
//  PIP Effect
//
//  Created by ShreeJi on 11/2/15.
//  Copyright (c) 2015 Devkrushna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineView : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,retain) IBOutlet UIView *Activview;
@property (nonatomic,retain) IBOutlet UIImageView *Frame_img;
@property (nonatomic,retain) IBOutlet UIImageView *Gallery_img;
@property(nonatomic, strong) IBOutlet UIView *navi_view;

@property (nonatomic,retain) IBOutlet UIView *fullBack;
@property (nonatomic,retain) IBOutlet UIImageView *backClose;
@property (nonatomic,retain) IBOutlet UICollectionView *fulllist;

@end
