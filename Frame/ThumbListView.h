//
//  ThumbListView.h
//  MasterFrame
//
//  Created by Devkrushna iMac on 30/04/16.
//  Copyright © 2016 Devkrushna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol KKListDelegate

-(void)ChangeFrame:(int)sender;
-(void)FullListOpen;

@end

@interface ThumbListView : UIView  <UICollectionViewDelegate,UICollectionViewDataSource>

{
    UICollectionView *cview;
}



@property (nonatomic, retain) id <KKListDelegate> delegate;


-(id)init;

-(void)ShowThumbList;

-(void)HideThumbList;

@end
