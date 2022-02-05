//
//  JFGrowNormalView.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/5.
//

#import "JFGrowNormalView.h"

@interface JFGrowNormalView()


@end

@implementation JFGrowNormalView

# pragma mark - initWithFrame（设置控件）
- (instancetype)initWithFrame:(CGRect)frame{
    //初始化
    self = [super initWithFrame:frame];
    
    self.backgroundColor = myColorLightGreen;
    
    //设置子控件
    [self setupSubViews];
    
    return self;
}

- (void)setupSubViews{
    //添加lbl
    [self addSubview:self.growNormalViewLbl];
    
    //设置自动布局
    [self.growNormalViewLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.center);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
    }];
    
}

# pragma mark - 懒加载
- (UILabel *)growNormalViewLbl{
    if(!_growNormalViewLbl){
        _growNormalViewLbl = [UILabel new];
    }
    return _growNormalViewLbl;
}


@end
