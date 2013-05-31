//
//  TaskProgressView.m
//  TenKHours
//
//  Created by reg on 05/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskProgressView.h"
#import <QuartzCore/QuartzCore.h>

static NSInteger kLineWidth = 20;

@interface TaskProgressView () {
    CGFloat _startAngle;
    CGFloat _endAngle;
    float  _total;
}

@end

@implementation TaskProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _percent = 0;
        _total = 0;
        _startAngle = M_PI * 1.5;
        _endAngle = _startAngle + M_PI * 2;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self gatherData];
    }
    return self;
}

- (void)gatherData {
    _percent = 0;
    _total = 0;
    _startAngle = M_PI * 1.5;
    _endAngle = _startAngle + M_PI * 2;
}

- (void)drawRect:(CGRect)rect
{
    _total += 0.1;
    NSString *content = [NSString stringWithFormat:@"%.1f", _total];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];

    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:rect.size.width / 2 - kLineWidth
                      startAngle:_startAngle
                        endAngle:_startAngle + (_endAngle - _startAngle) * (self.percent / 60.0)
                       clockwise:YES];

    bezierPath.lineWidth = kLineWidth;
    bezierPath.lineCapStyle = kCGLineCapRound;
    [self.color setStroke];
    [bezierPath stroke];
    
    CGRect textRect = CGRectMake((rect.size.width / 2.0) - 100/2.0, (rect.size.height / 2.0) - 45/2.0, 100, 45);
    [[UIColor blackColor] setFill];
    [content drawInRect: textRect
                   withFont:[UIFont fontWithName: @"Helvetica-Bold" size:30]
              lineBreakMode: NSLineBreakByWordWrapping
                  alignment: NSTextAlignmentCenter];
}

@end
