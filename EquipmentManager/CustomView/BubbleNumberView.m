//
//  BubbleNumberView.m
//  Topka2.0
//
//  Created by zhangbo on 13-3-5.
//  Copyright (c) 2013年 Topka. All rights reserved.
//
//  气泡数字面板

#import "BubbleNumberView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BubbleNumberView

-(id) init
{
    self = [super init];
    if (self) {
        _number = 0;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _number = 0;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
//        self.layer.shadowColor = [[UIColor blackColor] CGColor];
//        self.layer.shadowOffset = CGSizeMake(0.0, 3.0);
//        self.layer.shadowOpacity = 0.3;
    }
    return self;
}

-(id) initWithNumber:(int) number
{
    self = [self init];
    if (self) {
        _number = number;
        [self setHidden:(_number == 0)];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (_number < 10) {
        //单数字画圆
        if (self.hasBorder) {
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
            CGContextFillEllipseInRect(context, CGRectMake(0.0, 0.0, 22.0, 22.0));
            
            CGContextSetRGBFillColor(context, 239.0/255.0, 0.0, 4.0/255.0, 1.0);
            CGContextFillEllipseInRect(context, CGRectMake(2.0, 2.0, 18.0, 18.0));
            
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextSelectFont(context, "Helvetica", 14.0, kCGEncodingMacRoman);
            CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
            CGContextSetTextDrawingMode(context, kCGTextFill);
            CGContextShowTextAtPoint(context, 7.0, 15.5, [[NSNumber numberWithInt:_number].stringValue cStringUsingEncoding:NSUTF8StringEncoding], 1);
        }else{
            CGContextSetRGBFillColor(context, 239.0/255.0, 0.0, 4.0/255.0, 1.0);
            CGContextFillEllipseInRect(context, CGRectMake(0.0, 0.0, 18.0, 18.0));
            
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextSelectFont(context, "Helvetica", 14.0, kCGEncodingMacRoman);
            CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
            CGContextSetTextDrawingMode(context, kCGTextFill);
            CGContextShowTextAtPoint(context, 5.0, 13.5, [[NSNumber numberWithInt:_number].stringValue cStringUsingEncoding:NSUTF8StringEncoding], 1);
        }
        
    }else{
        //多位数画圆头直线
        if (self.hasBorder) {
            CGContextSetRGBStrokeColor(context, 1.0, 1.0, 10, 1.0);
            CGContextMoveToPoint(context, 12.0, 12.0);
            if (_number < 100) {
                CGContextAddLineToPoint(context, 22.0, 12.0);
            }else{
                CGContextAddLineToPoint(context, 27.0, 12.0);
            }
            
            CGContextSetLineWidth(context, 22);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextStrokePath(context);
            
            CGContextSetRGBStrokeColor(context, 239.0/255.0, 0.0, 4.0/255.0, 1.0);
            CGContextMoveToPoint(context, 12.0, 12.0);
            if (_number < 100) {
                CGContextAddLineToPoint(context, 22.0, 12.0);
            }else{
                CGContextAddLineToPoint(context, 27.0, 12.0);
            }
            
            CGContextSetLineWidth(context, 18);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextStrokePath(context);
            
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextSelectFont(context, "Helvetica", 14.0, kCGEncodingMacRoman);
            CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
            CGContextSetTextDrawingMode(context, kCGTextFill);
            if (_number < 100) {
                CGContextShowTextAtPoint(context, 9.0, 16.5, [[NSNumber numberWithInt:_number].stringValue cStringUsingEncoding:NSUTF8StringEncoding], 2);
            }else{
                CGContextShowTextAtPoint(context, 8.0, 16.5, [@"99+" cStringUsingEncoding:NSUTF8StringEncoding], 3);
            }
        }else{
            CGContextSetRGBStrokeColor(context, 239.0/255.0, 0.0, 4.0/255.0, 1.0);
            CGContextMoveToPoint(context, 10.0, 10.0);
            if (_number < 100) {
                CGContextAddLineToPoint(context, 20.0, 10.0);
            }else{
                CGContextAddLineToPoint(context, 25.0, 10.0);
            }
            
            CGContextSetLineWidth(context, 18);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextStrokePath(context);
            
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
            CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
            CGContextSelectFont(context, "Helvetica", 14.0, kCGEncodingMacRoman);
            CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
            CGContextSetTextDrawingMode(context, kCGTextFill);
            if (_number < 100) {
                CGContextShowTextAtPoint(context, 7.0, 14.5, [[NSNumber numberWithInt:_number].stringValue cStringUsingEncoding:NSUTF8StringEncoding], 2);
            }else{
                CGContextShowTextAtPoint(context, 6.0, 14.5, [@"99+" cStringUsingEncoding:NSUTF8StringEncoding], 3);
            }
        }
    }
}

-(void) setNumber:(int)number
{
    _number = number;
    [self setNeedsDisplay];
    [self setHidden:(_number == 0)];
}

@end
