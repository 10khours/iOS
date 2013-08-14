//
//  EditTaskViewController.m
//  TenKHours
//
//  Created by zation on 8/8/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "EditTaskViewController.h"
#import "CommonHelper.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "MobClick.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

@synthesize buttonCancel;
@synthesize buttonEdit;
@synthesize textFieldTaskName;
@synthesize task;
@synthesize buttonClear;

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
    
    buttonCancel.layer.cornerRadius = 5;
    
    buttonEdit.backgroundColor = [task getColor];
    buttonEdit.layer.cornerRadius = 5;
    
    buttonClear.backgroundColor = [UIColor colorWithRed:1 green:.32 blue:.32 alpha:1.0];
    buttonClear.layer.cornerRadius = 5;
    
    [textFieldTaskName becomeFirstResponder];
    textFieldTaskName.text = task.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit:(id)sender {
    [task modifyName:textFieldTaskName.text];
    [MobClick event:@"editTask"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clearTask:(id)sender {
    UIAlertView *confirmation = [[UIAlertView alloc] initWithTitle:@"Clear Task Records" message:@"Are you sure you want to clear this task records?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Clear", nil];
    [confirmation show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        task.records = nil;
        task.total = 0;
        [MobClick event:@"clearTask"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
