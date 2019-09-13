//
//  ThumbListView.m
//  MasterFrame
//
//  Created by Devkrushna iMac on 30/04/16.
//  Copyright © 2016 Devkrushna. All rights reserved.
//

#define ThumbHeight ((IsIpad) ? 110 : 70)
#define B1Width ((IsIpad) ? 70 : 50)



#import "ThumbListView.h"
#import "ThumbCell.h"
#import "CenterView.h"

@interface ThumbListView()

- (void)initializeDefaults;

@end

@implementation ThumbListView

- (id)init {
    if ((self = [super init])) {
        [self initializeDefaults];
    }
    
    return self;
}

-(void)initializeDefaults
{

    self.frame = CGRectMake(1, ScreenSize.height+ThumbHeight, ScreenSize.width-2, ThumbHeight);
    
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 3.;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 1.;
    if(IsIpad)
        self.layer.borderWidth = 1.5;
    
    UIButton *b1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, B1Width, ThumbHeight)];
    b1.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    b1.contentMode = UIViewContentModeScaleAspectFill;
    [[b1 imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [b1 setImage:[UIImage imageNamed:@"more_new"] forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(Fulllistview) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:b1];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    cview = [[UICollectionView alloc] initWithFrame:CGRectMake(B1Width + 5, 2, ScreenSize.width - 12 - B1Width, ThumbHeight-4) collectionViewLayout:flowLayout];
    
    [cview setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    cview.backgroundColor = [UIColor clearColor];
    [cview setShowsVerticalScrollIndicator:YES];
    
    cview.delegate=self;
    cview.dataSource=self;
    
    [cview registerNib:[UINib nibWithNibName:@"ThumbCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"Cell"];
    
    
    [self addSubview:cview];
    
    self.hidden = true;
    [self HideThumbList];

}

-(void)Fulllistview
{
    [self HideThumbList];
    [self.delegate FullListOpen];
}

-(void)ShowThumbList
{
    self.hidden = false;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:frameNO inSection:0];
    
    [cview reloadData];
    [cview scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        CGRect rect = self.frame;
        rect.origin.y = ScreenSize.height - ThumbHeight - 3;
        self.frame = rect;
    }
    completion:^(BOOL finished) {}];

}

-(void)HideThumbList
{
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self.frame;
        rect.origin.y = ScreenSize.height + ThumbHeight;
        self.frame = rect;
    }
    completion:^(BOOL finished) {self.hidden = true;}];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8.;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((80*(ThumbHeight - 2))/60, ThumbHeight - 4);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return ImageAraay.count;
}

- (ThumbCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ThumbCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.layer.borderColor = [[UIColor clearColor] CGColor];
    cell.layer.borderWidth = 2.;

    cell.img.image = [UIImage imageWithContentsOfFile:[ThumbPath stringByAppendingPathComponent:ImageAraay[indexPath.row]]];
    
    if (frameNO == (int)indexPath.row)
        cell.layer.borderColor = [[UIColor colorWithRed:65.0/255.0 green:106.0/255.0 blue:255.0/255.0 alpha:1] CGColor];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [cview reloadData];
    
    if (frameNO != indexPath.row)
    {
        frameNO = indexPath.row;
        [cview scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        [self.delegate ChangeFrame:(int)indexPath.row];
    }
}





-(UIColor*)selectcolor
{
    return [UIColor colorWithRed:72.0/255.0 green:131.0/255.0 blue:241.0/255.0 alpha:1];
}


@end
