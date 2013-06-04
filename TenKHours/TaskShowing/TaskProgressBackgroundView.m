//
//  TaskProgressBackgroundView.m
//  TenKHours
//
//  Created by zation on 6/4/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskProgressBackgroundView.h"

@implementation TaskProgressBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"123123123");
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = [self bounds];
    NSLog(@"123123123");
    
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    NSInteger lineWidth = 10;
    float radius = bounds.size.width / 2.0 - lineWidth * 2;
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [borderPath setLineWidth:lineWidth];
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] setStroke];
//    [[UIColor whiteColor] setStroke];
    [borderPath stroke];
}

@end
