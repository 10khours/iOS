//
//  AddTaskViewController.h
//  TenKHours
//
//  Created by zation on 5/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartTaskCell.h"

@interface AddTaskViewController : UIViewController {
    NSManagedObjectContext *_managedObjectContext;
}

@property (weak, nonatomic) IBOutlet UITextField *textFieldTaskName;
@property (strong, nonatomic) NSNumber *taskCount;

@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
- (IBAction)cancel:(id)sender;
- (IBAction)add:(id)sender;
@end
