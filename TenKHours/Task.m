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

- (NSString *)getColorString
{
    NSDictionary *taskColorDict = [[CommonHelper getDefaultTaskColors] objectAtIndex:[self.order integerValue]];
    return [NSString stringWithFormat:@"rgb(%@, %@, %@)", [taskColorDict objectForKey:@"Red"], [taskColorDict objectForKey:@"Green"], [taskColorDict objectForKey:@"Blue"]];
}

-(BOOL)isDate:(NSDate*)date sameDayAsAnotherDate:(NSDate*)anotherDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:anotherDate];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

-(Record *)recordInSameDayOf:(NSDate *)date
{
    for (Record *record in self.records) {
        if ([self isDate:date sameDayAsAnotherDate:record.date]) {
            return record;
        }
    }
    return nil;
}

- (void)addRecordWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSTimeInterval duration = [endDate timeIntervalSinceDate:startDate];
    [self addRecordWithStartDate:startDate duration:duration];
}

- (void)addRecordWithStartDate:(NSDate *)startDate duration:(NSTimeInterval)duration
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    Record *record = [self recordInSameDayOf:startDate];
    if (record != nil) {
        [record setTime:duration + record.time];
    } else {
        record = (Record *)[NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:managedObjectContext];
        [record setTask:self];
        [record setDate:startDate];
        [record setTime:duration];
    }
    [self setTotal:self.total + duration];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
}

@end
