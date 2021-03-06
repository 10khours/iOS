//
//  TaskProgressView.m
//  TenKHours
//
//  Created by reg on 05/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskProgressView.h"
#import "math.h"
#import <QuartzCore/QuartzCore.h>

static NSInteger lineWidth = 10;

@implementation TaskProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self gatherData];
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
    self.total = 0;
    _startAngle = M_PI * 1.5;
    _endAngle = _startAngle + M_PI * 2;
}

- (void)drawRect:(CGRect)rect
{
    int displaySecounds = (int)roundf(self.total) % 60;
    int displayMinutes = 0;
    if (self.total > 59) {
        displayMinutes = roundf(self.total / 60);
    }
    
    NSString *content = [NSString stringWithFormat:@"%02d : %02d", displayMinutes, displaySecounds];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    float radius = rect.size.width / 2 - lineWidth * 2;

    [bezierPath addArcWithCenter:center
                          radius:radius
                      startAngle:_startAngle
                        endAngle:_startAngle + (_endAngle - _startAngle) * (self.seconds / 60.0)
                       clockwise:YES];

    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineWidth = lineWidth;
    [self.color setStroke];
    [bezierPath stroke];
    
    CGRect textRect = CGRectMake((rect.size.width / 2.0) - 200/2.0, (rect.size.height / 2.0) - 36, 200, 54);
    [[UIColor whiteColor] setFill];
    [content drawInRect: textRect
                   withFont:[UIFont fontWithName: @"HelveticaNeue-CondensedBold" size:54]
              lineBreakMode: NSLineBreakByWordWrapping
                  alignment: NSTextAlignmentCenter];
}

@end
