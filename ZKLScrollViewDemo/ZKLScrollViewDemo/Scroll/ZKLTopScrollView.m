//
//  ZKLTopScrollView.m
//  test
//
//  Created by koudaishu on 2018/1/30.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import "ZKLTopScrollView.h"

@interface ZKLTopScrollView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *lastButton;

@property (nonatomic, strong) NSMutableArray *buttonArr;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@end

@implementation ZKLTopScrollView

- (instancetype)initWithFrame:(CGRect)frame type:(TopScrollViewType)type titleNames:(NSArray *)titleNames {
    if (self = [super initWithFrame:frame]) {
        [self baseConfig];
        
        CGFloat buttonW = 0;
        CGFloat buttonH = frame.size.height;
        CGFloat buttonX = 0;
        
        for (NSInteger i = 0; i < titleNames.count; i++) {
            UIButton *button = [self createButtonWithTitleName:titleNames[i]];
            button.tag = i;
            [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0) {
                [self createLineWithButton:button];
            }
            
            if (type == TopScrollViewTypeFixed) {
                buttonW = frame.size.width/titleNames.count;
            }else {
                buttonW = button.frame.size.width + 20;
            }
            button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
            buttonX += buttonW;
        }
        
        if (type == TopScrollViewTypeFixed) {
            self.contentSize = CGSizeMake(frame.size.width, 0);
        }else {
            CGFloat contentSizeW = buttonX > frame.size.width ? buttonX : frame.size.width;
            self.contentSize = CGSizeMake(contentSizeW, 0);
        }
    }
    return self;
}

#pragma mark - public method

- (void)scrolling:(NSInteger)tag {
    UIButton *button = self.buttonArr[tag];
    self.lastButton.selected = NO;
    button.selected = YES;
    self.lastButton = button;
    
    CGPoint lineCenter = self.lineView.center;
    CGPoint btnCenter = button.center;
    lineCenter.x = btnCenter.x;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.lineView.center = lineCenter;
    }];
    
    CGFloat offSetX  = 0;
    CGFloat centerX  = btnCenter.x;
    
    CGFloat width    = self.frame.size.width;
    CGFloat contentW = self.contentSize.width;
    
    if (centerX < width/2) {
        offSetX = 0;
    }else if ((contentW - centerX) < width/2) {
        offSetX = contentW - width;
    } else {
        offSetX = centerX - width/2;
    }
    [self setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}

#pragma mark - private method
- (void)baseConfig {
    self.alwaysBounceVertical = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
}

- (UIButton *)createButtonWithTitleName:(NSString *)titleName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = self.font;
    [button setTitle:titleName forState:UIControlStateNormal];
    [button setTitleColor:self.normalColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectedColor forState:UIControlStateSelected];
    [button sizeToFit];
    [self addSubview:button];
    [self.buttonArr addObject:button];
    return button;
}

- (void)createLineWithButton:(UIButton *) button {
    button.selected = YES;
    self.lastButton = button;
    
    CGFloat btnW = button.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    
    CGFloat width = btnW + 5;
    CGFloat height = 1.5;
    
    CGRect frame = CGRectMake((btnW-width)/2, viewH-height, width, height);
    self.lineView.frame = frame;
    [self addSubview:self.lineView];
}

#pragma mark - click event
- (void)titleClick:(UIButton *)button {
    if (self.block) {
        self.block(button.tag);
    }
}

#pragma mark - gatters & setters
- (NSMutableArray *)buttonArr {
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray new];
    }
    return _buttonArr;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = self.selectedColor;
    }
    return _lineView;
}

- (UIColor *)normalColor {
    if (!_normalColor) {
        _normalColor = [UIColor blackColor];
    }
    return _normalColor;
}

- (UIColor *)selectedColor {
    if (!_selectedColor) {
        _selectedColor = [UIColor redColor];
    }
    return _selectedColor;
}

- (UIFont *)font {
    if (!_font) {
        _font = [UIFont systemFontOfSize:15];
    }
    return _font;
}

@end
