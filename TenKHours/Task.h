//
//  Task.h
//  TenKHours
//
//  Created by zation on 5/29/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Record;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSTimeInterval total;
@property (nonatomic, retain) NSSet *records;
@property (nonatomic, retain) NSNumber *order;

@end

@interface Task (CoreDataGeneratedAccessors)

- (void)addRecordsObject:(Record *)value;
- (void)removeRecordsObject:(Record *)value;
- (void)addRecords:(NSSet *)values;
- (void)removeRecords:(NSSet *)values;
- (UIColor *)getColor;

@end
