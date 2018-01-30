//
//  ViewController.m
//  ZKLScrollViewDemo
//
//  Created by koudaishu on 2018/1/30.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import "ViewController.h"
#import "ZKLScrollViewControler.h"
#import "ZKLViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)didClickdeShowBtn:(id)sender forEvent:(UIEvent *)event {
    
    NSMutableArray *vcArr = [[NSMutableArray alloc] init];
    NSArray *titleArr = @[@"啦啦啦",@"哈哈哈",@"嘿嘿",@"嘻嘻",@"呼呼呼",@"嘎嘎嘎",
                          @"吼吼",@"呵呵",@"哇--",@"刷刷",@"噼里啪啦",@"哼哼"];
    
    for (int i = 0; i<titleArr.count; i++) {
        ZKLViewController *childvc = [[ZKLViewController alloc] init];
        [vcArr addObject:childvc];
    }
    
    ZKLScrollViewControler *vc = [[ZKLScrollViewControler alloc] initWithType:TopScrollViewTypeScrolling
                                                                     titleArr:titleArr
                                                                   childvcArr:[vcArr copy]];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
