//
//  AddTaskViewController.m
//  TenKHours
//
//  Created by zation on 5/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "AddTaskViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@implementation AddTaskViewController

@synthesize taskName;

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
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [taskName becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)add:(id)sender {
    _managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    Task *newTask = (Task *)[NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:_managedObjectContext];
    [newTask setName:taskName.text];
    [newTask setTotal:0];
    taskName.text = @"";
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }

    [self.navigationController popViewControllerAnimated:YES];
}
@end
