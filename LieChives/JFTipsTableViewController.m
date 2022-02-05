//
//  JFTipsTableViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/1/31.
//

#import "JFTipsTableViewController.h"
#import "JFTips.h"

@interface JFTipsTableViewController ()
///从Tips.plist加载的模型数组
@property (nonatomic, strong) NSArray *tips;


@end

@implementation JFTipsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.tips);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

#pragma mark - 懒加载数据
- (NSArray *)tips{
    if(_tips == nil){
        //找到plist路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Tips.plist" ofType:nil];
        //加载plist文件
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        //字典转模型
        NSMutableArray *arrayModel = [NSMutableArray array];
        //遍历字典组中的每个字典,把每个字典转成模型,把模型放到 arrayModel数组中
        for (NSDictionary *dic in arrayDict) {
            //创建模型对象
            JFTips *model = [JFTips tipsWithDict:dic];
            [arrayModel addObject:model];
        }
        _tips = arrayModel;
    }
    return _tips;
}

@end
