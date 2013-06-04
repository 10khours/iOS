//
//  CommonHelper.h
//  TenKHours
//
//  Created by reg on 5/31/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface CommonHelper : NSObject

+ (NSArray *)getDefaultTaskColors;
+ (UIColor *)getColorFromTaskColor:(NSDictionary *)taskColor;

@end
