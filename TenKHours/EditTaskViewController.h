//
//  EditTaskViewController.h
//  TenKHours
//
//  Created by zation on 8/8/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface EditTaskViewController : UIViewController

@property (nonatomic, strong) Task *task;
@property (weak, nonatomic) IBOutlet UIButton *buttonEdit;
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTaskName;
@property (weak, nonatomic) IBOutlet UIButton *buttonClear;

- (IBAction)edit:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)clearTask:(id)sender;

@end
