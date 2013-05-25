//
//  TaskShowingViewController.m
//  TenKHours
//
//  Created by reg on 05/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskShowingViewController.h"
#import "TaskProgressView.h"

@interface TaskShowingViewController () {
    NSTimer *_timer;
    TaskProgressView *_progressView;
}

@end

@implementation TaskShowingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    _progressView = [[TaskProgressView alloc] initWithFrame:CGRectMake(30, 120, 261, 266)];
    _progressView.percent = 0;
    [self.view addSubview:_progressView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(increaseTime)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)increaseTime {
    _progressView.percent = _progressView.percent + 0.1;
    if(_progressView.percent >= 60) {
        _progressView.percent = 0.0;
    }
    [_progressView setNeedsDisplay];
}

@end
