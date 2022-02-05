//
//  JFPresentTimeBackgroundView.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/2.
//

#import "JFPresentTimeBackgroundView.h"
@interface JFPresentTimeBackgroundView()
///时间view容纳器
@property (nonatomic, strong) UIView *presentTimeView;
///日 label
@property (nonatomic, strong) UILabel *dateLbl;
///月 年 label
@property (nonatomic, strong) UILabel *monthYearLbl;
///次数容纳器
@property (nonatomic, strong) UIView *timesView;
///次数 label
@property (nonatomic, strong) UILabel *overTimesLbl;
///当前时间数组
@property (nonatomic, strong) NSArray *presentArr;



@end

@implementation JFPresentTimeBackgroundView

# pragma mark - initWithFrame（设置控件）
- (instancetype)initWithFrame:(CGRect)frame{
    //初始化
    self = [super initWithFrame:frame];
    //设置子控件
    [self setupSubViews];
    
    return self;
}


- (void)setupSubViews{
    //添加时间容器view
    [self addSubview:self.presentTimeView];
    
    //设置自动布局
    [self.presentTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(160);
        
    }];
    
    //添加时间容器view子控件
    [self setupPresentTimeSubView];
    
    //添加次数容器view
    [self addSubview:self.timesView];
    
    //设置自动布局
    [self.timesView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(160);
        
    }];
    
    //添加次数容器view子控件
    [self setupTimesView];
}

- (void)setupPresentTimeSubView{
    //添加控件
    [self.presentTimeView addSubview:self.dateLbl];
    [self.presentTimeView addSubview:self.monthYearLbl];
    
    //设置布局
    [self.dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.centerX.equalTo(_presentTimeView.mas_centerX);
            make.top.mas_equalTo(20);
            
    }];
    
    [self.monthYearLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.centerX.equalTo(_presentTimeView.mas_centerX);
            make.top.mas_equalTo(_dateLbl.mas_bottom).offset(5);
            
    }];
}

- (void)setupTimesView{
    //添加控件
    [self addSubview:self.overTimesLbl];
    
    //设置布局
    [self.overTimesLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_timesView.mas_centerX);
            make.centerY.equalTo(_timesView.mas_centerY);
            
    }];

}

# pragma mark - 懒加载
///当前时间数组
- (NSArray *)presentArr{
    if(!_presentArr){
        _presentArr = [NSArray array];
        
        //获取现在时间
        NSDate *presentDate = [NSDate date];
        // 创建一个时间格式化对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"YYYY:MM:dd"];
    //    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_CN"];
        NSString *presentDateString = [dateFormatter stringFromDate:presentDate];
        _presentArr = [presentDateString componentsSeparatedByString:@":"];
    //    NSLog(@"%@",presentArr);
    }
    return _presentArr;
}

////时间view容纳器
- (UIView *)presentTimeView{
    if(!_presentTimeView){
        _presentTimeView = [UIView new];
        _presentTimeView.backgroundColor = myColorLightGreen;

    }
    return _presentTimeView;
}

///日 label
- (UILabel *)dateLbl{
    if(!_dateLbl){
        _dateLbl = [UILabel new];
        //富文本设置
        NSMutableParagraphStyle *dateParagraphStyle = [NSMutableParagraphStyle new];
        dateParagraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *dateAttrString = [[NSMutableAttributedString alloc] initWithString:self.presentArr[2] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:70], NSParagraphStyleAttributeName : dateParagraphStyle}];
        _dateLbl.attributedText = dateAttrString;
    }
    return _dateLbl;
}

///月 年 label
- (UILabel *)monthYearLbl{
    if(!_monthYearLbl){
        _monthYearLbl = [UILabel new];
        NSString *monthYearText = [NSString stringWithFormat:@"%@月%@年",self.presentArr[1],self.presentArr[0]];
        //富文本设置（大小，居中）
        NSMutableParagraphStyle *monthYearParagraphStyle = [NSMutableParagraphStyle new];
        monthYearParagraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *monthYearAttrString = [[NSMutableAttributedString alloc] initWithString:monthYearText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSParagraphStyleAttributeName : monthYearParagraphStyle}];
        _monthYearLbl.attributedText = monthYearAttrString;
    }
    return _monthYearLbl;
}

///次数容纳器
- (UIView *)timesView{
    if(!_timesView){
        _timesView = [UIView new];
        _timesView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
    }
    return _timesView;
}

///次数 label
- (UILabel *)overTimesLbl{
    if(!_overTimesLbl){
        _overTimesLbl = [UILabel new];
        NSString *overTimesText = @"999次";
        //富文本设置（大小，居中）
        NSMutableParagraphStyle *overTimesParagraphStyle = [NSMutableParagraphStyle new];
        overTimesParagraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *overTimesAttrString = [[NSMutableAttributedString alloc] initWithString:overTimesText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:50], NSParagraphStyleAttributeName : overTimesParagraphStyle}];
        _overTimesLbl.attributedText = overTimesAttrString;
    }
    return _overTimesLbl;
}

@end
