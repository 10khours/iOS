//
//  NavigationViewController.m
//  TenKHours
//
//  Created by zation on 5/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "NavigationViewController.h"
#import "HomeViewController.h"

@implementation NavigationViewController

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    self = [super init];
    if (self) {
        [self setNavigationBarHidden:YES];
        HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        homeViewController.managedObjectContext = managedObjectContext;
        [self pushViewController:homeViewController animated:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
