//
//  TaskShowingViewController.h
//  TenKHours
//
//  Created by reg on 05/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskProgressView.h"

@interface TaskShowingViewController : UIViewController {
    NSTimer *_timer;
}

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *taskName;
@property (weak, nonatomic) IBOutlet TaskProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *buttonStop;
@property (weak, nonatomic) IBOutlet UILabel *labelTaskName;

@end
