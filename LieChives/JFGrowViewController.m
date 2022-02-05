//
//  JFGrowViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/1.
//

#import "JFGrowViewController.h"
#import "JFGrowNormalView.h"

#import "JFGrowNormalView.h"
@interface JFGrowViewController ()
///已经坚持的天数View
@property (nonatomic, strong) JFGrowNormalView *dayCountView;
///本轮还剩View
@property (nonatomic, strong) JFGrowNormalView *leftCountView;
///完成次数View
@property (nonatomic, strong) JFGrowNormalView *finishedCountView;

///进度条
@property (nonatomic, strong) UIProgressView *progressView;





@end

@implementation JFGrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubViews];
    
//    NSString* myStr = @"娃娃腻腻歪";
//    //富文本设置（大小，居中）
//            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//            paragraphStyle.alignment = NSTextAlignmentCenter;
//            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:myStr attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:25], NSParagraphStyleAttributeName : paragraphStyle}];
//    self.growNormalView.growNormalViewLbl.attributedText = attrString;
    
    self.progressView.progress = 0.7;
}

- (void)setupSubViews{
    //添加子视图
    [self.view addSubview:self.dayCountView];
    [self.view addSubview:self.finishedCountView];
    [self.view addSubview:self.leftCountView];
    [self.view addSubview:self.progressView];


    //设置自动布局
    [self.dayCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.view.mas_top).offset(100);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(80);
    }];
    
    [self.finishedCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.dayCountView.mas_bottom).offset(50);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(80);
    }];
    
    [self.leftCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.finishedCountView.mas_bottom).offset(50);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(80);
    }];
    
    //设置进度条布局，给一个负的y距离
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.leftCountView.mas_bottom).offset(-10);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(5);
    }];
    
}


# pragma mark - 懒加载

- (UIProgressView *)progressView{
    if(!_progressView){
        _progressView = [UIProgressView new];
        _progressView.tintColor = [UIColor systemGreenColor];
    }
    return _progressView;
}

- (JFGrowNormalView *)dayCountView{
    if(!_dayCountView){
        _dayCountView = [JFGrowNormalView new];
    }
    return _dayCountView;
}

- (JFGrowNormalView *)leftCountView{
    if(!_leftCountView){
        _leftCountView = [JFGrowNormalView new];
    }
    return _leftCountView;
}

- (JFGrowNormalView *)finishedCountView{
    if(!_finishedCountView){
        _finishedCountView = [JFGrowNormalView new];
    }
    return _finishedCountView;
}



@end
