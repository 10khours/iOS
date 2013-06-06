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
#import "AppDelegate.h"

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

- (void)addRecordWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSTimeInterval duration = [endDate timeIntervalSinceDate:startDate];
    [self addRecordWithStartDate:startDate duration:duration];
}

- (void)addRecordWithStartDate:(NSDate *)startDate duration:(NSTimeInterval)duration
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    Record *record = (Record *)[NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:managedObjectContext];
    [record setTask:self];
    [record setDate:startDate];
    [record setTime:duration];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
}

@end
