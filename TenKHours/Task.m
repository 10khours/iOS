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
#define minutesMax 6000
#define hoursMax 360000

@implementation Task

@dynamic name;
@dynamic total;
@dynamic records;
@dynamic order;

//- (void)setupDurations:(NSArray *)durations
//{
//    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
//    
//    NSDate *now = [NSDate date];
//    for (NSNumber *duration in durations) {
//        [self addRecordWithStartDate:now duration:[duration integerValue]];
//        now = [self addDays:1 toDate:now];
//    }
//    
//    NSError *error = nil;
//    if (![managedObjectContext save:&error]) {
//        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
//    }
//}
//
//- (NSDate *)addDays:(int)days toDate:(NSDate *)date
//{   
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setDay:days];
//    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    
//    return [calendar dateByAddingComponents:components toDate:date options:0];
//}

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

- (NSDictionary *)getReadableTimeAndUnitTotal
{
    double readableTime = self.total;
    NSString *readableUnit = @"sec";
    
    if (readableTime > minutesMax && readableTime <= hoursMax) {
        readableTime = readableTime / 60;
        readableUnit = @"min";
    }
    else if (readableTime > hoursMax) {
        readableTime = readableTime / 3600;
        readableUnit = @"hour";
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", (int)round(readableTime)], @"time", readableUnit, @"unit", nil];
}

- (NSDictionary *)getReadableTimeAndUnitToday
{
    double readableTime = 0;
    NSString *readableUnit = @"秒";
    
    Record *record = [self recordInSameDayOf:[NSDate date]];
    
    if (record != nil) {
        if (readableTime > minutesMax && readableTime <= hoursMax) {
            readableTime = readableTime / 60;
            readableUnit = @"分钟";
        }
        else if (readableTime > hoursMax) {
            readableTime = readableTime / 3600;
            readableUnit = @"小时";
        }
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", (int)round(readableTime)], @"time", readableUnit, @"unit", nil];
}

- (NSDictionary *)getReadableRecords
{
    NSMutableArray *dates = [NSMutableArray array];
    NSMutableArray *times = [NSMutableArray array];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *records = [self.records sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    
    for (Record *record in records) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        [formatter setTimeZone:[NSTimeZone localTimeZone]];
        NSString *date = [NSString stringWithFormat:@"%@", [formatter stringFromDate:record.date]];
        [dates addObject:date];
        
    }
    
    double currentTotalTime = 0;
    double total = self.total;
    if (total > minutesMax && total <= hoursMax) {
        for (Record *record in records) {
            currentTotalTime += record.time;
            [times addObject:@(round(currentTotalTime / 60))];
        }
    } else if (total > hoursMax) {
        for (Record *record in records) {
            currentTotalTime += record.time;
            [times addObject:@(round(currentTotalTime / 3600))];
        }
    } else {
        for (Record *record in records) {
            currentTotalTime += record.time;
            [times addObject:@(round(currentTotalTime))];
        }
    }
    NSString *datesString = [dates componentsJoinedByString:@","];
    NSString *timesString = [times componentsJoinedByString:@","];
    return [NSDictionary dictionaryWithObjectsAndKeys:datesString, @"dates", timesString, @"times", nil];
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
