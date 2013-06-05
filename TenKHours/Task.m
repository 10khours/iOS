//
//  Task.m
//  TenKHours
//
//  Created by zation on 5/29/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "Task.h"
#import "Record.h"
#import "CommonHelper.h"

@implementation Task

@dynamic name;
@dynamic total;
@dynamic records;
@dynamic order;

- (UIColor *)getColor
{
    NSDictionary *taskColorDict = [[CommonHelper getDefaultTaskColors] objectAtIndex:[self.order integerValue]];
    return [CommonHelper getColorFromTaskColor:taskColorDict];
}

@end
