//
//  TaskChartViewController.m
//  TenKHours
//
//  Created by reg on 6/13/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskChartViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Task.h"
#import "Record.h"
#import <QuartzCore/QuartzCore.h>
#import "MobClick.h"

@interface TaskChartViewController () {
    NSArray *_tasks;
    NSMutableArray *_taskSwitchers;
}

- (void)chartWithTask:(Task *)task;

@end

@implementation TaskChartViewController

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
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    
    [self.webView setOpaque:NO];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"TaskChart" ofType:@"html"];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.scalesPageToFit = YES;
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    self.webView.delegate = self;
    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    _tasks = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    _taskSwitchers = [[NSMutableArray alloc] initWithCapacity:4];
    
    CGFloat taskSwitcherY = 10;
    for (int i = 0; i < [_tasks count]; i++) {
        TaskSwitcher *taskSwitcher = [[TaskSwitcher alloc] initWithFrame:CGRectMake(10, taskSwitcherY, 80, 50)];
        [taskSwitcher setupTask:[_tasks objectAtIndex:i]];
        [_taskSwitchers addObject:taskSwitcher];
        taskSwitcher.delegate = self;
        [self.view addSubview:taskSwitcher];
        taskSwitcherY += 60;
    }
}

- (void)handleSwitch:(Task *)task
{
    [MobClick event:@"switchStat" label:task.name];
    for (TaskSwitcher *taskSwitcher in _taskSwitchers) {
        if (taskSwitcher.task.order == task.order) {
            if (!taskSwitcher.isActive) {
                [self chartWithTask:task];
            }
            [taskSwitcher activate];
        } else {
            [taskSwitcher inActivate];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (void)chartWithTask:(Task *)task {
    NSDictionary *readableRecords = [task getReadableRecords];
    [MobClick event:@"checkStat" label:task.name];

    [self.webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"showChart('%@', '%@', '%@')", [readableRecords objectForKey:@"dates"], [readableRecords objectForKey:@"times"], [task getColorString]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (_tasks.count > 0) {
        [self chartWithTask:_tasks[0]];
        [_taskSwitchers[0] activate];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
