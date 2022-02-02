//
//  JFRoomsBackgroundView.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/2.
//

#import "JFRoomsBackgroundView.h"
@interface JFRoomsBackgroundView()
@property (nonatomic, strong) UIButton *kitchenBtn;
@property (nonatomic, strong) UIButton *livingroomBtn;
@property (nonatomic, strong) UIButton *bedroomBtn;
@property (nonatomic, strong) UIButton *bathroomBtn;






@end

@implementation JFRoomsBackgroundView


# pragma mark - initWithFrame（设置控件）
- (instancetype)initWithFrame:(CGRect)frame{
    //初始化
    self = [super initWithFrame:frame];
    
    //设置子控件
    [self setupSubViews];
    
    return self;
}

- (void)setupSubViews{
    //添加厨房btn
    [self addSubview:self.kitchenBtn];
    
    //设置自动布局
    [self.kitchenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(4);
            make.top.equalTo(self.mas_top).offset(4);
            make.height.mas_equalTo(180);
            make.width.mas_equalTo(160);
    }];
    
    //添加客厅btn
    [self addSubview:self.livingroomBtn];
    
    //设置自动布局
    [self.livingroomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-4);
            make.top.equalTo(self.mas_top).offset(4);
            make.height.mas_equalTo(180);
            make.width.mas_equalTo(160);
    }];
    
    //添加卧室btn
    [self addSubview:self.bedroomBtn];
    
    //设置自动布局
    [self.bedroomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(4);
            make.bottom.equalTo(self.mas_bottom).offset(-4);
            make.height.mas_equalTo(180);
            make.width.mas_equalTo(160);
    }];
    
    //添加卫生间btn
    [self addSubview:self.bathroomBtn];
    
    //设置自动布局
    [self.bathroomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-4);
            make.bottom.equalTo(self.mas_bottom).offset(-4);
            make.height.mas_equalTo(180);
            make.width.mas_equalTo(160);
    }];
    
    /*
     UIViewContentModeScaleToFill,
     UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
     UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
     
     
     UIViewContentModeTop,
     UIViewContentModeBottom,
     UIViewContentModeLeft,
     UIViewContentModeRight,
     UIViewContentModeTopLeft,
     UIViewContentModeTopRight,
     UIViewContentModeBottomLeft,
     UIViewContentModeBottomRight,
     */
}

# pragma mark - 懒加载

- (UIButton *)kitchenBtn{
    if(!_kitchenBtn){
        _kitchenBtn = [UIButton new];
        [_kitchenBtn setImage:[UIImage imageNamed:@"kitchen_home"] forState:UIControlStateNormal];
//        [_kitchenBtn addTarget:self action:@selector(kitchenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _kitchenBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _kitchenBtn;
}

- (UIButton *)livingroomBtn{
    if(!_livingroomBtn){
        _livingroomBtn = [UIButton new];
        [_livingroomBtn setImage:[UIImage imageNamed:@"livingroom_home"] forState:UIControlStateNormal];
        _livingroomBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;

    }
    return _livingroomBtn;
}

- (UIButton *)bedroomBtn{
    if(!_bedroomBtn){
        _bedroomBtn = [UIButton new];
        [_bedroomBtn setImage:[UIImage imageNamed:@"bedroom_home"] forState:UIControlStateNormal];
        _bedroomBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bedroomBtn;
}

- (UIButton *)bathroomBtn{
    if(!_bathroomBtn){
        _bathroomBtn = [UIButton new];
        [_bathroomBtn setImage:[UIImage imageNamed:@"bathroom_home"] forState:UIControlStateNormal];
        _bathroomBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bathroomBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
