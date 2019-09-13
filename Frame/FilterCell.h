//
//  FilterCell.h
//  InstaPicaso
//
//  Created by ShreeJi on 2/4/16.
//  Copyright © 2016 Devkrushna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCell : UICollectionViewCell

@property (nonatomic,retain) IBOutlet UIImageView *img;
@property (nonatomic,retain) IBOutlet UIImageView *selectedImg;
@property (nonatomic,retain) IBOutlet UILabel *title;
@property (nonatomic,retain) IBOutlet UIView *boder;


@end
