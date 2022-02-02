//
//  JFHomeViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/1/31.
//

#import "JFHomeViewController.h"

#import "JFPresentTimeBackgroundView.h"
@interface JFHomeViewController ()

//大的presentTimeBackgroundView里面有两个View，两个View里面再有其他控件
@property (nonatomic, strong) JFPresentTimeBackgroundView *presentTimeBackgroundView;




@end

@implementation JFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置JFHomeViewController 的子视图
    [self setupSubViews];
    
    
}


# pragma mark - 设置界面
- (void)setupSubViews{
    
    //大的presentTimeBackgroundView里面有两个View，两个View里面再有其他控件
    //测试布局 颜色设置
    self.presentTimeBackgroundView.backgroundColor = [UIColor grayColor];
    
    //添加子视图
    [self.view addSubview:self.presentTimeBackgroundView];
    
    //设置布局
    [self.presentTimeBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(160);
            make.top.mas_equalTo(self.view.mas_top).offset(100);
    }];
    
    
}

# pragma mark - 懒加载
- (JFPresentTimeBackgroundView *)presentTimeBackgroundView{
    if(!_presentTimeBackgroundView){
        _presentTimeBackgroundView = [JFPresentTimeBackgroundView new];
    }
    return _presentTimeBackgroundView;
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
