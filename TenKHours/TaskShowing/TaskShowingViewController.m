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
}

@property (weak, nonatomic) IBOutlet TaskProgressView *progressView;
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
    self.progressView.percent = 0.f;
    self.progressView.color = self.color;
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
    self.progressView.percent = self.progressView.percent + 0.1;
    if(self.progressView.percent >= 60) {
        self.progressView.percent = 0.0;
    }
    [self.progressView setNeedsDisplay];
}

- (IBAction)stopTimer:(id)sender {
    [_timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
