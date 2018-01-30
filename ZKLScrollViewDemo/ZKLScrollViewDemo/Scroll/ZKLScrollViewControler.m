//
//  ZKLScrollViewControler.m
//  test
//
//  Created by koudaishu on 2018/1/30.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import "ZKLScrollViewControler.h"
#import "ZKLViewController.h"

@interface ZKLScrollViewControler ()<UIScrollViewDelegate>

@property (nonatomic, strong) ZKLTopScrollView *topView;
@property (nonatomic, strong) UIScrollView     *contentView;

@property (nonatomic, assign) TopScrollViewType type;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *vcArr;
@end

@implementation ZKLScrollViewControler
#pragma mark - init
- (instancetype)initWithType:(TopScrollViewType)type
                    titleArr:(NSArray *)titleArr
                  childvcArr:(NSArray *)vcArr {
    
    if (self = [super init]) {
        self.type = type;
        self.titleArr = titleArr;
        self.vcArr = vcArr;
    }
    return self;
}

#pragma mark - life cycly
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self configChildViewControllers];
}
//设置UI
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.contentView];
}
//设置子控制器
- (void)configChildViewControllers {
    for (UIViewController *vc in self.vcArr) {
        [self addChildViewController:vc];
    }
    
    self.contentView.contentOffset = CGPointMake(0, 0);
    [self scrollViewDidEndScrollingAnimation:self.contentView];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = self.view.frame.size.width;
    NSInteger index = scrollView.contentOffset.x/width;
    [self.topView scrolling:index];
    
    UIViewController *vc = self.childViewControllers[index];
    if ([vc isViewLoaded]) return;
    
    vc.view.frame = CGRectMake(width*index, 0, width, scrollView.frame.size.height);
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidScroll:scrollView];
}

#pragma mark - getters & setters
- (ZKLTopScrollView *)topView {
    if (!_topView) {
        CGFloat width      = self.view.frame.size.width;
        CGFloat statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat topH       = statusBarH + 44.0;
        
        CGRect frame = CGRectMake(0, topH, width, 45);
        _topView = [[ZKLTopScrollView alloc] initWithFrame:frame type:self.type titleNames:self.titleArr];
        
        __weak typeof(self) weakSelf = self;
        _topView.block = ^(NSInteger tag) {
            CGPoint point = CGPointMake(width * tag, weakSelf.contentView.contentOffset.y);
            [weakSelf.contentView setContentOffset:point animated:YES];
        };
    }
    return _topView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
        
        CGFloat statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat toBottomH  = statusBarH > 20 ? 34 : 0;
        CGFloat topH       = statusBarH + 44.0;
        CGRect  frame      = CGRectMake(0, topH+45, width, height-topH-toBottomH-45);
        
        _contentView = [[UIScrollView alloc] initWithFrame:frame];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.contentSize = CGSizeMake(width*self.titleArr.count, 0);
        _contentView.delegate = self;
        _contentView.bounces = NO;
        _contentView.pagingEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
    }
    return _contentView;
}

//- (NSArray *)titleArr {
//    if (!_titleArr) {
//        _titleArr = @[@"啦啦啦",@"哈哈哈",@"嘿嘿",@"嘻嘻",@"呼呼呼",@"嘎嘎嘎",@"吼吼",@"呵呵",@"哇--",@"刷刷",@"噼里啪啦",@"哼哼"];
//    }
//    return _titleArr;
//}

@end
