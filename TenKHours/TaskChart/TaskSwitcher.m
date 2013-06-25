//
//  TaskSwitcher.m
//  TenKHours
//
//  Created by zation on 6/17/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskSwitcher.h"
#import <QuartzCore/QuartzCore.h>

@implementation TaskSwitcher

@synthesize labelTotalTime;
@synthesize labelUnit;
@synthesize buttonSwitcher;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UINib *nib = [UINib nibWithNibName:@"TaskSwitcher" bundle:nil];        
        self = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
        self.backgroundColor = [UIColor clearColor];
        self.buttonSwitcher.layer.cornerRadius = 5;
        self.buttonSwitcher.layer.borderWidth = 2;
        self.frame = frame;
    }
    return self;
}

- (void)setTask:(Task *)task
{
    UIColor *taskColor = [task getColor];
    self.buttonSwitcher.layer.borderColor = taskColor.CGColor;    
    NSDictionary *readableTimeAndUnit = [task getReadableTimeAndUnit];
    labelTotalTime.text = [readableTimeAndUnit objectForKey:@"time"];
    labelUnit.text = [readableTimeAndUnit objectForKey:@"unit"];
    _task = task;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
