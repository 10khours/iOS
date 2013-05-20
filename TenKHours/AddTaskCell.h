//
//  AddTaskCell.h
//  TenKHours
//
//  Created by zation on 5/19/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskButton.h"

@interface AddTaskCell : UICollectionViewCell

- (IBAction)addTask:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNewTaskName;
@property (weak, nonatomic) IBOutlet TaskButton *buttonAddTask;
@property (weak, nonatomic) IBOutlet UILabel *addTaskMark;

@end
