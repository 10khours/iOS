//
//  WalkThroughViewController.m
//  TenKHours
//
//  Created by reg on 7/2/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import "WalkThroughViewController.h"
#import "ContentViewController.h"
#import "HomeViewController.h"

@interface WalkThroughViewController ()

@property (nonatomic, strong) NSMutableArray *viewControllers;

@end

@implementation WalkThroughViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUInteger numberPages = self.contentList.count;
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSUInteger i = 0; i < numberPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * ( numberPages + 1 ),
                                             self.scrollView.frame.size.height / 2);

    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    NSLog(@"%f, %f", self.scrollView.frame.size.height, self.scrollView.frame.size.width);

    self.pageControl.numberOfPages = numberPages;
    self.pageControl.currentPage = 0;

    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= self.contentList.count) {
        return;
    }

    ContentViewController *controller = self.viewControllers[page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[ContentViewController alloc] initWithNibName:nil bundle:nil];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:controller.view.frame];
        [controller.view addSubview:imageView];
        self.viewControllers[page] = controller;
    }
    
    if (controller.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        
        [controller.view.subviews[0] setImage:[UIImage imageNamed:self.contentList[page]]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.pageControl.currentPage == self.contentList.count - 1) {
        HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                               forView:self.navigationController.view
                                 cache:NO];
        [self.navigationController pushViewController:homeViewController animated:YES];
        [UIView commitAnimations];
    }
    
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor(self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth + 1;
    self.pageControl.currentPage = page;
    
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}
@end
