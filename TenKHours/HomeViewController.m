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
#import <CoreData/CoreData.h>

static NSString * kTaskCollectionHeaderIdentifier = @"TASK_COLLECTIONHEADER_INDENTIFIER";
static NSString * kStartTaskCellIdentifier        = @"START_TASK_CELL_INDETIFIER";
static NSString * kAddTaskCellIdentifier          = @"ADD_TASK_CELL_INDETIFIER";

@implementation HomeViewController

@synthesize managedObjectContext;

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
}

- (void)viewDidAppear:(BOOL)animated
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    tasks = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
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
    NSInteger tasksCount = [tasks count] + 1;
    return tasksCount > 4 ? 4 : tasksCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (indexPath.row == [tasks count]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddTaskCellIdentifier forIndexPath:indexPath];
        AddTaskCell *addTaskCell = (AddTaskCell *)cell;
        [addTaskCell setTaskCount:[tasks count]];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kStartTaskCellIdentifier forIndexPath:indexPath];
        StartTaskCell *startTaskCell = (StartTaskCell *)cell;
        [startTaskCell setTaskName:[[tasks objectAtIndex:indexPath.row] valueForKey:@"name"] order:indexPath.row];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTaskCollectionHeaderIdentifier forIndexPath:indexPath];
    }

    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [tasks count]) {
        AddTaskViewController *addTaskViewController = [[AddTaskViewController alloc] initWithNibName:@"AddTaskViewController" bundle:nil];
        addTaskViewController.managedObjectContext = managedObjectContext;
        [self.navigationController pushViewController:addTaskViewController animated:YES];
    }
}

@end
