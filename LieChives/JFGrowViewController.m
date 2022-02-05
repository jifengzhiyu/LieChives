//
//  JFGrowViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/1.
//

#import "JFGrowViewController.h"
#import "JFGrowNormalView.h"
@interface JFGrowViewController ()

@property (nonatomic, strong) JFGrowNormalView *growNormalView;

@end

@implementation JFGrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubViews];
    
    self.growNormalView.inputText = @"娃娃腻腻歪歪哇哇哇哇哇哇";


}

- (void)setupSubViews{
    //添加子视图
    [self.view addSubview:self.growNormalView];
    
    //设置自动布局
    [self.growNormalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.view.mas_top).offset(100);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(80);
    }];
}


# pragma mark - 懒加载
- (JFGrowNormalView *)growNormalView{
    if(!_growNormalView){
        _growNormalView = [JFGrowNormalView new];
    }

    return _growNormalView;
}



@end
