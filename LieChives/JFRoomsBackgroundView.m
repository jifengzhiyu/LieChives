//
//  JFRoomsBackgroundView.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/2.
//

#import "JFRoomsBackgroundView.h"
@interface JFRoomsBackgroundView()



//四个房间的标签
@property (nonatomic, strong) UILabel *kitchenLbl;
@property (nonatomic, strong) UILabel *livingroomLbl;
@property (nonatomic, strong) UILabel *bedroomLbl;
@property (nonatomic, strong) UILabel *bathroomLbl;

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
    
    //添加厨房lbl
    [self.kitchenBtn addSubview:self.kitchenLbl];
    
    //设置自动布局
    [self.kitchenLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.kitchenBtn.mas_right).offset(-5);
            make.top.equalTo(self.kitchenBtn.mas_top).offset(5);
    }];
    
    //添加客厅lbl
    [self.livingroomBtn addSubview:self.livingroomLbl];
    
    //设置自动布局
    [self.livingroomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.livingroomBtn.mas_left).offset(5);
            make.top.equalTo(self.livingroomBtn.mas_top).offset(5);
    }];
    
    //添加卧室lbl
    [self.bedroomBtn addSubview:self.bedroomLbl];
    
    //设置自动布局
    [self.bedroomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bedroomBtn.mas_right).offset(-5);
            make.top.equalTo(self.bedroomBtn.mas_top).offset(5);
    }];
    
    //添加卫生间lbl
    [self.bathroomBtn addSubview:self.bathroomLbl];
    
    //设置自动布局
    [self.bathroomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bathroomBtn.mas_left).offset(5);
            make.top.equalTo(self.bathroomBtn.mas_top).offset(5);
    }];
    
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
    
    
    
    
   
}

# pragma mark - 懒加载

- (UILabel *)kitchenLbl{
    if(!_kitchenLbl){
        _kitchenLbl = [UILabel new];
        //富文本设置（大小，居中）
        NSString *kitchenLblText = @"厨房";
        NSMutableParagraphStyle *kitchenLblParagraphStyle = [NSMutableParagraphStyle new];
        kitchenLblParagraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *kitchenLblAttrString = [[NSMutableAttributedString alloc] initWithString:kitchenLblText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSParagraphStyleAttributeName : kitchenLblParagraphStyle, NSForegroundColorAttributeName : myColorDarkGreen}];
        _kitchenLbl.attributedText = kitchenLblAttrString;
    }
    return _kitchenLbl;
}

- (UILabel *)livingroomLbl{
    if(!_livingroomLbl){
        _livingroomLbl = [UILabel new];
        //富文本设置（大小，居中）
        NSString *livingroomLblText = @"客厅";
        NSMutableParagraphStyle *livingroomLblParagraphStyle = [NSMutableParagraphStyle new];
        livingroomLblParagraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *livingroomLblAttrString = [[NSMutableAttributedString alloc] initWithString:livingroomLblText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSParagraphStyleAttributeName : livingroomLblParagraphStyle, NSForegroundColorAttributeName : myColorDarkGreen}];
        _livingroomLbl.attributedText = livingroomLblAttrString;
    }
    return _livingroomLbl;
}

- (UILabel *)bedroomLbl{
    if(!_bedroomLbl){
        _bedroomLbl = [UILabel new];
        //富文本设置（大小，居中）
        NSString *bedroomLblText = @"卧室";
        NSMutableParagraphStyle *bedroomLblParagraphStyle = [NSMutableParagraphStyle new];
        bedroomLblParagraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *bedroomLblAttrString = [[NSMutableAttributedString alloc] initWithString:bedroomLblText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSParagraphStyleAttributeName : bedroomLblParagraphStyle, NSForegroundColorAttributeName : myColorDarkGreen}];
        _bedroomLbl.attributedText = bedroomLblAttrString;
    }
    return _bedroomLbl;
}

- (UILabel *)bathroomLbl{
    if(!_bathroomLbl){
        _bathroomLbl = [UILabel new];
        //富文本设置（大小，居中）
        NSString *bathroomLblText = @"卫生间";
        NSMutableParagraphStyle *bathroomLblParagraphStyle = [NSMutableParagraphStyle new];
        bathroomLblParagraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *bathroomLblAttrString = [[NSMutableAttributedString alloc] initWithString:bathroomLblText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSParagraphStyleAttributeName : bathroomLblParagraphStyle, NSForegroundColorAttributeName : myColorDarkGreen}];
        _bathroomLbl.attributedText = bathroomLblAttrString;
    }
    return _bathroomLbl;
}

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
