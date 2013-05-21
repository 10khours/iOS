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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"StartTaskCell" owner:self options:nil];
        self = [nibs objectAtIndex:0];
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

@end
