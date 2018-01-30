//
//  ZKLTopScrollView.h
//  test
//
//  Created by koudaishu on 2018/1/30.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TopScrollViewType) {
    TopScrollViewTypeFixed,//固定的
    TopScrollViewTypeScrolling //可以滑动的
};

typedef void(^ZKLTopScrollViewBlock)(NSInteger tag);

@interface ZKLTopScrollView : UIScrollView

@property (nonatomic, copy) ZKLTopScrollViewBlock block;


- (instancetype)initWithFrame:(CGRect)frame
                         type:(TopScrollViewType)type
                   titleNames:(NSArray *)titleNames;

- (void)scrolling:(NSInteger)tag;
@end
