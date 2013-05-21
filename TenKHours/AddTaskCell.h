//
//  AddTaskCell.h
//  TenKHours
//
//  Created by zation on 5/19/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskButton.h"

@interface AddTaskCell : UICollectionViewCell

- (IBAction)addTask:(id)sender;
- (void)setTaskCount:(NSInteger)taskCount;

@property (weak, nonatomic) IBOutlet UITextField *textFieldNewTaskName;
@property (weak, nonatomic) IBOutlet AddTaskButton *buttonAddTask;
@property (weak, nonatomic) IBOutlet UILabel *addTaskMark;

@end
