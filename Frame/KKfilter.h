//
//  KKfilter.h
//  InstaPicaso
//
//  Created by ShreeJi on 2/1/16.
//  Copyright © 2016 Devkrushna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KKFDelegate

-(void)kkFilterApply:(NSInteger)sender;

@end

@interface KKfilter : UIView <UICollectionViewDelegate , UICollectionViewDataSource>
{
    UICollectionView *cview;
    NSMutableArray *filterType,*filterTitle;
}

extern BOOL isFilter;

@property (nonatomic, retain) id <KKFDelegate> delegate;


-(id)init;
-(void)Filterwith:(CGRect)rect;
- (UIImage*)filteredImage:(UIImage*)image withFilterName:(NSInteger)sender;
-(void)hideFilter;

@end
