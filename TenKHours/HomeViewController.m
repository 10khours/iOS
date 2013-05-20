//
//  HomeViewController.m
//  TenKHours
//
//  Created by zation on 5/19/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "HomeViewController.h"
#import "AddTaskCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

NSMutableArray *tasks;
NSArray *taskColors;

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
	tasks = [NSMutableArray arrayWithObjects:@"Task 1", @"Task 2", @"Task 3", nil];
    NSString *systemConfigPath = [[NSBundle mainBundle] pathForResource:@"SystemConfig" ofType:@"plist"];
    NSDictionary *systemConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:systemConfigPath];
    taskColors = [systemConfig objectForKey:@"TaskColors"];
    [self.collectionView registerClass:[AddTaskCell class] forCellWithReuseIdentifier:@"AddTaskCell"];
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
    return [tasks count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (indexPath.row == [tasks count]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddTaskCell" forIndexPath:indexPath];
        AddTaskCell *addTaskCell = (AddTaskCell *)cell;
        
        NSDictionary *borderColor = [taskColors objectAtIndex:[tasks count] -1];
        float red = [[borderColor valueForKey:@"Red"] floatValue];
        float blue = [[borderColor valueForKey:@"Blue"] floatValue];
        float green = [[borderColor valueForKey:@"Green"] floatValue];

        addTaskCell.buttonAddTask.borderColor = [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1.0];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TaskCell" forIndexPath:indexPath];
        UILabel *taskName = (UILabel *) [cell viewWithTag:1];
        taskName.text = [tasks objectAtIndex:indexPath.row];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{   
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Logo" forIndexPath:indexPath];
}

@end
