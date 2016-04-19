//
//  BigPicViewController.h
//  ScrollVIewTest
//
//  Created by tunsuy on 12/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigPicViewController : UIViewController

@property (nonatomic, strong) void (^callback)(NSArray *,NSInteger);

- (void)curImage:(NSArray *)images withIndex:(NSInteger)index;

@end
