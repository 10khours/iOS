//
//  AddTaskCell.m
//  TenKHours
//
//  Created by zation on 5/19/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "AddTaskCell.h"
#import "CommonHelper.h"

@implementation AddTaskCell

@synthesize addTaskCircle;
@synthesize addTaskMark;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"AddTaskCell" owner:self options:nil];
        self = [nibs objectAtIndex:0];
    }
    return self;
}

- (void)setTaskCount:(NSInteger)taskCount
{
    UIColor *taskColor = [CommonHelper getColorFromTaskColor:[[CommonHelper getDefaultTaskColors] objectAtIndex:taskCount]];
    self.addTaskCircle.borderColor = taskColor;
    [self.addTaskMark setTextColor:taskColor];
    [self.addTaskCircle setNeedsDisplay];
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
