//
//  TaskCollectionHeaderView.h
//  TenKHours
//
//  Created by reg on 5/22/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderButtonDelegate <NSObject>

- (void)handleRightButtonClick;

@end

@interface TaskCollectionHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *buttonFunction;
@property (weak, nonatomic) id<HeaderButtonDelegate> delegate;

- (IBAction)showFunctions:(id)sender;

@end
