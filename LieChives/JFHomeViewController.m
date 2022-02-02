//
//  JFHomeViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/1/31.
//

#import "JFHomeViewController.h"

#import "JFPresentTimeBackgroundView.h"
#import "JFRoomsBackgroundView.h"
@interface JFHomeViewController ()

///大的presentTimeBackgroundView里面有两个View，两个View里面再有其他控件
@property (nonatomic, strong) JFPresentTimeBackgroundView *presentTimeBackgroundView;

///厨房客厅卫生间卧室按钮的容器view
@property (nonatomic, strong) JFRoomsBackgroundView *roomsBackgroundView;




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
    //测试自动布局 颜色设置
    self.presentTimeBackgroundView.backgroundColor = [UIColor grayColor];
    
    //添加子视图
    [self.view addSubview:self.presentTimeBackgroundView];
    
    //设置自动布局
    [self.presentTimeBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(160);
            make.top.mas_equalTo(self.view.mas_top).offset(100);
    }];
    
    //厨房客厅卫生间卧室按钮的容器view
    //测试自动布局 颜色设置
    self.roomsBackgroundView.backgroundColor = myColorDarkGreen;
    
    //添加子视图
    [self.view addSubview:self.roomsBackgroundView];
    
    //设置自动布局
    [self.roomsBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
        //3是房间按钮内部距离
        //4        外部
            make.width.mas_equalTo(320 + 4 * 2 + 3);
            make.height.mas_equalTo(180 * 2 + 4 * 2 + 3);
            make.top.equalTo(self.presentTimeBackgroundView.mas_bottom).offset(50);
    }];

}

# pragma mark - 懒加载
- (JFRoomsBackgroundView *)roomsBackgroundView{
    if(!_roomsBackgroundView){
        _roomsBackgroundView = [JFRoomsBackgroundView new];
    }
    return _roomsBackgroundView;
}

- (JFPresentTimeBackgroundView *)presentTimeBackgroundView{
    if(!_presentTimeBackgroundView){
        _presentTimeBackgroundView = [JFPresentTimeBackgroundView new];
    }
    return _presentTimeBackgroundView;
}


- (void)kitchenBtnClick:(UIButton *)kitchenBtn{
    NSLog(@"点了厨房");
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
