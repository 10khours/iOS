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
#import <QuartzCore/QuartzCore.h>

@interface TaskChartViewController () {
    NSArray *tasks;
    NSMutableArray *_containViews;
    NSMutableArray *_switchViews;
    NSMutableArray *_flipViews;
    NSInteger _lastShowTask;
}

- (void)chartWithTask:(Task *)task;

@end

@implementation TaskChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _containViews = [NSMutableArray arrayWithCapacity:4];
        _switchViews = [NSMutableArray arrayWithCapacity:4];
        _flipViews = [NSMutableArray arrayWithCapacity:4];
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
    [_containViews removeAllObjects];
    for (int i = 0; i < [tasks count]; i++) {
        UIView *containsView = [[UIView alloc] initWithFrame:CGRectMake(10, taskSwitcherY, 80, 50)];
        containsView.backgroundColor = [UIColor clearColor];
        TaskSwitcher *taskSwitcher = [[TaskSwitcher alloc] initWithFrame:containsView.bounds];
        [taskSwitcher setTask:tasks[i]];
        UIView *flipView = [[UIView alloc] initWithFrame:containsView.bounds];
        flipView.layer.cornerRadius = 5;
        flipView.backgroundColor = [tasks[i] getColor];
        taskSwitcherY += 60;
        if (i == 0) {
            _lastShowTask = 0;
            [containsView addSubview:taskSwitcher];
        } else {
            [containsView addSubview:flipView];
        }
        __weak UIView *weakView = containsView;
        [_containViews addObject:weakView];
        __weak UIView *weakSwitch = taskSwitcher;
        [_switchViews addObject: weakSwitch];
        __weak UIView *weakFlipView = flipView;
        [_flipViews addObject: weakFlipView];
        [self.view addSubview:containsView];
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(respondToTapGesture:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];
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

- (void)respondToTapGesture:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    for (int i = 0; i < _containViews.count; i++) {
        if (CGRectContainsPoint([_containViews[i] frame], location)) {
            if (_lastShowTask != i) {
                [UIView transitionFromView:[_containViews[_lastShowTask] subviews][0] toView:_flipViews[_lastShowTask] duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
                    
                }];
                [UIView transitionFromView:[_containViews[i] subviews][0] toView:_switchViews[i] duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
                }];
                _lastShowTask = i;
            }
            break;
        }
    }
}

- (void)chartWithTask:(Task *)task {
    NSDictionary *readableRecords = [task getReadableRecords];

    [self.webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"showChart('%@', '%@', '%@')", [readableRecords objectForKey:@"dates"], [readableRecords objectForKey:@"times"], [task getColorString]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (tasks.count > 0) {
        [self chartWithTask:tasks[0]];        
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
