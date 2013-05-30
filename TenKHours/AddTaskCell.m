//
//  AddTaskCell.m
//  TenKHours
//
//  Created by zation on 5/19/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "AddTaskCell.h"

@implementation AddTaskCell

@synthesize addTaskCircle;
@synthesize addTaskMark;

NSArray *taskColors;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"AddTaskCell" owner:self options:nil];
        self = [nibs objectAtIndex:0];
        NSString *systemConfigPath = [[NSBundle mainBundle] pathForResource:@"SystemConfig" ofType:@"plist"];
        NSDictionary *systemConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:systemConfigPath];
        taskColors = [systemConfig objectForKey:@"TaskColors"];
    }
    return self;
}

- (void)setTaskCount:(NSInteger)taskCount
{
    NSDictionary *taskColorDict = [taskColors objectAtIndex:taskCount];
    float red = [[taskColorDict objectForKey:@"Red"] floatValue];
    float green = [[taskColorDict objectForKey:@"Green"] floatValue];
    float blue = [[taskColorDict objectForKey:@"Blue"] floatValue];
    UIColor *taskColor = [UIColor colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:1.0];
    
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
