//
//  Record.h
//  TenKHours
//
//  Created by zation on 5/29/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Record : NSManagedObject

@property (nonatomic, retain) NSDate *date;
@property (nonatomic) NSTimeInterval time;
@property (nonatomic, retain) Task *task;

@end
