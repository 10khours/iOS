//
//  StartTaskCell.m
//  TenKHours
//
//  Created by zation on 5/21/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "StartTaskCell.h"
#import "CommonHelper.h"

@implementation StartTaskCell

@synthesize startTaskCircle;
@synthesize labelTaskName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"StartTaskCell" owner:self options:nil];
        self = [nibs objectAtIndex:0];
    }
    return self;
}

- (void)setTask:(Task *)task
{
    UIColor *taskColor = [task getColor];
    self.labelTaskName.text = task.name;
    [self.labelTaskName setTextColor:taskColor];
    self.startTaskCircle.fillColor = taskColor;
    [self.startTaskCircle setNeedsDisplay];
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
