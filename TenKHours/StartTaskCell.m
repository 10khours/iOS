//
//  StartTaskCell.m
//  TenKHours
//
//  Created by zation on 5/21/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "StartTaskCell.h"

@implementation StartTaskCell

@synthesize buttonStartTask;
@synthesize labelTaskName;

NSArray *taskColors;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"StartTaskCell" owner:self options:nil];
        self = [nibs objectAtIndex:0];
        NSString *systemConfigPath = [[NSBundle mainBundle] pathForResource:@"SystemConfig" ofType:@"plist"];
        NSDictionary *systemConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:systemConfigPath];
        taskColors = [systemConfig objectForKey:@"TaskColors"];
    }
    return self;
}

- (void)setTaskName:(NSString *)taskName order:(NSInteger)order
{
    NSDictionary *taskColorDict = [taskColors objectAtIndex:order];
    float red = [[taskColorDict objectForKey:@"Red"] floatValue];
    float green = [[taskColorDict objectForKey:@"Green"] floatValue];
    float blue = [[taskColorDict objectForKey:@"Blue"] floatValue];
    
    UIColor *taskColor = [UIColor colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:1.0];
    self.labelTaskName.text = taskName;
    [self.labelTaskName setTextColor:taskColor];
    self.buttonStartTask.fillColor = taskColor;
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
