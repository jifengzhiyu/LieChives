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
@property (nonatomic, strong) NSArray *tipsArr;


@end

@implementation JFTipsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.tipsArr);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tipsArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JFTips *tip = self.tipsArr[section];
    return tip.tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"tipsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    // 1. 获取模型数据
    // 根据组的索引获取对应的组的模型
    JFTips *tip = self.tipsArr[indexPath.section];
    // 根据当前行的索引, 获取对应组的对应行的车
    NSString *tipText = tip.tips[indexPath.row];
    
    cell.textLabel.text = tipText;
    
    
    return cell;
}

// 设置组标题的数据源方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 根据组的索引获取对应的组的模型
    JFTips *tip = self.tipsArr[section];
    return tip.title;
}

#pragma mark - 懒加载数据
- (NSArray *)tipsArr{
    if(_tipsArr == nil){
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
        _tipsArr = arrayModel;
    }
    return _tipsArr;
}

@end
