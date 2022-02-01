//
//  JFHomeViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/1/31.
//

#import "JFHomeViewController.h"
#import "Masonry.h"
@interface JFHomeViewController ()

@end

@implementation JFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubViews];
    
    
}

- (void)setupSubViews{
    //大的presentTimeBackgroundView里面有两个View，两个View里面再有其他控件
    UIView *presentTimeBackgroundView = [UIView new];
    presentTimeBackgroundView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:presentTimeBackgroundView];
    [presentTimeBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(160);
            make.top.mas_equalTo(self.view.mas_top).offset(100);
    }];
    

    //时间view容纳器
    UIView *presentTimeView = [UIView new];
    presentTimeView.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:251 / 255.0 blue:226 / 255.0 alpha:1];
    
    [presentTimeBackgroundView addSubview:presentTimeView];
    [presentTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(presentTimeBackgroundView.mas_left);
        make.top.equalTo(presentTimeBackgroundView.mas_top);
        make.bottom.equalTo(presentTimeBackgroundView.mas_bottom);
        make.width.mas_equalTo(160);
        
    }];
    
    //日期
    //日
    UILabel *dateLbl = [UILabel new];
    NSString *dateText = @"31";
    
    //富文本设置
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:dateText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:70]}];
    dateLbl.attributedText = attrString;
    
    [presentTimeView addSubview:dateLbl];
    [dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.centerX.equalTo(presentTimeView.mas_centerX);
            make.top.mas_equalTo(20);
            
    }];
    
    //次数容纳器
    UIView *TimesView = [UIView new];
    TimesView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
    
    [presentTimeBackgroundView addSubview:TimesView];
    [TimesView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(presentTimeBackgroundView.mas_right);
        make.top.equalTo(presentTimeBackgroundView.mas_top);
        make.bottom.equalTo(presentTimeBackgroundView.mas_bottom);
        make.width.mas_equalTo(160);
        
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
