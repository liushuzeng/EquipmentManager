//
//  TabbarView.h
//  Topka2.1
//
//  Created by ZhangBo on 14-5-21.
//  Modified by wangdongdong on 14-6-9.
//
//  Copyright (c) 2014年 Topka. All rights reserved.
//
//  自定义tabbar面板

#import <UIKit/UIKit.h>

typedef enum {
    TAB_BUYCAR,     // 买车
    TAB_DISCUSSION, // 讨论
    TAB_MY,         // 我
} TAB_ITEM;

@interface TabbarButton : UIView

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightedImage;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, assign) BOOL selected;

@end

@protocol TabbarViewDelegate <NSObject>

-(void) tabbarClicked:(int) index;

@end

@interface TabbarView : UIView
{
    TabbarButton *_buyCarBtn;
    TabbarButton *_discussionBtn;
    TabbarButton *_myBtn;
}

@property(nonatomic, assign) id<TabbarViewDelegate> delegate;

// 设置某个tab被选中
-(void) setSelectIndex:(int) index;

// 设置某个tab上的红点是否可见
-(void) setRedPointVisible:(int)index isVisible:(BOOL) isVisible;

-(void)switchToTabbarButton:(NSString *)indexStr;

-(void) setTabBarNumber:(int) number index:(int) index;
-(int) getTabBarNumber:(int) index;

@end
