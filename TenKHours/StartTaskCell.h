//
//  StartTaskCell.h
//  TenKHours
//
//  Created by zation on 5/21/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartTaskCircle.h"

@interface StartTaskCell : UICollectionViewCell {
    NSArray *_taskColors;
}

- (void)setTaskName:(NSString *)taskName order:(NSInteger)order;

@property (weak, nonatomic) IBOutlet UILabel *labelTaskName;
@property (weak, nonatomic) IBOutlet StartTaskCircle *startTaskCircle;


@end
