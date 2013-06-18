//
//  TaskSwitcher.h
//  TenKHours
//
//  Created by zation on 6/17/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TaskSwitcher : UIView {
    @private
        Task *_task;
}

@property (weak, nonatomic) IBOutlet UILabel *labelTotalTime;
@property (weak, nonatomic) IBOutlet UILabel *labelUnit;
@property (weak, nonatomic) IBOutlet UIButton *buttonSwitcher;
- (IBAction)touchToActivate:(id)sender;

- (void)setTask:(Task *)task;
- (void)activate;

@end
