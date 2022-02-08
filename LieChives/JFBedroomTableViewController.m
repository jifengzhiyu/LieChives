//
//  JFBedroomTableViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/2.
//

#import "JFBedroomTableViewController.h"
#import "Bedroom+CoreDataClass.h"
@interface JFBedroomTableViewController ()

@property (nonatomic, strong) Bedroom *bedroom;
///BedroomPartArr记录cell的cell.textLabel.text
@property (nonatomic, copy) NSArray *BedroomPartArr;

@end

@implementation JFBedroomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"卧室";

    //如果没有创建数据库就创建（一次性初始化）
    [self initBedroomData];
}

///如果没有创建数据库就创建（一次性初始化）
- (void)initBedroomData{
    //先获取一下
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bedroom fetchRequest] error:nil];
    if(temp.count == 0){

    //通过实体描述描述出实体对象
  Bedroom *bedroom = [NSEntityDescription insertNewObjectForEntityForName:@"Bedroom" inManagedObjectContext:[JFCoreDataManager sharedManager].managerContext];
    
    //数据存储插入操作  KVC
    //初始化数据库元素
    bedroom.yiGui = @(0);
    bedroom.chuangTouGui = @(0);
    bedroom.chuang = @(0);
    bedroom.shuGui = @(0);
    bedroom.yangTai = @(0);
    bedroom.qiangBi = @(0);
    bedroom.xueXiZhuo = @(0);
    bedroom.men = @(0);
    bedroom.chuWuGui = @(0);
    
    bedroom.finishedCount = @(0);
    
    //通过上下文进行提交存储
    [[JFCoreDataManager sharedManager].managerContext save:nil];
    }else{
        return;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    static NSString * identifier = @"bedroomCell";
    JFRoomsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[JFRoomsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置cell的文字
    cell.textLabel.text = self.BedroomPartArr[indexPath.row];
    //设置cell的渲染颜色
    cell.tintColor = [UIColor systemGreenColor];
    
    //打对勾了缓存了，就打对勾
    if([cell.textLabel.text  isEqual: @"衣柜"]){
        if(self.bedroom.yiGui == nil || [self.bedroom.yiGui isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"衣柜---load");
    }else if ([cell.textLabel.text  isEqual: @"床头柜"]){
        if(self.bedroom.chuangTouGui == nil || [self.bedroom.chuangTouGui isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"床头柜---load");
    }else if ([cell.textLabel.text  isEqual: @"床"]){
        if(self.bedroom.chuang == nil || [self.bedroom.chuang isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"床---load");
    }else if ([cell.textLabel.text  isEqual: @"书柜"]){
        if(self.bedroom.shuGui == nil || [self.bedroom.shuGui  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"书柜---load");
    }else if ([cell.textLabel.text  isEqual: @"阳台"]){
        if(self.bedroom.yangTai == nil || [self.bedroom.yangTai isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"阳台---load");
    }else if ([cell.textLabel.text  isEqual: @"墙壁"]){
        if(self.bedroom.qiangBi == nil || [self.bedroom.qiangBi  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"墙壁---load");
    }else if ([cell.textLabel.text  isEqual: @"学习桌"]){
        if(self.bedroom.xueXiZhuo == nil || [self.bedroom.xueXiZhuo isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"学习桌---load");
    }else if ([cell.textLabel.text  isEqual: @"门"]){
        if(self.bedroom.men == nil || [self.bedroom.men  isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"门---load");
    }else if ([cell.textLabel.text  isEqual: @"储物柜"]){
        if(self.bedroom.chuWuGui == nil || [self.bedroom.chuWuGui isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"储物柜---load");
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

- (NSArray *)BedroomPartArr{
    if(!_BedroomPartArr){
        _BedroomPartArr = @[@"床", @"床头柜", @"衣柜", @"储物柜", @"学习桌", @"书柜", @"门", @"墙壁", @"阳台"];
    }
    return _BedroomPartArr;
}

- (Bedroom *)bedroom{
    if(!_bedroom){
        //获取数据
        NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bedroom fetchRequest] error:nil];
        _bedroom = (Bedroom *)temp[0];

    }
//    NSLog(@"_bedroom --- %@",_bedroom);

    return _bedroom;
}

#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell
        JFRoomsTableViewCell *cell = (JFRoomsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if([cell.textLabel.text  isEqual: @"衣柜"]){
        if(self.bedroom.yiGui == nil || [self.bedroom.yiGui isEqual: @(0)]){
        self.bedroom.yiGui = @(1);
        }else{
            self.bedroom.yiGui = @(0);
        }
//        NSLog(@"衣柜");
    }else if ([cell.textLabel.text isEqual: @"床头柜"]){
        if(self.bedroom.chuangTouGui == nil || [self.bedroom.chuangTouGui isEqual: @(0)]){
        self.bedroom.chuangTouGui = @(1);
        }else{
            self.bedroom.chuangTouGui = @(0);
        }
//        NSLog(@"床头柜");
    }else if ([cell.textLabel.text isEqual: @"床"]){
        if(self.bedroom.chuang == nil || [self.bedroom.chuang isEqual: @(0)]){
        self.bedroom.chuang = @(1);
        }else{
            self.bedroom.chuang = @(0);
        }
//        NSLog(@"床");
    }else if ([cell.textLabel.text isEqual: @"书柜"]){
        if(self.bedroom.shuGui == nil || [self.bedroom.shuGui isEqual: @(0)]){
        self.bedroom.shuGui = @(1);
        }else{
            self.bedroom.shuGui = @(0);
        }
//        NSLog(@"书柜");
    }else if ([cell.textLabel.text isEqual: @"阳台"]){
        if(self.bedroom.yangTai == nil || [self.bedroom.yangTai isEqual: @(0)]){
        self.bedroom.yangTai = @(1);
        }else{
            self.bedroom.yangTai = @(0);
        }
//        NSLog(@"阳台");
    }else if ([cell.textLabel.text isEqual: @"墙壁"]){
        if(self.bedroom.qiangBi == nil || [self.bedroom.qiangBi isEqual: @(0)]){
        self.bedroom.qiangBi = @(1);
        }else{
            self.bedroom.qiangBi = @(0);
        }
//        NSLog(@"墙壁");
    }else if ([cell.textLabel.text isEqual: @"学习桌"]){
        if(self.bedroom.xueXiZhuo == nil || [self.bedroom.xueXiZhuo isEqual: @(0)]){
        self.bedroom.xueXiZhuo = @(1);
        }else{
            self.bedroom.xueXiZhuo = @(0);
        }
//        NSLog(@"学习桌");
    }else if ([cell.textLabel.text isEqual: @"门"]){
        if(self.bedroom.men == nil || [self.bedroom.men isEqual: @(0)]){
        self.bedroom.men = @(1);
        }else{
            self.bedroom.men = @(0);
        }
//        NSLog(@"门");
    }else if ([cell.textLabel.text isEqual: @"储物柜"]){
        if(self.bedroom.chuWuGui == nil || [self.bedroom.chuWuGui isEqual: @(0)]){
        self.bedroom.chuWuGui = @(1);
        }else{
            self.bedroom.chuWuGui = @(0);
        }
//        NSLog(@"储物柜");
    }
    
    //更新数据库
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bedroom fetchRequest] error:nil];

    for (Bedroom *bedroom  in temp) {
//        NSLog(@"更新数据%@--%@---%@---%@ 更新 前-----》一共有多少个记录%lu",kitchen.gongZuoTai,kitchen.zaoTai,kitchen.chuGui,kitchen.shuiChi,temp.count);

        bedroom.yiGui = self.bedroom.yiGui;
        bedroom.chuangTouGui = self.bedroom.chuangTouGui;
        bedroom.chuang = self.bedroom.chuang;
        bedroom.shuGui = self.bedroom.shuGui;
        bedroom.yangTai = self.bedroom.yangTai;
        bedroom.qiangBi = self.bedroom.qiangBi;
        bedroom.xueXiZhuo = self.bedroom.xueXiZhuo;
        bedroom.men = self.bedroom.men;
        bedroom.chuWuGui = self.bedroom.chuWuGui;
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
    if([self.bedroom.yiGui isEqual:@(1)] &&
       [self.bedroom.chuWuGui isEqual:@(1)] &&
       [self.bedroom.chuang isEqual:@(1)] &&
       [self.bedroom.shuGui isEqual:@(1)] &&
       [self.bedroom.yangTai isEqual:@(1)] &&
       [self.bedroom.qiangBi isEqual:@(1)] &&
       [self.bedroom.xueXiZhuo isEqual:@(1)] &&
       [self.bedroom.men isEqual:@(1)] &&
       [self.bedroom.chuWuGui isEqual:@(1)]){
        //更新数据库
        NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bedroom fetchRequest] error:nil];
        
        for (Bedroom *bedroom  in temp) {
            bedroom.finishedCount = @(1);
        }
        
    }else{
        //更新数据库
        NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bedroom fetchRequest] error:nil];
        
        for (Bedroom *bedroom  in temp) {
            bedroom.finishedCount = @(0);
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
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bedroom fetchRequest] error:nil];
    
    //打印结果集
    for (Bedroom *bedroom in temp) {
        NSLog(@"bedroom.finishedCount %@",bedroom.finishedCount);
    }
    //    //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:BedroomNotification object:nil];
        
}

@end
