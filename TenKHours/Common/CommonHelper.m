//
//  CommonHelper.m
//  TenKHours
//
//  Created by reg on 5/31/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "CommonHelper.h"

@implementation CommonHelper

+ (NSArray *)getDefaultTaskColors {
    NSString *systemConfigPath = [[NSBundle mainBundle] pathForResource:@"SystemConfig" ofType:@"plist"];
    NSDictionary *systemConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:systemConfigPath];
    return [systemConfig objectForKey:@"TaskColors"];
}

+ (UIColor *)getColorFromTaskColor:(NSDictionary *)taskColor {
    float red = [[taskColor objectForKey:@"Red"] floatValue];
    float green = [[taskColor objectForKey:@"Green"] floatValue];
    float blue = [[taskColor objectForKey:@"Blue"] floatValue];
    return [UIColor colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:1.0];
}

@end
