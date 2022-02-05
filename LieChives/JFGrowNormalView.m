//
//  JFGrowNormalView.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/5.
//

#import "JFGrowNormalView.h"

@interface JFGrowNormalView()

@property (nonatomic, strong) UILabel *growNormalViewLbl;

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
                
        //富文本设置（大小，居中）
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.inputText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:25], NSParagraphStyleAttributeName : paragraphStyle}];
        _growNormalViewLbl.attributedText = attrString;
    }
    return _growNormalViewLbl;
}

- (NSString *)inputText{
    if(!_inputText){
        _inputText = @"站位文字";
    }
    return _inputText;
}


@end
