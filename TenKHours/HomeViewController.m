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

static NSString * kTaskCollectionHeaderIdentifier = @"TASK_COLLECTIONHEADER_INDENTIFIER";
static NSString * kStartTaskCellIdentifier        = @"START_TASK_CELL_INDETIFIER";
static NSString * kAddTaskCellIdentifier          = @"ADD_TASK_CELL_INDETIFIER";

@interface HomeViewController () {
    NSMutableArray *_tasks;
}

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tasks = [[NSMutableArray alloc ] initWithObjects:@"Task 1", @"Task 2", @"Task 3", nil];
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
    return [_tasks count] + 1;
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
        [startTaskCell setTaskName:[_tasks objectAtIndex:indexPath.row] order:indexPath.row];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reuseableview = nil;

    if (kind == UICollectionElementKindSectionHeader) {
        reuseableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTaskCollectionHeaderIdentifier forIndexPath:indexPath];
    }

    return reuseableview;
}

@end
