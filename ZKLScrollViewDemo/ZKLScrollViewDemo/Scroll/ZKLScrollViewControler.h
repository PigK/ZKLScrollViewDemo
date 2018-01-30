//
//  ZKLScrollViewControler.h
//  test
//
//  Created by koudaishu on 2018/1/30.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKLTopScrollView.h"

@interface ZKLScrollViewControler : UIViewController

- (instancetype)initWithType:(TopScrollViewType)type
                    titleArr:(NSArray *)titleArr
                  childvcArr:(NSArray *)vcArr;

@end
