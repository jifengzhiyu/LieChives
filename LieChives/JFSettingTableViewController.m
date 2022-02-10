//
//  JFSettingTableViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/1.
//

#import "JFSettingTableViewController.h"
#import <StoreKit/StoreKit.h>
@interface JFSettingTableViewController ()

@end

@implementation JFSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0){
    static NSString * identifier = @"versionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
       
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"当前版本";
    cell.detailTextLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        cell.userInteractionEnabled = NO;
    
    return cell;
    }else if(indexPath.row == 1){
        static NSString * identifier = @"settingCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

        }
        cell.textLabel.text = @"去评分";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        return cell;
    }else{
        static NSString * identifier = @"settingCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = @"版本更新";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
}

#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1){
    
        //弹出评分
        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
            [SKStoreReviewController requestReviewInScene:self.view.window.windowScene];
        }

        
    }else if (indexPath.row == 2){
        [self requestAppVersion];
    }
}

#pragma mark - 查看更新
/// 请求接口
- (void)requestAppVersion {
    NSString *url = @"https://itunes.apple.com/cn/lookup?bundleId=com.jifengzhiyu-github.www.LieChives";
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [manager POST:url parameters:@{} headers:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *results = [responseObject objectForKey:@"results"];
            NSDictionary *resultDic = results.firstObject;
            if (resultDic) {
                [self judgeIfNeedUpdate:resultDic];//判断是否有新的版本
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
}

/// 判断是否有新的版本
- (void)judgeIfNeedUpdate:(NSDictionary *)resultDic {
    //苹果商店版本号
    NSString *remoteVersion = [resultDic objectForKey:@"version"];
    NSArray *remoteArray = [remoteVersion componentsSeparatedByString:@"."];
    //本地版本号
    NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
    
    //版本比较：要分三位依次比较。如果只是单纯的去掉版本号中"."再两者直接比较，有些情况下结果是错的，例如1.1.0(110)和1.0.10(1010)会得出后者大于前者的错误结果。
    BOOL ifNeedUpdate = NO;//是否需要更新版本，默认NO
    if (remoteArray.count >= 3 && localArray.count >= 3) {
        //比较第一位
        if ([remoteArray[0] integerValue] > [localArray[0] integerValue]) {
            ifNeedUpdate = YES;
            
        //第一位相同，比较第二位
        }else if ([remoteArray[0] integerValue] == [localArray[0] integerValue] && [remoteArray[1] integerValue] > [localArray[1] integerValue]) {
            ifNeedUpdate = YES;
            
        //第一、二位相同，比较第三位
        }else if ([remoteArray[0] integerValue] == [localArray[0] integerValue] && [remoteArray[1] integerValue] == [localArray[1] integerValue] && [remoteArray[2] integerValue] > [localArray[2] integerValue]) {
            ifNeedUpdate = YES;
        }
    }
    
    //提示用户有新版本更新，点击确认后跳转苹果商店
    if (ifNeedUpdate == YES) {
        NSString *releaseNotes = resultDic[@"releaseNotes"];//更新内容
        NSString *message = [NSString stringWithFormat:@"您有新的版本更新，更新内容：%@\n是否现在去下载?", releaseNotes];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSString *downLoadUrl = [resultDic objectForKey:@"trackViewUrl"];//应用程序下载网址
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadUrl] options:@{} completionHandler:nil];//跳转苹果商店
        }]];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
}




@end
