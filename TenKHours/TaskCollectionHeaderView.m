//
//  TaskCollectionHeaderView.m
//  TenKHours
//
//  Created by reg on 5/22/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskCollectionHeaderView.h"

@implementation TaskCollectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *headerLogo = [UIImage imageNamed:@"logo.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 280, 60)];
        imageView.image = headerLogo;
        [self addSubview:imageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
