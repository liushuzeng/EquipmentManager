//
//  TabbarView.m
//  Topka2.1
//
//  Created by ZhangBo on 14-5-21.
//  Modified by wangdongdong on 14-6-9.
//
//  Copyright (c) 2014年 Topka. All rights reserved.
//

#import "TabbarView.h"
#import "Constants.h"
#import "BubbleNumberView.h"

static const int kNumTag = 4444;

@interface TabbarButton ()
{
    UIImageView *_imageViewIcon;
    UILabel *_lblTitle;
}

@end

@implementation TabbarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];

        _imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 30.0) / 2, 2.0, 30.0, 30.0)];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, _imageViewIcon.frame.origin.y + _imageViewIcon.frame.size.height, frame.size.width, 13.0)];
        _lblTitle.textColor = BRAND_GRAY_COLOR;
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.font = [UIFont systemFontOfSize:12.0];
        _lblTitle.backgroundColor = [UIColor clearColor];

        [self addSubview:_imageViewIcon];
        [self addSubview:_lblTitle];
    }
    
    return self;
}

- (void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;
    
    _imageViewIcon.image = _normalImage;
}

- (void)setHighlightedImage:(UIImage *)highlightedImage
{
    _highlightedImage = highlightedImage;
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    
    _lblTitle.text = _titleText;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if(_selected) {
        _imageViewIcon.image = _highlightedImage;
        _lblTitle.textColor = BRAND_ORANGE_COLOR;
    } else {
        _imageViewIcon.image = _normalImage;
        _lblTitle.textColor = BRAND_GRAY_COLOR;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.selected = YES;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.selected = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.selected = YES;
    
    [(TabbarView *)self.superview performSelector:@selector(switchToTabbarButton:) withObject:[NSString stringWithFormat:@"%i", (int)self.tag]];
}

@end

@implementation TabbarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = COLOR(0xf5, 0xf5, 0xf5, 1.0);
        [self initButton];
        
        [self addSubview:_buyCarBtn];
        [self addSubview:_discussionBtn];
        [self addSubview:_myBtn];
    }
    return self;
}

-(void) initButton
{
    float width = self.frame.size.width / 3;
    float height = self.frame.size.height;
    
    _buyCarBtn = [[TabbarButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _buyCarBtn.tag = TAB_BUYCAR;
    _buyCarBtn.normalImage = [UIImage imageNamed:@"buycar_icon_n"];
    _buyCarBtn.highlightedImage = [UIImage imageNamed:@"buycar_icon_p"];
    _buyCarBtn.titleText = @"买车";
    [self addBubbleNumberToView:_buyCarBtn];
    
    _discussionBtn = [[TabbarButton alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    _discussionBtn.tag = TAB_DISCUSSION;
    _discussionBtn.normalImage = [UIImage imageNamed:@"discuss_icon_n"];
    _discussionBtn.highlightedImage = [UIImage imageNamed:@"discuss_icon_p"];
    _discussionBtn.titleText = @"讨论";
    [self addBubbleNumberToView:_discussionBtn];
    
    _myBtn = [[TabbarButton alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
    _myBtn.tag = TAB_MY;
    _myBtn.normalImage = [UIImage imageNamed:@"carport_icon_n"];
    _myBtn.highlightedImage = [UIImage imageNamed:@"carport_icon_p"];
    _myBtn.titleText = @"我";
    [self addBubbleNumberToView:_myBtn];
//    [self addRedPointToView:_myBtn];//设置红点
}

-(void) addRedPointToView:(UIView*) superView
{
    UIImageView *view = [[UIImageView alloc] init];
    view.backgroundColor = COLOR(205.0, 35.0, 45.0, 1.0);
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4.0;
    view.frame = CGRectMake(superView.frame.size.width / 2 + 6, 6.0, 8.0, 8.0);
    view.tag = 10086;
    view.hidden = YES;
    
    [superView addSubview:view];
}

-(void) addBubbleNumberToView:(UIView*) superView
{
    BubbleNumberView *numberView = [[BubbleNumberView alloc] initWithNumber:0];
    numberView.frame = CGRectMake(superView.frame.size.width / 2 + 5.0, 3.0, 35, 24);
    numberView.tag = kNumTag;
    
    [superView addSubview:numberView];
}

- (void)setSelectIndex:(int)index
{
    _buyCarBtn.selected = NO;
    _discussionBtn.selected = NO;
    _myBtn.selected = NO;
    
    switch(index) {
        case 0:
            _buyCarBtn.selected = YES;
            break;
        case 1:
            _discussionBtn.selected = YES;
            break;
        case 2:
            _myBtn.selected = YES;
            break;
            
        default:
            break;
    }
}

-(void) setRedPointVisible:(int)index isVisible:(BOOL) isVisible
{
    TabbarButton *curBtn = nil;
    switch (index) {
        case 0:
            curBtn = _buyCarBtn;
            break;
        case 1:
            curBtn = _discussionBtn;
            break;
        case 2:
            curBtn = _myBtn;
            break;
            
        default:
            break;
    }
    
    UIView *redPointView = [curBtn viewWithTag:10086];
    redPointView.hidden = !isVisible;
}

- (void)switchToTabbarButton:(NSString *)indexStr
{
    int index = indexStr.intValue;
    
    [self setSelectIndex:index];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabbarClicked:)]) {
        [self.delegate tabbarClicked:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

// 设置tabbar上的气泡数字
-(void) setTabBarNumber:(int) number index:(int) index
{
    UIButton *button = (UIButton*)[self viewWithTag:index];
    BubbleNumberView *numberView = (BubbleNumberView *) [button viewWithTag:kNumTag];
    numberView.number = number;
}

// 得到tabbar上的气泡数字
-(int) getTabBarNumber:(int) index
{
    UIButton *button = (UIButton*)[self viewWithTag:index];
    BubbleNumberView *numberView = (BubbleNumberView *) [button viewWithTag:kNumTag];
    return numberView.number;
}

@end
