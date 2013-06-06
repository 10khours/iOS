//
//  TaskProgressView.h
//  TenKHours
//
//  Created by reg on 05/23/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskProgressView : UIView {
    CGFloat _startAngle;
    CGFloat _endAngle;
    float  _total;
}

@property (nonatomic, assign) float percent;
@property (nonatomic, strong) UIColor *color;

@end
