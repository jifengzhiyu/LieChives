//
//  JFLivingroomTableViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/2.
//

#import "JFLivingroomTableViewController.h"
#import "Livingroom+CoreDataClass.h"
@interface JFLivingroomTableViewController ()
@property (nonatomic, strong) Livingroom *livingroom;

///livingroomPartArr记录cell的cell.textLabel.text
@property (nonatomic, copy) NSArray *livingroomPartArr;

@end

@implementation JFLivingroomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"客厅";

    //如果没有创建数据库就创建（一次性初始化）
    [self initLivingroomData];
    
}

///如果没有创建数据库就创建（一次性初始化）
- (void)initLivingroomData{
    //先获取一下
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Livingroom fetchRequest] error:nil];
    if(temp.count == 0){

    //通过实体描述描述出实体对象
  Livingroom *livingroom = [NSEntityDescription insertNewObjectForEntityForName:@"Livingroom" inManagedObjectContext:[JFCoreDataManager sharedManager].managerContext];
    
    //数据存储插入操作  KVC
    //初始化数据库元素
    livingroom.bingXiang = @(0);
    livingroom.canZhuo = @(0);
    livingroom.chaJi = @(0);
    livingroom.chuWuGui = @(0);
    livingroom.dianShiGui = @(0);
    livingroom.qiangBi = @(0);
    livingroom.shaFa = @(0);
    livingroom.shuGui = @(0);
    livingroom.xieGui = @(0);
        
    livingroom.finishedCount = @(0);
    
    //通过上下文进行提交存储
    [[JFCoreDataManager sharedManager].managerContext save:nil];
    }else{
        return;
    }
}

