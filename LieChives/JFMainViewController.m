//
//  JFMainViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/1/31.
//
#import "JFHomeViewController.h"
#import "JFMainViewController.h"
#import "JFTipsTableViewController.h"
#import "JFGrowViewController.h"
#import "JFSettingTableViewController.h"

@interface JFMainViewController ()<UITabBarControllerDelegate>

@end

@implementation JFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor systemGreenColor];
    self.delegate = self.delegate;
    
    [self addChildViewControllers];
    
    
    
}


///创建自控制器（标题，item图片 文字）
- (void)addChildViewControllers{
    [self addChildViewController:[JFHomeViewController new] andTitle:@"主页" andImageName:@"home"];
    [self addChildViewController:[JFTipsTableViewController new] andTitle:@"提示" andImageName:@"tips"];
    [self addChildViewController:[JFGrowViewController new] andTitle:@"成长" andImageName:@"grow"];
    [self addChildViewController:[JFSettingTableViewController new] andTitle:@"设置" andImageName:@"setting"];

}

- (void)addChildViewController:(UIViewController *)viewController andTitle:(NSString *)title andImageName:(NSString *)imageName{
    
    viewController.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@_tabBarItem_nomal",imageName]];
    viewController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
    
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"选中%@",item.title);
}
@end
