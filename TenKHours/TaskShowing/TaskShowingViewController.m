//
//  TaskShowingViewController.m
//  TenKHours
//
//  Created by reg on 05/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskShowingViewController.h"
#import "Record.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation TaskShowingViewController

@synthesize buttonStop;
@synthesize task;
@synthesize labelTaskName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.progressView.seconds = 0.f;
    UIColor *taskColor = [self.task getColor];
    self.progressView.color = taskColor;
    
    [labelTaskName setTextColor:taskColor];
    [labelTaskName setText:task.name];
    
    buttonStop.backgroundColor = taskColor;
    buttonStop.layer.cornerRadius = 10;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(increaseTime)
                                            userInfo:nil
                                             repeats:YES];
    _startDate = [NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)increaseTime {
    float seconds = (float)[[NSDate date] timeIntervalSinceDate:_startDate];
    self.progressView.seconds = fmodf(seconds, 60);
    self.progressView.total = seconds;
    [self.progressView setNeedsDisplay];
}

- (IBAction)stopTimer:(id)sender {
    [self.task addRecordWithStartDate:_startDate endDate:[NSDate date]];
    
    [_timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
