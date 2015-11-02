//
//  BubbleNumberView.h
//  Topka2.0
//
//  Created by zhangbo on 13-3-5.
//  Copyright (c) 2013年 Topka. All rights reserved.
//
//  气泡数字面板

#import <UIKit/UIKit.h>

@interface BubbleNumberView : UIView

@property(nonatomic, assign) int number;   //要画的数字
@property(nonatomic, assign) BOOL hasBorder;  //是否有边框

-(id) initWithNumber:(int) number;   //初始化

@end
