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
#import "TaskSwitcher.h"

@interface TaskChartViewController () {
    NSArray *tasks;
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
    tasks = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    CGFloat taskSwitcherY = 10;
    for (int i = 0; i < [tasks count]; i++) {
        TaskSwitcher *taskSwitcher = [[TaskSwitcher alloc] init];
        CGRect taskSwitcherFrame = CGRectMake(10, taskSwitcherY, 80, 50);
        taskSwitcher.frame = taskSwitcherFrame;
        taskSwitcherY += 60;
        [taskSwitcher setTask:[tasks objectAtIndex:i]];
        [self.view addSubview:taskSwitcher];
        if (i == 0) {
            [taskSwitcher activate];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSwitch:) name:@"switch" object:nil];
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

- (void)onSwitch:(NSNotification *)notification
{
    Task *task = [notification.userInfo objectForKey:@"task"];
    [self chartWithTask:task];
}

- (void)chartWithTask:(Task *)task {
    NSMutableArray *dates = [NSMutableArray array];
    NSMutableArray *times = [NSMutableArray array];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *records = [task.records sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    double currentTotalTime = 0;
    for (Record *record in records) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        [formatter setTimeZone:[NSTimeZone localTimeZone]];
        NSString *date = [NSString stringWithFormat:@"%@", [formatter stringFromDate:record.date]];
        [dates addObject:date];
        currentTotalTime += record.time;
        [times addObject:@(round(currentTotalTime))];
    }
    NSString *datesString = [dates componentsJoinedByString:@","];
    NSString *timesString = [times componentsJoinedByString:@","];

    [self.webView stringByEvaluatingJavaScriptFromString:
    [NSString stringWithFormat:@"showChart('%@', '%@', '%@')", datesString, timesString, [task getColorString]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self chartWithTask:tasks[0]];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
