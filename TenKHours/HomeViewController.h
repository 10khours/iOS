//
//  HomeViewController.h
//  TenKHours
//
//  Created by zation on 5/19/13.
//  Copyright (c) 2013 Zation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskCollectionHeaderView.h"

@interface HomeViewController : UICollectionViewController <HeaderButtonDelegate>{
    NSMutableArray *_tasks;
    NSManagedObjectContext *_managedObjectContext;
}

@end
