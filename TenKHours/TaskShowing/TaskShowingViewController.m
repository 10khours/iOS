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
    self.progressView.percent = 0.f;
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
    self.progressView.percent = self.progressView.percent + 0.1;
    if(self.progressView.percent >= 60) {
        self.progressView.percent = 0.0;
    }
    [self.progressView setNeedsDisplay];
}

- (IBAction)stopTimer:(id)sender {
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSDate *now = [NSDate date];
    NSTimeInterval duration = [now timeIntervalSinceDate:_startDate];

    Record *record = (Record *)[NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:managedObjectContext];
    [record setDate:now];
    [record setTime:duration];
    [record setTask:task];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    
    [_timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
