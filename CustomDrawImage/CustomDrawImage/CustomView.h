//
//  CustomView.h
//  CustomDrawImage
//
//  Created by 赵广亮 on 16/8/6.
//  Copyright © 2016年 zhaoguangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kPen = 0,
    kLine = 1,
    kCircle = 2,
    kRoundRect = 3,
    kRectangle = 4
}ShapeType;
@interface CustomView : UIView

@property (assign,nonatomic) ShapeType shape;
@property (strong,nonatomic) UIColor *color;

@end
