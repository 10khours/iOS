//
//  HomeViewToolbar.h
//  TenKHours
//
//  Created by zation on 6/22/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolBarButtonDelegate <NSObject>

- (void)handleShareButtonClick;

@end

@interface HomeViewToolbar : UIView

@property (weak, nonatomic) id<ToolBarButtonDelegate> delegate;

- (IBAction)share:(id)sender;

@end
