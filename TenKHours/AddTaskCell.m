//
//  AddTaskCell.m
//  TenKHours
//
//  Created by zation on 5/19/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "AddTaskCell.h"

@implementation AddTaskCell

@synthesize textFieldNewTaskName;
@synthesize buttonAddTask;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"AddTaskCell" owner:self options:nil];
        self = [nibs objectAtIndex:0];
        textFieldNewTaskName.hidden = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)addTask:(id)sender {
    NSLog(@"touch");
}
@end
