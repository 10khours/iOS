//
//  TaskCollectionHeaderView.m
//  TenKHours
//
//  Created by reg on 5/22/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "TaskCollectionHeaderView.h"
#import "HomeViewToolbar.h"
#import <QuartzCore/QuartzCore.h>

@implementation TaskCollectionHeaderView

HomeViewToolbar *_toolbar;

- (void)initializeToolbar
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    HomeViewToolbar *toolbar = [[HomeViewToolbar alloc] init];
    CGRect toolbarFrame = toolbar.frame;
    toolbarFrame.origin.y = 90;
    toolbarFrame.origin.x = keyWindow.frame.size.width - toolbarFrame.size.width;
    toolbar.frame = toolbarFrame;
    _toolbar = toolbar;
    toolbar.hidden = YES;
    toolbar.alpha = 0;
    [keyWindow addSubview:toolbar];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UINib *nib = [UINib nibWithNibName:@"TaskCollectionHeaderView" bundle:nil];
        self = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
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

- (IBAction)showFunctions:(id)sender {
    [self.delegate handleRightButtonClick];
}
@end
