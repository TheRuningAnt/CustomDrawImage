//
//  CustomView.m
//  CustomDrawImage
//
//  Created by 赵广亮 on 16/8/6.
//  Copyright © 2016年 zhaoguangliang. All rights reserved.
//

#import "CustomView.h"

CGPoint firstTouch,prevTouch,lastTouch;
CGContextRef buffContex;
UIImage *image;
@implementation CustomView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIGraphicsBeginImageContext(self.frame.size);
        buffContex = UIGraphicsGetCurrentContext();
        self.shape = kPen;
        self.color = [UIColor redColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    firstTouch = [touch locationInView:self];
    if (self.shape == kPen) {
        prevTouch = firstTouch;
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    lastTouch = [touch locationInView:self];
    if (self.shape == kPen) {
        [self draw:buffContex];
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    lastTouch = [touch locationInView:self];
    [self draw:buffContex];
    image = UIGraphicsGetImageFromCurrentImageContext();
    [self setNeedsDisplay];
    
}

#pragma mark 绘制方法

-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [image drawAtPoint:CGPointZero];
    [self draw:ctx];
}

-(void)draw:(CGContextRef)ctx{
    CGContextSetStrokeColorWithColor(ctx, self.color.CGColor);
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextSetLineWidth(ctx, 4.0);
    CGContextSetShouldAntialias(ctx, YES);
    CGFloat pointX,pointY;
    
    switch (self.shape) {
        case kRectangle:
            CGContextFillRect(ctx, CGRectMake(firstTouch.x, firstTouch.y, lastTouch.x - firstTouch.x, lastTouch.y - firstTouch.y));
            break;
        case kLine:
            CGContextMoveToPoint(ctx,firstTouch.x, firstTouch.y);
            CGContextAddLineToPoint(ctx, lastTouch.x, lastTouch.y);
            CGContextStrokePath(ctx);
            break;
        case kRoundRect:
            pointX = firstTouch.x < lastTouch.x? firstTouch.x : lastTouch.x;
            pointY = firstTouch.y < lastTouch.y? firstTouch.y : lastTouch.y;
            CGContextAddRoundRect(ctx,pointX, pointY, fabs(lastTouch.x - firstTouch.x), fabs(lastTouch.y - firstTouch.y),16);
            CGContextFillPath(ctx);
            break;
        case kCircle:
            CGContextFillEllipseInRect(ctx,CGRectMake(firstTouch.x, firstTouch.y, lastTouch.x - firstTouch.x, lastTouch.y - firstTouch.y));
            break;
        case kPen:
            CGContextMoveToPoint(ctx, prevTouch.x, prevTouch.y);
            CGContextAddLineToPoint(ctx, lastTouch.x, lastTouch.y);
            CGContextStrokePath(ctx);
            prevTouch = lastTouch;
            break;
        default:
            break;
    }
    
}

void CGContextAddRoundRect(CGContextRef c, CGFloat x1 , CGFloat y1
                           , CGFloat width , CGFloat height , CGFloat radius)
{
    CGContextMoveToPoint (c, x1 + radius , y1);
    CGContextAddLineToPoint(c , x1 + width - radius, y1);
    CGContextAddArcToPoint(c , x1 + width , y1, x1 + width
                           , y1 + radius, radius);
    CGContextAddLineToPoint(c , x1 + width, y1 + height - radius);
    CGContextAddArcToPoint(c , x1 + width, y1 + height
                           , x1 + width - radius , y1 + height , radius);
    CGContextAddLineToPoint(c , x1 + radius, y1 + height);
    CGContextAddArcToPoint(c , x1, y1 + height , x1
                           , y1 + height - radius , radius);
    CGContextAddLineToPoint(c , x1 , y1 + radius);
    CGContextAddArcToPoint(c , x1 , y1 , x1 + radius , y1 , radius);
}



@end
