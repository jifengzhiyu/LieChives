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
///kitchenPartArr记录cell的cell.textLabel.text
@property (nonatomic, copy) NSArray *kitchenPartArr;
///记录是否做了
@property (nonatomic, assign) BOOL isChecked;

@property (nonatomic, assign) NSIndexPath *currentIndex;


@end

@implementation JFKitchenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"厨房";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [self initKitchenData];
    
//    [self upDateKichenData];
    
    [self fetchKitchenData];
    
    
}

- (void)upDateKichenData{
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Kitchen fetchRequest] error:nil];

    for (Kitchen *kitchen  in temp) {
        kitchen.gongZuoTai = @(1);
        kitchen.zaoTai = @(1);
        kitchen.chuGui = @(1);
        kitchen.shuiChi = @(1);
        NSLog(@"%@--%@---%@---%@ 更新-----》一共有多少个记录%lu",kitchen.gongZuoTai,kitchen.zaoTai,kitchen.chuGui,kitchen.shuiChi,temp.count);
    }
}

- (void)fetchKitchenData{
//    //查询请求
//    NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
//
//    //设置一些参数
//    //实体
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Kitchen" inManagedObjectContext:[JFCoreDataManager sharedManager].managerContext];
//    //设置实体
//    fetchrequest.entity = entity;
    
//    //谓词   有点像SQL语句中的 where
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"age = %@",@"26"];
//    //设置一下
//    fetchrequest.predicate = pre;
    
    //排序
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    //设置排序
//    fetchrequest.sortDescriptors = @[sort];
    
    //执行查询请求
//    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:fetchrequest error:nil];
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Kitchen fetchRequest] error:nil];

    
    //打印结果集
    for (Kitchen *kitchen  in temp) {
        NSLog(@"%@--%@---%@---%@ 一共有多少个记录%lu",kitchen.gongZuoTai,kitchen.zaoTai,kitchen.chuGui,kitchen.shuiChi,temp.count);
    }
}

- (void)initKitchenData{
    //通过实体描述描述出实体对象
  Kitchen *kitchen = [NSEntityDescription insertNewObjectForEntityForName:@"Kitchen" inManagedObjectContext:[JFCoreDataManager sharedManager].managerContext];
    
    //数据存储插入操作  KVC
//    kitchen.gongZuoTai = self.kitchen.gongZuoTai;
//    kitchen.zaoTai = self.kitchen.zaoTai;
//    kitchen.chuGui = self.kitchen.chuGui;
//    kitchen.shuiChi = self.kitchen.shuiChi;
    kitchen.gongZuoTai = @(0);
    kitchen.zaoTai = @(0);
    kitchen.chuGui = @(0);
    kitchen.shuiChi = @(0);
    
    
    //通过上下文进行提交存储
    [[JFCoreDataManager sharedManager].managerContext save:nil];
}

#pragma mark - cell的数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    static NSString * identifier = @"kitchenCell";
    JFRoomsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[JFRoomsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置cell的文字
    cell.textLabel.text = self.kitchenPartArr[indexPath.row];
    //设置cell的渲染颜色
    cell.tintColor = [UIColor systemGreenColor];
    
    //打对勾了缓存了，就打对勾
//    if(cell.isChecked == YES){
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    cell.accessoryType = UITableViewCellAccessoryNone;
//
//    if(self.currentIndex == indexPath && self.currentIndex != nil){
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    
    
//    if([cell.textLabel.text  isEqual: @"橱柜"]){
//        if(self.kitchen.chuGui == nil || [self.kitchen.chuGui  isEqual: @0]){
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        NSLog(@"橱柜---load");
//    }else if ([cell.textLabel.text  isEqual: @"工作台"]){
////        self.kitchen.gongZuoTai = !self.kitchen.gongZuoTai;
//        if(self.kitchen.gongZuoTai == nil || [self.kitchen.gongZuoTai  isEqual: @0]){
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        NSLog(@"工作台---load");
//    }else if ([cell.textLabel.text  isEqual: @"水池"]){
////        self.kitchen.shuiChi = !self.kitchen.shuiChi;
//        if(self.kitchen.shuiChi == nil || [self.kitchen.shuiChi  isEqual: @0]){
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        NSLog(@"水池---load");
//    }else if ([cell.textLabel.text  isEqual: @"灶台"]){
////        self.kitchen.zaoTai = !self.kitchen.zaoTai;
//        if(self.kitchen.zaoTai == nil || [self.kitchen.zaoTai  isEqual: @0]){
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        NSLog(@"灶台---load");
//    }
    return cell;
}

#pragma mark - 懒加载

- (NSArray *)kitchenPartArr{
    if(!_kitchenPartArr){
        _kitchenPartArr = @[@"橱柜", @"工作台", @"水池", @"灶台"];
    }
    return _kitchenPartArr;
}

- (Kitchen *)kitchen{
    if(!_kitchen){
        _kitchen = [Kitchen new];
//        _kitchen.chuGui = [NSNumber numberWithInteger:0];
//        _kitchen.gongZuoTai = @0;
//        _kitchen.shuiChi = @0;
//        _kitchen.zaoTai = @0;

    }
    return _kitchen;
}

#pragma mark - 点击cell

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        JFRoomsTableViewCell *cell = (JFRoomsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if([cell.textLabel.text  isEqual: @"橱柜"]){
        if(self.kitchen.chuGui == nil || [self.kitchen.chuGui  isEqual: @0]){
        self.kitchen.chuGui = @1;
        }else{
            self.kitchen.chuGui = @0;
        }
        NSLog(@"橱柜");
    }else if ([cell.textLabel.text  isEqual: @"工作台"]){
        if(self.kitchen.gongZuoTai == nil || [self.kitchen.gongZuoTai  isEqual: @0]){
        self.kitchen.gongZuoTai = @1;
        }else{
            self.kitchen.gongZuoTai = @0;
        }
        NSLog(@"工作台");
    }else if ([cell.textLabel.text  isEqual: @"水池"]){
        if(self.kitchen.shuiChi == nil || [self.kitchen.shuiChi  isEqual: @0]){
        self.kitchen.shuiChi = @1;
        }else{
            self.kitchen.shuiChi = @0;
        }
        NSLog(@"水池");
    }else if ([cell.textLabel.text  isEqual: @"灶台"]){
        if(self.kitchen.zaoTai == nil || [self.kitchen.zaoTai  isEqual: @0]){
        self.kitchen.zaoTai = @1;
        }else{
            self.kitchen.zaoTai = @0;
        }
        NSLog(@"灶台");
    }
        

//    self.currentIndex = indexPath;
    [self.tableView reloadData];
}

// 点击 cell 调用
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSIndexPath *oldIndex = [tableView indexPathForSelectedRow];
//    [tableView cellForRowAtIndexPath:oldIndex].accessoryType = UITableViewCellAccessoryNone;
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//
//    JFRoomsTableViewCell *cell = (JFRoomsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//
////    if(cell.isChecked == YES){
////        cell.isChecked = NO;
////    }else{
////        cell.isChecked = YES;
////    }
////    if(cell.accessoryType == UITableViewCellAccessoryNone){
////        cell.accessoryType = UITableViewCellAccessoryCheckmark;
////    }else{
////        cell.accessoryType = UITableViewCellAccessoryNone;
////
////    }
//    NSLog(@"选中 cell----> %@",cell.textLabel.text);
////    [self.tableView reloadData];
//}



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
