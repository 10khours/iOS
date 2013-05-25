//
//  AddTaskViewController.h
//  TenKHours
//
//  Created by zation on 5/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *taskName;

- (IBAction)cancel:(id)sender;
- (IBAction)add:(id)sender;
@end
