//
//  TaskSwitcher.h
//  TenKHours
//
//  Created by zation on 6/17/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol TaskSwitcherDelegate <NSObject>

- (void)handleSwitch:(Task *)task;

@end

@interface TaskSwitcher : UIView

@property (weak, nonatomic) id<TaskSwitcherDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *labelTotalTime;
@property (weak, nonatomic) IBOutlet UILabel *labelUnit;
@property (weak, nonatomic) IBOutlet UIView *viewFlip;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) Task *task;
@property (nonatomic) BOOL isActive;

- (void)setupTask:(Task *)_task;
- (void)activate;
- (void)inActivate;
@end
