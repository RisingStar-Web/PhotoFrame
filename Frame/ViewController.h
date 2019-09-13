//
//  ViewController.h
//  Sticker
//
//  Created by ShreeJi on 9/10/15.
//  Copyright (c) 2015 Devkrushna. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,retain) IBOutlet UILabel *lbl1;
@property (nonatomic,retain) IBOutlet UILabel *lbl2;

@property (nonatomic,retain) IBOutlet UIButton *btn1;
@property (nonatomic,retain) IBOutlet UIButton *btn2;





@end

