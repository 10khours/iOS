//
//  HomeViewToolbar.m
//  TenKHours
//
//  Created by zation on 6/22/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "HomeViewToolbar.h"
#import "TaskChartViewController.h"
#import "AppDelegate.h"

@implementation HomeViewToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"HomeViewToolbar" owner:self options:nil];
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

- (IBAction)share:(id)sender {
}
@end
