//
//  StartTaskCircle.m
//  TenKHours
//
//  Created by zation on 6/3/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "StartTaskCircle.h"

@implementation StartTaskCircle

@synthesize fillColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGRect bounds = [self bounds];
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    NSInteger lineWidth = 10;
    float radius = bounds.size.width / 2.0 - lineWidth;
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [borderPath setLineWidth:lineWidth];
    [[UIColor whiteColor] setStroke];
    [self.fillColor setFill];
    [borderPath fill];
    
    [borderPath stroke];
}

@end
