//
//  ViewController.m
//  Sticker
//
//  Created by ShreeJi on 9/10/15.
//  Copyright (c) 2015 Devkrushna. All rights reserved.
//



#import "ViewController.h"
#import "MagazineView.h"
#import "KKShareView.h"
#import "CenterView.h"
#import "ImageOrientation.h"
#import "imagepicker.h"


@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    frameNO = 0;
    AdCount = 3;

    
    if (IsIpad) {
        
        _lbl1.font = [_lbl1.font fontWithSize:23];
        _lbl2.font = [_lbl2.font fontWithSize:23];
        
        CGRect Rect1 = _lbl1.frame;
        CGRect Rect2 = _lbl2.frame;
        
        Rect1.origin.y += 60;
        Rect2.origin.y += 60;
        Rect1.origin.x -= 60;
        Rect2.origin.x += 60;
        
        
        _lbl1.frame = Rect1;
        _lbl2.frame = Rect2;
        
        
        Rect1 = _btn1.frame;
        Rect2 = _btn2.frame;
        
        
        Rect1.origin.x -= 60;
        Rect2.origin.x += 60;
        
        _btn1.frame = Rect1;
        _btn2.frame = Rect2;
    
        
    }

}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskLandscapeRight;
}

- (BOOL)shouldAutorotate {
    return false;
}




-(IBAction)galleryOpen:(id)sender
{
    
    imagepicker *ipc = [[imagepicker alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    ipc.editing = false;
    
    if ([sender tag] == 1)
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:ipc animated:true completion:nil];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    galleryimage = [CenterView saveImagewith:[ImageOrientation fixrotation:[info objectForKey:UIImagePickerControllerOriginalImage]]];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        [self dismissViewControllerAnimated:false completion:^
         {
             MagazineView *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MagazineView"];
             [self presentViewController:vc animated:true completion:nil];
         }];
       
    }
    else
    {
    
    MagazineView *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MagazineView"];
    [picker presentViewController:vc animated:true completion:nil];
        
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:true completion:nil];
}




@end
