//
//  MagazineView.m
//  PIP Effect
//
//  Created by ShreeJi on 11/2/15.
//  Copyright (c) 2015 Devkrushna. All rights reserved.
//

#define Filter_Height ((IsIpad) ? 100 : 70)


#import "MagazineView.h"
#import "ImageOrientation.h"
#import "CenterView.h"
#import "imagepicker.h"
#import "KKfilter.h"
#import "ThumbListView.h"
#import "KKIndicatorView.h"
#import "MyphotosView.h"


@interface MagazineView () <UIGestureRecognizerDelegate,KKFDelegate,KKListDelegate>

@end

@implementation MagazineView

{
    KKfilter *filter;
    KKIndicatorView *indiView;
    ThumbListView *thumList;
    CGFloat CellWidth,Cellheight;

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isNew = true;

    
    ImageAraay = [NSMutableArray arrayWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:FramesPath error:nil]];
    
    
    CGRect rectnavi = _navi_view.frame;
    rectnavi.size.height = [CenterView navigationSize];
    rectnavi.origin.y = ScreenSize.height - [CenterView navigationSize];
    _navi_view.frame = rectnavi;
    
    _Gallery_img.layer.borderWidth = 2;

    [self setGeture];
    
    
    filter = [[KKfilter alloc] init];
    [self.view addSubview:filter];
    filter.delegate = self;
    
    thumList = [[ThumbListView alloc] init];
    [self.view addSubview:thumList];
    thumList.delegate = self;
    
    indiView = [[KKIndicatorView alloc] init];
    [self.view addSubview:indiView];
    
  
    
    _Activview.layer.masksToBounds = NO;
    _Activview.layer.shadowColor = [UIColor whiteColor].CGColor;
    _Activview.layer.shadowOffset = CGSizeMake(1., 1.);
    _Activview.layer.shadowOpacity = .4;
    
    
    
    int MasterSpace = (ScreenSize.width * 10)/320;
    
    if (IsIpad)
        CellWidth  = (ScreenSize.width - (MasterSpace *5))/4;
    else
        CellWidth  = (ScreenSize.width - (MasterSpace *4))/3;
    
    Cellheight = (60 * CellWidth)/80;
    
    // listview
    CGRect Rectlist = _fulllist.frame;
    Rectlist.origin.x = MasterSpace;
    Rectlist.size.width = ScreenSize.width - (MasterSpace*2);
    Rectlist.size.height = ScreenSize.height - 30;
    Rectlist.origin.y = 0;
    
    _fulllist.frame = Rectlist;
    
    _fullBack.frame = CGRectMake(0, ScreenSize.height, ScreenSize.width, ScreenSize.height);
    
    
    UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideFulllist)];
    tapClose.delegate = self;
    [_backClose addGestureRecognizer:tapClose];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskLandscapeRight;
}

- (BOOL)shouldAutorotate {
    return false;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    
    if (isNew)
        [self resetFrame];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self interstitialRecive:2];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self HighLightoff];
}


-(void)resetFrame
{
    
    isNew = false;
    EffectNO = 0;
    
    _Gallery_img.image = galleryimage;
    
    _Frame_img.image = [UIImage imageWithContentsOfFile:[FramesPath stringByAppendingPathComponent:ImageAraay[frameNO]]];
    
    _Activview.frame = [CenterView MasterSizeWith:_Frame_img.image];
    
    _Gallery_img.transform = CGAffineTransformIdentity;
    _Gallery_img.frame = _Frame_img.bounds;

    [CenterView resetGalleryView:_Gallery_img];
    
    _Gallery_img.center = _Frame_img.center;
    
    
    [self HighLighton];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(HighLightoff) object:nil];
    [self performSelector:@selector(HighLightoff) withObject:nil afterDelay:.8];


}

-(void)HighLighton
{
    _Frame_img.alpha = 0.6;
    _Gallery_img.layer.borderColor = [[UIColor colorWithRed:65.0/255.0 green:106.0/255.0 blue:255.0/255.0 alpha:1] CGColor];
    
}


-(void)HighLightoff
{
    _Frame_img.alpha = 1;
    _Gallery_img.layer.borderColor = [[UIColor clearColor] CGColor];
}


#pragma mark - Gesture

-(void)setGeture
{
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [pinchGestureRecognizer setDelegate:self];
    [_Gallery_img addGestureRecognizer:pinchGestureRecognizer];
    
    
    UIRotationGestureRecognizer *rotatGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    [rotatGestureRecognizer setDelegate:self];
    [_Gallery_img addGestureRecognizer:rotatGestureRecognizer];
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGestureRecognizer setDelegate:self];
    [_Gallery_img addGestureRecognizer:panGestureRecognizer];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    [self HighLighton];
    
    CGPoint translation = [recognizer translationInView:recognizer.view];
    [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
    
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
        [self HighLightoff];

}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
        [self HighLighton];
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
        [self HighLightoff];
        
}

- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
        [self HighLighton];
    
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
        [self HighLightoff];
        
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideMasterview];
}


#pragma mark - Gallery


-(IBAction)galleryOpen:(id)sender
{
    [self hideMasterview];
    
    imagepicker *ipc = [[imagepicker alloc]init];
    ipc.delegate = self;
    ipc.editing = false;
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:ipc animated:true completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:true completion:nil];

    galleryimage = [CenterView saveImagewith:[ImageOrientation fixrotation:[info objectForKey:UIImagePickerControllerOriginalImage]]];
    
    _Gallery_img.image = galleryimage;
    
    [self HighLighton];
    [self performSelector:@selector(HighLightoff) withObject:nil afterDelay:.8];


    [self resetFrame];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - Fulllist

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ImageAraay.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(CellWidth, Cellheight);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                                           forIndexPath:indexPath];
    
    UIImageView *img = (UIImageView*)[cell viewWithTag:1];
    img.image = [UIImage imageWithContentsOfFile:[ThumbPath stringByAppendingPathComponent:ImageAraay[indexPath.row]]];
    
    
    cell.layer.borderColor = [[UIColor clearColor] CGColor];
    cell.layer.borderWidth = 2.;
    
    if (frameNO == (int)indexPath.row)
        cell.layer.borderColor = [[UIColor colorWithRed:65.0/255.0 green:106.0/255.0 blue:255.0/255.0 alpha:1] CGColor];
    
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    isNew = true;
    frameNO = indexPath.row;
    [self resetFrame];
    [self hideFulllist];
    [self interstitialRecive2];
}



#pragma mark - Navi Action



-(IBAction)newPIP:(id)sender
{
    [filter hideFilter];

        if (thumList.hidden)
            [thumList ShowThumbList];
        else
            [thumList HideThumbList];
    
}

-(void)ChangeFrame:(int)sender
{
    [self resetFrame];
    [self interstitialRecive2];
}




-(void)FullListOpen
{
    [thumList HideThumbList];
    
    _fullBack.hidden = false;
    [_fulllist reloadData];
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self->_fullBack.frame;
        rect.origin.y = 0;
        self->_fullBack.frame = rect;
    }
                     completion:^(BOOL finished) {}];
}

-(void)hideFulllist
{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self->_fullBack.frame;
        rect.origin.y = ScreenSize.height;
        self->_fullBack.frame = rect;
    }
                     completion:^(BOOL finished)
     {self->_fullBack.hidden = true;}];
    
    
}



#pragma mark -

- (IBAction)savephoto:(id)sender
{
    [self hideMasterview];
    [self HighLightoff];
    
    UIImage *save_img = [self buildImage];
    UIImageWriteToSavedPhotosAlbum(save_img, self, nil, nil);
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Photo Saved to Camera Roll" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    MyphotosView *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"MyphotosView"];
    [self presentViewController:vc animated:true completion:^{vc.image_view.image = save_img;}];
    
}

-(UIImage*)buildImage
{
    
    UIGraphicsBeginImageContextWithOptions(self.Activview.bounds.size, self.Activview.opaque, 0.0);
    [self.Activview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}



#pragma mark -



-(IBAction)clickEffect:(id)sender
{
    [thumList HideThumbList];
    
    if (filter.hidden)
    {
        CGRect Rect = _Activview.frame;
        Rect.origin.y += Rect.size.height - Filter_Height-15;
        
        if (IsIpad)
        {
            Rect.origin.x = 50;
            Rect.size.width= ScreenSize.width - 100;
        }
        else
        {
            Rect.origin.x = 30;
            Rect.size.width= ScreenSize.width - 60;
        }
        
        Rect.size.height = Filter_Height;
        
        [filter Filterwith:Rect];


    }
    else
        [filter hideFilter];

}



-(void)kkFilterApply:(NSInteger)sender
{
    [indiView showSmallIndicator];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *fimg = [self->filter filteredImage:galleryimage withFilterName:sender];
   
        dispatch_async( dispatch_get_main_queue(), ^{
            
            self->_Gallery_img.image = fimg;
            
            [self->indiView hideIndicatorview];

        });
    });
}


#pragma mark -

-(void)hideMasterview
{
    [filter hideFilter];
    [thumList HideThumbList];
}


-(IBAction)backClick:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}



-(void)interstitialRecive:(int)count
{
    AdCount++;
    if (AdCount > count)
    {
        AdCount = 0;
        AdCount2 = 0;
    }
}

-(void)interstitialRecive2
{
    AdCount2++;
    if (AdCount2 > 13)
    {
        AdCount = 0;
        AdCount2 = 0;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
