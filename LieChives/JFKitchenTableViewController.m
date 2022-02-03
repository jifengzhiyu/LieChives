//
//  JFKitchenTableViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/2.
//

#import "JFKitchenTableViewController.h"
#import "Kitchen+CoreDataClass.h"
@interface JFKitchenTableViewController ()
@property (nonatomic, strong) Kitchen *kitchen;
@property (nonatomic, copy) NSArray *kitchenPartArr;

@end

@implementation JFKitchenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"厨房";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initKitchenData];
    
    [self fetchKitchenData];
    
}

- (void)fetchKitchenData{
    //查询请求
    NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
    
    //设置一些参数
    //实体
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Kitchen" inManagedObjectContext:[JFCoreDataManager sharedManager].managerContext];
    //设置实体
    fetchrequest.entity = entity;
    
//    //谓词   有点像SQL语句中的 where
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"age = %@",@"26"];
//    //设置一下
//    fetchrequest.predicate = pre;
    
    //排序
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    //设置排序
//    fetchrequest.sortDescriptors = @[sort];
    
    //执行查询请求
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:fetchrequest error:nil];
    
    //打印结果集
    for (Kitchen *kitchen  in temp) {
        NSLog(@"%d--%d---%d---%d 一共有多少个记录%lu",kitchen.gongZuoTai,kitchen.zaoTai,kitchen.chuGui,kitchen.shuiChi,temp.count);
    }
}

- (void)initKitchenData{
    //通过实体描述描述出实体对象
  Kitchen *kitchen = [NSEntityDescription insertNewObjectForEntityForName:@"Kitchen" inManagedObjectContext:[JFCoreDataManager sharedManager].managerContext];
    
    //数据存储插入操作  KVC
    kitchen.gongZuoTai = self.kitchen.gongZuoTai;
    kitchen.zaoTai = self.kitchen.zaoTai;
    kitchen.chuGui = self.kitchen.chuGui;
    kitchen.shuiChi = self.kitchen.shuiChi;
    
    
    //通过上下文进行提交存储
    [[JFCoreDataManager sharedManager].managerContext save:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    static NSString * identifier = @"kitchenCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.kitchenPartArr[indexPath.row];
    cell.tintColor = [UIColor systemGreenColor];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    return cell;
}

- (NSArray *)kitchenPartArr{
    if(!_kitchenPartArr){
        _kitchenPartArr = @[@"橱柜", @"工作台", @"水池", @"灶台"];
    }
    return _kitchenPartArr;
}

// 点击 cell 调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"选中 cell----> %@",cell.textLabel.text);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
