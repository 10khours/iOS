//
//  TaskChartViewController.h
//  TenKHours
//
//  Created by reg on 6/13/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskSwitcher.h"

@interface TaskChartViewController : UIViewController <UIWebViewDelegate, TaskSwitcherDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
