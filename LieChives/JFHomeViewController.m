//
//  JFHomeViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/1/31.
//

#import "JFHomeViewController.h"

#import "JFPresentTimeBackgroundView.h"
#import "JFRoomsBackgroundView.h"

#import "JFKitchenTableViewController.h"
#import "JFLivingroomTableViewController.h"
#import "JFBedroomTableViewController.h"
#import "JFBathroomTableViewController.h"
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
    
    [self addRoomsBtnClick];

}

///添加房间按钮的监听方法
- (void)addRoomsBtnClick{
    
    [self.roomsBackgroundView.kitchenBtn addTarget:self action:@selector(kitchenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.roomsBackgroundView.livingroomBtn addTarget:self action:@selector(livingroomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.roomsBackgroundView.bedroomBtn addTarget:self action:@selector(bedroomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.roomsBackgroundView.bathroomBtn addTarget:self action:@selector(bathroomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

# pragma mark - 点击事件
- (void)kitchenBtnClick:(UIButton *)kitchenBtn{
    NSLog(@"点了厨房");
    [self.navigationController pushViewController:[JFKitchenTableViewController new] animated:YES];
}

- (void)livingroomBtnClick:(UIButton *)livingroomBtn{
    NSLog(@"点了客厅");
    [self.navigationController pushViewController:[JFLivingroomTableViewController new] animated:YES];

}

- (void)bedroomBtnClick:(UIButton *)bedroomBtn{
    NSLog(@"点了卧室");
    [self.navigationController pushViewController:[JFBedroomTableViewController new] animated:YES];

}

- (void)bathroomBtnClick:(UIButton *)bathroomBtn{
    NSLog(@"点了卫生间");
    [self.navigationController pushViewController:[JFBathroomTableViewController new] animated:YES];

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


@end
