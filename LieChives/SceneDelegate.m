//
//  SceneDelegate.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/1/31.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "JFHomeViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    //取消了默认配置文件window 就变成了nil 这里做一个验证
    if (self.window == nil) {
        NSLog(@"window => nil");
            }
    
    //这里给需要用到的 win scene 改个名,并把它强转UIWindowScene（UIScene的子类）
            UIWindowScene *windowScene = (UIWindowScene *)scene;
    // 实例化新的 window 视图窗口 => uiwindow 本质是个 uiview 而已
    // 另外这里需要关联当前系统给到的场景 windowScene
        UIWindow *newWindow = [[UIWindow alloc] initWithWindowScene:windowScene];
    //设置newWindow大小
        newWindow.frame = windowScene.coordinateSpace.bounds;
    //自定义初始化VC
        JFHomeViewController *homeViewCntroller = [JFHomeViewController new];
    //test-----颜色测试（用完注释）
        homeViewCntroller.view.backgroundColor = [UIColor greenColor];
    //替换VC
        newWindow.rootViewController = homeViewCntroller;
    //显示newWindow
        [newWindow makeKeyAndVisible];
    //替换系统window
        self.window = newWindow;
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}


@end
