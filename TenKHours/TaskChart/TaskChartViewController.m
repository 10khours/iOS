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

@interface TaskChartViewController ()

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"TaskChart" ofType:@"html"];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.scalesPageToFit = YES;
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    self.webView.delegate = self;
    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
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
    NSMutableArray *dates = [NSMutableArray array];
    NSMutableArray *times = [NSMutableArray array];
    for (Record *record in task.records) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        [formatter setTimeZone:[NSTimeZone localTimeZone]];
        NSString *date = [NSString stringWithFormat:@"%@", [formatter stringFromDate:record.date]];
        [dates addObject:date];
        [times addObject:@(round(record.time))];
    }
    NSString *datesString = [dates componentsJoinedByString:@","];
    NSString *timesString = [times componentsJoinedByString:@","];

    [self.webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"showChart('%@', '%@')", datesString, timesString]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSArray *tasks = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    [self chartWithTask:tasks[0]];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
