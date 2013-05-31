//
//  AddTaskCell.h
//  TenKHours
//
//  Created by zation on 5/19/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskCircle.h"

@interface AddTaskCell : UICollectionViewCell {
    NSArray *_taskColors;
}

- (void)setTaskCount:(NSInteger)taskCount;

@property (weak, nonatomic) IBOutlet AddTaskCircle *addTaskCircle;
@property (weak, nonatomic) IBOutlet UILabel *addTaskMark;

@end
