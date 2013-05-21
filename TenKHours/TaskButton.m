//
//  TaskButton.m
//  TenKHours
//
//  Created by zation on 5/20/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskButton.h"

@implementation TaskButton

@synthesize borderColor;

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
    NSInteger lineWidth = 5;
    float radius = hypot(bounds.size.width, bounds.size.height) / 3.0;
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [borderPath setLineWidth:lineWidth];
    CGFloat dashPattern[2] = {15, 15};
    [borderPath setLineDash:dashPattern count:1 phase:0.0];
    [self.borderColor setStroke];
    [borderPath stroke];
}

@end
