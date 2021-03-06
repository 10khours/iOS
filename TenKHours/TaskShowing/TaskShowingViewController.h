//
//  TaskShowingViewController.h
//  TenKHours
//
//  Created by reg on 05/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskProgressView.h"
#import "Task.h"

@interface TaskShowingViewController : UIViewController {
    NSTimer *_timer;
    NSDate *_startDate;
}

@property (nonatomic, strong) Task *task;
@property (weak, nonatomic) IBOutlet TaskProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *buttonStop;
@property (weak, nonatomic) IBOutlet UILabel *labelTaskName;

@end