#pragma mark - cell的数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    static NSString * identifier = @"livingroomCell";
    JFRoomsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[JFRoomsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置cell的文字
    cell.textLabel.text = self.livingroomPartArr[indexPath.row];
    //设置cell的渲染颜色
    cell.tintColor = [UIColor systemGreenColor];
    
    //打对勾了缓存了，就打对勾
    if([cell.textLabel.text  isEqual: @"沙发"]){
        if(self.livingroom.shaFa == nil || [self.livingroom.shaFa  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"沙发---load");
    }else if ([cell.textLabel.text  isEqual: @"书柜"]){
        if(self.livingroom.shuGui == nil || [self.livingroom.shuGui  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"书柜---load");
    }else if ([cell.textLabel.text  isEqual: @"电视柜"]){
        if(self.livingroom.dianShiGui == nil || [self.livingroom.dianShiGui  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"电视柜---load");
    }else if ([cell.textLabel.text  isEqual: @"冰箱"]){
        if(self.livingroom.bingXiang == nil || [self.livingroom.bingXiang  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"冰箱---load");
    }else if ([cell.textLabel.text  isEqual: @"餐桌"]){
        if(self.livingroom.canZhuo == nil || [self.livingroom.canZhuo  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"餐桌---load");
    }else if ([cell.textLabel.text  isEqual: @"墙壁"]){
        if(self.livingroom.qiangBi == nil || [self.livingroom.qiangBi  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"墙壁---load");
    }else if ([cell.textLabel.text  isEqual: @"鞋柜"]){
        if(self.livingroom.xieGui == nil || [self.livingroom.xieGui isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"鞋柜---load");
    }else if ([cell.textLabel.text  isEqual: @"储物柜"]){
        if(self.livingroom.chuWuGui == nil || [self.livingroom.chuWuGui  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"储物柜---load");
    }else if ([cell.textLabel.text  isEqual: @"茶几"]){
        if(self.livingroom.chaJi == nil || [self.livingroom.chaJi  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"茶几---load");
    }
    return cell;
}

#pragma mark - 通知
- (void)refreshView{
    [self.tableView reloadData];
}

- (instancetype)init{
    if(self = [super init]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:RefreshRoomsNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RefreshRoomsNotification object:nil];
}

#pragma mark - 懒加载

- (NSArray *)livingroomPartArr{
    if(!_livingroomPartArr){
        _livingroomPartArr = @[@"鞋柜", @"储物柜", @"沙发", @"茶几", @"电视柜", @"书柜", @"餐桌", @"冰箱", @"墙壁"];
    }
    return _livingroomPartArr;
}

- (Livingroom *)livingroom{
    if(!_livingroom){
        //获取数据
        NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Livingroom fetchRequest] error:nil];
        _livingroom = (Livingroom *)temp[0];
    }
//    NSLog(@"_livingroom --- %@",_livingroom);

    return _livingroom;
}

#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell
        JFRoomsTableViewCell *cell = (JFRoomsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if([cell.textLabel.text  isEqual: @"沙发"]){
        if(self.livingroom.shaFa == nil || [self.livingroom.shaFa  isEqual: @(0)]){
        self.livingroom.shaFa = @(1);
        }else{
            self.livingroom.shaFa = @(0);
        }
//        NSLog(@"沙发");
    }else if ([cell.textLabel.text  isEqual: @"书柜"]){
        if(self.livingroom.shuGui == nil || [self.livingroom.shuGui  isEqual: @(0)]){
        self.livingroom.shuGui = @(1);
        }else{
            self.livingroom.shuGui = @(0);
        }
//        NSLog(@"书柜");
    }else if ([cell.textLabel.text  isEqual: @"电视柜"]){
        if(self.livingroom.dianShiGui == nil || [self.livingroom.dianShiGui  isEqual: @(0)]){
        self.livingroom.dianShiGui = @(1);
        }else{
            self.livingroom.dianShiGui = @(0);
        }
//        NSLog(@"电视柜");
    }else if ([cell.textLabel.text  isEqual: @"冰箱"]){
        if(self.livingroom.bingXiang == nil || [self.livingroom.bingXiang  isEqual: @(0)]){
        self.livingroom.bingXiang = @(1);
        }else{
            self.livingroom.bingXiang = @(0);
        }
//        NSLog(@"冰箱");
    }else if ([cell.textLabel.text  isEqual: @"餐桌"]){
        if(self.livingroom.canZhuo == nil || [self.livingroom.canZhuo  isEqual: @(0)]){
        self.livingroom.canZhuo = @(1);
        }else{
            self.livingroom.canZhuo = @(0);
        }
//        NSLog(@"餐桌");
    }else if ([cell.textLabel.text  isEqual: @"墙壁"]){
        if(self.livingroom.qiangBi == nil || [self.livingroom.qiangBi  isEqual: @(0)]){
        self.livingroom.qiangBi = @(1);
        }else{
            self.livingroom.qiangBi = @(0);
        }
//        NSLog(@"墙壁");
    }else if ([cell.textLabel.text  isEqual: @"鞋柜"]){
        if(self.livingroom.xieGui == nil || [self.livingroom.xieGui  isEqual: @(0)]){
        self.livingroom.xieGui = @(1);
        }else{
            self.livingroom.xieGui = @(0);
        }
//        NSLog(@"鞋柜");
    }else if ([cell.textLabel.text  isEqual: @"储物柜"]){
        if(self.livingroom.chuWuGui == nil || [self.livingroom.chuWuGui  isEqual: @(0)]){
        self.livingroom.chuWuGui = @(1);
        }else{
            self.livingroom.chuWuGui = @(0);
        }
//        NSLog(@"chuwug");
    }else if ([cell.textLabel.text  isEqual: @"茶几"]){
        if(self.livingroom.chaJi == nil || [self.livingroom.chaJi isEqual: @(0)]){
        self.livingroom.chaJi = @(1);
        }else{
            self.livingroom.chaJi = @(0);
        }
//        NSLog(@"茶几");
    }
    
    //更新数据库
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Livingroom fetchRequest] error:nil];

    for (Livingroom *livingroom  in temp) {
//        NSLog(@"更新数据%@--%@---%@---%@ 更新 前-----》一共有多少个记录%lu",kitchen.gongZuoTai,kitchen.zaoTai,kitchen.chuGui,kitchen.shuiChi,temp.count);

        livingroom.shaFa = self.livingroom.shaFa;
        livingroom.shuGui = self.livingroom.shuGui;
        livingroom.dianShiGui = self.livingroom.dianShiGui;
        livingroom.bingXiang = self.livingroom.bingXiang;
        livingroom.canZhuo = self.livingroom.canZhuo;
        livingroom.qiangBi = self.livingroom.qiangBi;
        livingroom.xieGui = self.livingroom.xieGui;
        livingroom.chuWuGui = self.livingroom.chuWuGui;
        livingroom.chaJi = self.livingroom.chaJi;

//        NSLog(@"更新数据%@--%@---%@---%@ 更新 后-----》一共有多少个记录%lu",kitchen.gongZuoTai,kitchen.zaoTai,kitchen.chuGui,kitchen.shuiChi,temp.count);
    }
    
    //保存
    NSError *error = nil;
    if ([[JFCoreDataManager sharedManager].managerContext save:&error]) {
        NSLog(@"更新数据成功");
    }else{
        NSLog(@"更新数据失败, %@", error);
    }
        

    [self.tableView reloadData];
}

//界面即将消失
- (void)viewWillDisappear:(BOOL)animated{
    if([self.livingroom.shaFa isEqual:@(1)] &&
       [self.livingroom.shuGui isEqual:@(1)] &&
       [self.livingroom.dianShiGui isEqual:@(1)] &&
       [self.livingroom.bingXiang isEqual:@(1)] &&
       [self.livingroom.canZhuo isEqual:@(1)] &&
       [self.livingroom.qiangBi isEqual:@(1)] &&
       [self.livingroom.xieGui isEqual:@(1)] &&
       [self.livingroom.chuWuGui isEqual:@(1)] &&
       [self.livingroom.chaJi isEqual:@(1)]){
        //更新数据库
        NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Livingroom fetchRequest] error:nil];
        
        for (Livingroom *livingroom  in temp) {
            livingroom.finishedCount = @(1);
        }
        
    }else{
        //更新数据库
        NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Livingroom fetchRequest] error:nil];
        
        for (Livingroom *livingroom  in temp) {
            livingroom.finishedCount = @(0);
        }
    }
        
    //保存
    NSError *error = nil;
    if ([[JFCoreDataManager sharedManager].managerContext save:&error]) {
        NSLog(@"更新数据成功");
    }else{
        NSLog(@"更新数据失败, %@", error);
    }
    
    //打印一下看看保存情况
    //执行查询请求
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Livingroom fetchRequest] error:nil];
    
    //打印结果集
    for (Livingroom *livingroom in temp) {
        NSLog(@"livingroom.finishedCount %@",livingroom.finishedCount);
    }
    
    //    //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:LivingroomNotification object:nil];
        
}

@end
