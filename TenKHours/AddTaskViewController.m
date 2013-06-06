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
#import "CommonHelper.h"
#import "Record.h"
#import <QuartzCore/QuartzCore.h>

@implementation AddTaskViewController

@synthesize textFieldTaskName;
@synthesize taskCount;
@synthesize buttonAdd;
@synthesize buttonCancel;
@synthesize textFieldhours;
@synthesize textFieldMinutes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    UIColor *taskColor = [CommonHelper getColorFromTaskColor:[[CommonHelper getDefaultTaskColors] objectAtIndex: [taskCount integerValue]]];
    
    buttonCancel.backgroundColor = [UIColor grayColor];
    buttonCancel.layer.cornerRadius = 5;

    buttonAdd.backgroundColor = taskColor;
    buttonAdd.layer.cornerRadius = 5;
    
    [textFieldTaskName becomeFirstResponder];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    
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
    [newTask setName:textFieldTaskName.text];
    [newTask setTotal:0.0];
    [newTask setOrder:taskCount];
    
    double minutes = [textFieldMinutes.text doubleValue];
    double hours = [textFieldhours.text doubleValue];
    if (hours > 0 || minutes > 0) {
        [newTask addRecordWithStartDate:[NSDate date] duration:(hours * 3600 + minutes * 60)];
    }
    
    textFieldTaskName.text = @"";
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }

    [self.navigationController popViewControllerAnimated:YES];
}
@end
