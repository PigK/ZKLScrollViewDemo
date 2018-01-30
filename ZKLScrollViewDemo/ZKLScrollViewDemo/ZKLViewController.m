//
//  ZKLViewController.m
//  test
//
//  Created by koudaishu on 2018/1/30.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import "ZKLViewController.h"

@interface ZKLViewController ()

@end

@implementation ZKLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0
                                                green:arc4random_uniform(256)/255.0
                                                 blue:arc4random_uniform(256)/255.0
                                                alpha:1];
}



@end
