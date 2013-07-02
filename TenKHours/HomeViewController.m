//
//  HomeViewController.m
//  TenKHours
//
//  Created by zation on 5/19/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "HomeViewController.h"
#import "AddTaskCell.h"
#import "StartTaskCell.h"
#import "TaskCollectionHeaderView.h"
#import "AddTaskViewController.h"
#import "AppDelegate.h"
#import "TaskShowingViewController.h"
#import "CommonHelper.h"
#import "TaskChartViewController.h"
#import <CoreData/CoreData.h>
#import "HomeViewToolbar.h"
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>

static NSString * kTaskCollectionHeaderIdentifier = @"TASK_COLLECTIONHEADER_INDENTIFIER";
static NSString * kStartTaskCellIdentifier        = @"START_TASK_CELL_INDETIFIER";
static NSString * kAddTaskCellIdentifier          = @"ADD_TASK_CELL_INDETIFIER";
static NSInteger const kHeightOfToolBar           = 50;

@interface HomeViewController () {
    HomeViewToolbar *_toolbar;
    UIView *_overlay;
}

- (void)initializeToolbar;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[AddTaskCell class] forCellWithReuseIdentifier:kAddTaskCellIdentifier];
    [self.collectionView registerClass:[StartTaskCell class] forCellWithReuseIdentifier:kStartTaskCellIdentifier];
    [self.collectionView registerClass:[TaskCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTaskCollectionHeaderIdentifier];
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    _managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    [self initializeToolbar];
}

- (void)initializeToolbar {
    _toolbar = [[HomeViewToolbar alloc] init];
    CGRect toolbarFrame = _toolbar.frame;
    toolbarFrame.origin.y = 60;
    toolbarFrame.origin.x = self.view.frame.size.width - toolbarFrame.size.width;
    toolbarFrame.size.height = 50;
    _toolbar.frame = toolbarFrame;
    _toolbar.hidden = YES;
    _toolbar.delegate = self;
    [self.view addSubview:_toolbar];
}

- (void)handleRightButtonClick {
    if (_toolbar.hidden) {
        _toolbar.hidden = NO;
        [UIView animateWithDuration:.5 animations:^{
            _toolbar.alpha = 1;
        }];
    } else {
        [UIView animateWithDuration:.5 animations:^{
            _toolbar.alpha = 0;
        } completion:^(BOOL finished){
            _toolbar.hidden = YES;
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _toolbar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    _tasks = [[_managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger tasksCount = [_tasks count] + 1;
    return tasksCount > 4 ? 4 : tasksCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (indexPath.row == [_tasks count]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddTaskCellIdentifier forIndexPath:indexPath];
        AddTaskCell *addTaskCell = (AddTaskCell *)cell;
        [addTaskCell setTaskCount:[_tasks count]];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kStartTaskCellIdentifier forIndexPath:indexPath];
        StartTaskCell *startTaskCell = (StartTaskCell *)cell;
        [startTaskCell setTask:[_tasks objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reuseableview = nil;

    if (kind == UICollectionElementKindSectionHeader) {
        reuseableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTaskCollectionHeaderIdentifier forIndexPath:indexPath];
        ((TaskCollectionHeaderView *)reuseableview).delegate = self;
    }

    return reuseableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_tasks count]) {
        AddTaskViewController *addTaskViewController = [[AddTaskViewController alloc] initWithNibName:@"AddTaskViewController" bundle:nil];
        addTaskViewController.taskCount = [NSNumber numberWithInt:[_tasks count]];
        [self.navigationController pushViewController:addTaskViewController animated:YES];
    } else {
        TaskShowingViewController *taskShowingViewController = [[TaskShowingViewController alloc] initWithNibName:@"TaskShowingViewController" bundle:nil];
        
        taskShowingViewController.task = [_tasks objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:taskShowingViewController animated:YES];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        TaskChartViewController *taskChartViewController = [[TaskChartViewController alloc] initWithNibName:@"TaskChartViewController" bundle:nil];
        [self.navigationController pushViewController:taskChartViewController animated:YES];
    }
}

- (void)handleShareButtonClick {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        SLComposeViewController *sinaSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        NSMutableString *initialText = [[NSMutableString alloc] init];
        
        for (Task *task in _tasks) {
            NSDictionary *readableTimeAndUnitTotal = [task getReadableTimeAndUnitTotal];
            NSDictionary *readableTimeAndUnitToday = [task getReadableTimeAndUnitToday];
            [initialText appendString:[NSString stringWithFormat:@"今天练习 %@ %d %@，总共 %d %@；",
                                       task.name,
                                       [[readableTimeAndUnitToday objectForKey:@"time"] intValue],
                                       [readableTimeAndUnitToday objectForKey:@"unit"],
                                       [[readableTimeAndUnitTotal objectForKey:@"time"] intValue],
                                       [readableTimeAndUnitTotal objectForKey:@"unit"]]];
        }
        if ([_tasks count] == 0) {
            [initialText appendString:@"我开始使用10K Hours啦 https://itunes.apple.com/us/app/10k-hours/id663834346"];
        } else {
            [initialText deleteCharactersInRange:NSMakeRange([initialText length] - 1, 1)];
            [initialText appendString:@"。https://itunes.apple.com/us/app/10k-hours/id663834346"];
        }
        [sinaSheet setInitialText:initialText];
        [self presentViewController:sinaSheet animated:YES completion:nil];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    _toolbar.frame = CGRectMake(_toolbar.frame.origin.x, _toolbar.frame.origin.y, _toolbar.frame.size.width, kHeightOfToolBar);
}
@end
