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
@synthesize task;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UINib *nib = [UINib nibWithNibName:@"TaskSwitcher" bundle:nil];        
        self = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
        self.backgroundColor = [UIColor clearColor];
        self.viewInfo.layer.borderWidth = 2;
        self.viewInfo.layer.cornerRadius = 5;
        self.viewFlip.layer.cornerRadius = 5;
        self.frame = frame;
        
        self.isActive = NO;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(respondToTapGesture:)];
        tapRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)setupTask:(Task *)_task
{
    UIColor *taskColor = [_task getColor];
    self.viewFlip.backgroundColor = taskColor;
    self.viewInfo.layer.borderColor = taskColor.CGColor;
    NSDictionary *readableTimeAndUnit = [_task getReadableTimeAndUnitTotal];
    labelTotalTime.text = [readableTimeAndUnit objectForKey:@"time"];
    labelUnit.text = [readableTimeAndUnit objectForKey:@"unit"];
    self.task = _task;
}

- (void)respondToTapGesture:(UITapGestureRecognizer *)recognizer
{
    [self.delegate handleSwitch:self.task];
}

- (void)activate
{
    if (self.isActive) {
        return;
    }
    [UIView transitionFromView:self.viewFlip toView:self.viewInfo duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews completion:nil];
    self.isActive = YES;
}

- (void)inActivate
{
    if (!self.isActive) {
        return;
    }
    [UIView transitionFromView:self.viewInfo toView:self.viewFlip duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews completion:nil];
    self.isActive = NO;
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
