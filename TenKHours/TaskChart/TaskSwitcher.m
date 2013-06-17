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
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"TaskSwitcher" owner:self options:nil];
        self = [nibs objectAtIndex:0];
        self.backgroundColor = [UIColor clearColor];
        self.buttonSwitcher.layer.cornerRadius = 5;
        self.buttonSwitcher.layer.borderWidth = 2;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSwitch:) name:@"switch" object:nil];
    }
    return self;
}

- (void)setTask:(Task *)task
{
    UIColor *taskColor = [task getColor];
    self.buttonSwitcher.layer.borderColor = taskColor.CGColor;
    self.buttonSwitcher.backgroundColor = taskColor;
    
    labelTotalTime.text = [task getReadableTime];
    labelUnit.text = [task getReadableUnit];
    _task = task;
}

- (void)activate
{
    self.buttonSwitcher.backgroundColor = [UIColor clearColor];
}

- (void)onSwitch:(NSNotification *)notification
{
    Task *task = [notification.userInfo objectForKey:@"task"];
    if (task.order == _task.order) {
        [self activate];
    } else {
        self.buttonSwitcher.backgroundColor = [_task getColor];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)touchToActivate:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"switch" object:nil userInfo:[NSDictionary dictionaryWithObject:_task forKey:@"task"]];
}
@end
