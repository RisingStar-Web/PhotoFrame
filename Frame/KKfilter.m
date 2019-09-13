//
//  KKfilter.m
//  InstaPicaso
//
//  Created by ShreeJi on 2/1/16.
//  Copyright © 2016 Devkrushna. All rights reserved.
//


#define FHeight ((IsIpad) ? 100 : 70)

#import "KKfilter.h"
#import "FilterCell.h"
#import "CenterView.h"

@interface KKfilter()

- (void)initializeDefaults;

@end

@implementation KKfilter


BOOL isFilter;

- (id)init {
    if ((self = [super init])) {
        [self initializeDefaults];
    }
    
    return self;
}

-(void)initializeDefaults
{
    self.frame = CGRectMake(0, 0, 200, FHeight);
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.8];
    self.layer.cornerRadius = 3.;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 1.;
    if(IsIpad)
    self.layer.borderWidth = 1.5;
    

    
    filterType = [NSMutableArray arrayWithObjects:
                  @"CLDefaultEmptyFilter",
                  @"CIPhotoEffectFade",
                  @"CIPhotoEffectProcess",
                  @"CISRGBToneCurveToLinear",
                  @"CILinearToSRGBToneCurve",
                  @"CIVignette",
                  @"CIFalseColor",
                  @"CIColorMonochrome",
                  @"CISepiaTone",
                  @"CIPhotoEffectFade",
                  @"CIPhotoEffectProcess",
                  @"CIColorPosterize",
                  @"CISRGBToneCurveToLinear",
                  @"CIPhotoEffectTonal",
                  @"CIMaximumComponent",
                  @"CIMinimumComponent",
                  @"CIPhotoEffectMono",
                  @"CIPhotoEffectNoir",
                  @"CIColorInvert",nil];
    
    
    filterTitle = [NSMutableArray arrayWithObjects:
                   @"None",
                   @"Gorgeous",
                   @"Beauty",
                   @"Transfer",
                   @"Process",
                   @"Lomo",
                   @"Old Time",
                   @"Mocha",
                   @"Sepia",
                   @"Fade",
                   @"Greenlight",
                   @"Poster",
                   @"Linear",
                   @"BW Tonal",
                   @"BW Normal",
                   @"BW High",
                   @"BW Mono",
                   @"BW Noir",
                   @"Invert",nil];
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
 
    cview = [[UICollectionView alloc] initWithFrame:CGRectMake(6, 0, 200 - 12, FHeight) collectionViewLayout:flowLayout];
    
    [cview setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    cview.backgroundColor = [UIColor clearColor];
    [cview setShowsVerticalScrollIndicator:YES];

    cview.delegate=self;
    cview.dataSource=self;

    [cview registerNib:[UINib nibWithNibName:@"FilterCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"Cell"];
    
    
    [self addSubview:cview];
    
    [self hideFilter];
    
}



-(void)Filterwith:(CGRect)rect
{
    isFilter = true;
    self.hidden = false;
    self.frame  = rect;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:EffectNO inSection:0];
    
    [cview reloadData];
    [cview scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    
}


-(void)hideFilter
{
    isFilter = false;
    self.hidden = true;
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(FHeight - 10, FHeight - 10);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return filterType.count;
}

- (FilterCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FilterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.selectedImg.hidden = true;
    cell.selectedImg.layer.cornerRadius = 3.;
    cell.img.layer.cornerRadius = 3.;
    
    cell.title.text = filterTitle[indexPath.row];
    
    if (IsIpad)
        cell.title.font = [cell.title.font fontWithSize:15];

    cell.img.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",filterTitle[indexPath.row]]];
    
    if (EffectNO == (int)indexPath.row)
        cell.selectedImg.hidden = false ;
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [cview reloadData];
    
    if (EffectNO != indexPath.row)
    {
        EffectNO = indexPath.row;
        [cview scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self.delegate kkFilterApply:indexPath.row];
    }
    

}



- (UIImage*)filteredImage:(UIImage*)image withFilterName:(NSInteger)sender
{
    NSString *filterName = filterType[sender];
    
    if([filterName isEqualToString:@"CLDefaultEmptyFilter"])
        return image;
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);

    
    return result;
}





-(UIColor*)selectcolor
{
    return [UIColor colorWithRed:72.0/255.0 green:131.0/255.0 blue:241.0/255.0 alpha:1];
}




@end
