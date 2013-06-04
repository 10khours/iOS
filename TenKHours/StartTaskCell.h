//
//  StartTaskCell.h
//  TenKHours
//
//  Created by zation on 5/21/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartTaskCircle.h"
#import "Task.h"

@interface StartTaskCell : UICollectionViewCell

- (void)setTask:(Task *)task;

@property (weak, nonatomic) IBOutlet UILabel *labelTaskName;
@property (weak, nonatomic) IBOutlet StartTaskCircle *startTaskCircle;


@end
