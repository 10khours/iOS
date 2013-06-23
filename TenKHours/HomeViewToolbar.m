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
#import <QuartzCore/QuartzCore.h>

@implementation HomeViewToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"HomeViewToolbar" owner:self options:nil];
        self = [nibs objectAtIndex:0];
        
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 10;
        self.layer.shadowOpacity = 0.8;
    }
    return self;
}


- (IBAction)share:(id)sender {
}
@end
