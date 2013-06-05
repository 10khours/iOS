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
@property (nonatomic, retain) NSSet *record;
@property (nonatomic, retain) NSNumber *order;

@end

@interface Task (CoreDataGeneratedAccessors)

- (void)addRecordObject:(Record *)value;
- (void)removeRecordObject:(Record *)value;
- (void)addRecord:(NSSet *)values;
- (void)removeRecord:(NSSet *)values;
- (UIColor *)getColor;

@end
