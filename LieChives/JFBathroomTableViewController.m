//
//  JFBathroomTableViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/2.
//

#import "JFBathroomTableViewController.h"
#import "Bathroom+CoreDataClass.h"
@interface JFBathroomTableViewController ()

@property (nonatomic, strong) Bathroom *bathroom;
///bathroomPartArr记录cell的cell.textLabel.text
@property (nonatomic, copy) NSArray *bathroomPartArr;

@end

@implementation JFBathroomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"卫生间";

    //如果没有创建数据库就创建（一次性初始化）
    [self initBathroomData];
}

///如果没有创建数据库就创建（一次性初始化）
- (void)initBathroomData{
    //先获取一下
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bathroom fetchRequest] error:nil];
    if(temp.count == 0){

    //通过实体描述描述出实体对象
    Bathroom *bathroom = [NSEntityDescription insertNewObjectForEntityForName:@"Bathroom" inManagedObjectContext:[JFCoreDataManager sharedManager].managerContext];
    
    //数据存储插入操作  KVC
    //初始化数据库元素
    bathroom.shuiChi = @(0);
    bathroom.yuGang = @(0);
    bathroom.xiYuWeiShengYongPinJiaZi = @(0);
    bathroom.maoJinJia = @(0);

    bathroom.finishedCount = @(0);
    
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    static NSString * identifier = @"bathroomCell";
    JFRoomsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[JFRoomsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置cell的文字
    cell.textLabel.text = self.bathroomPartArr[indexPath.row];
    //设置cell的渲染颜色
    cell.tintColor = [UIColor systemGreenColor];
    
    //打对勾了缓存了，就打对勾
    if([cell.textLabel.text  isEqual: @"水池"]){
        if(self.bathroom.shuiChi == nil || [self.bathroom.shuiChi isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"水池---load");
    }else if ([cell.textLabel.text  isEqual: @"浴缸"]){
        if(self.bathroom.yuGang == nil || [self.bathroom.yuGang isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"浴缸---load");
    }else if ([cell.textLabel.text  isEqual: @"洗浴卫生用品架子"]){
        if(self.bathroom.xiYuWeiShengYongPinJiaZi == nil || [self.bathroom.xiYuWeiShengYongPinJiaZi isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"洗浴卫生用品架子---load");
    }else if ([cell.textLabel.text  isEqual: @"毛巾架"]){
        if(self.bathroom.maoJinJia == nil || [self.bathroom.maoJinJia isEqual: @(0)]){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
//        NSLog(@"毛巾架---load");
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

- (NSArray *)bathroomPartArr{
    if(!_bathroomPartArr){
        _bathroomPartArr = @[@"水池", @"毛巾架", @"浴缸", @"洗浴卫生用品架子"];
    }
    return _bathroomPartArr;
}

- (Bathroom *)bathroom{
    if(!_bathroom){
        //获取数据
        NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bathroom fetchRequest] error:nil];
        _bathroom = (Bathroom *)temp[0];

    }
//    NSLog(@"_bathroom --- %@",_bathroom);

    return _bathroom;
}

#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell
        JFRoomsTableViewCell *cell = (JFRoomsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if([cell.textLabel.text  isEqual: @"水池"]){
        if(self.bathroom.shuiChi == nil || [self.bathroom.shuiChi isEqual: @(0)]){
        self.bathroom.shuiChi = @(1);
        }else{
            self.bathroom.shuiChi = @(0);
        }
//        NSLog(@"水池");
    }else if ([cell.textLabel.text  isEqual: @"浴缸"]){
        if(self.bathroom.yuGang == nil || [self.bathroom.yuGang isEqual: @(0)]){
        self.bathroom.yuGang = @(1);
        }else{
            self.bathroom.yuGang = @(0);
        }
//        NSLog(@"浴缸");
    }else if ([cell.textLabel.text  isEqual: @"毛巾架"]){
        if(self.bathroom.maoJinJia == nil || [self.bathroom.maoJinJia isEqual: @(0)]){
        self.bathroom.maoJinJia = @(1);
        }else{
            self.bathroom.maoJinJia = @(0);
        }
//        NSLog(@"毛巾架");
    }else if ([cell.textLabel.text  isEqual: @"洗浴卫生用品架子"]){
        if(self.bathroom.xiYuWeiShengYongPinJiaZi == nil || [self.bathroom.xiYuWeiShengYongPinJiaZi isEqual: @(0)]){
        self.bathroom.xiYuWeiShengYongPinJiaZi = @(1);
        }else{
            self.bathroom.xiYuWeiShengYongPinJiaZi = @(0);
        }
//        NSLog(@"洗浴卫生用品架子");
    }
    
    //更新数据库
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bathroom fetchRequest] error:nil];

    for (Bathroom *bathroom  in temp) {
//        NSLog(@"更新数据%@--%@---%@---%@ 更新 前-----》一共有多少个记录%lu",kitchen.gongZuoTai,kitchen.zaoTai,kitchen.chuGui,kitchen.shuiChi,temp.count);

        bathroom.shuiChi = self.bathroom.shuiChi;
        bathroom.yuGang = self.bathroom.yuGang;
        bathroom.maoJinJia = self.bathroom.maoJinJia;
        bathroom.xiYuWeiShengYongPinJiaZi = self.bathroom.xiYuWeiShengYongPinJiaZi;

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
    if([self.bathroom.shuiChi isEqual:@(1)] &&
       [self.bathroom.yuGang isEqual:@(1)] &&
       [self.bathroom.maoJinJia isEqual:@(1)] &&
       [self.bathroom.xiYuWeiShengYongPinJiaZi isEqual:@(1)]){
        //更新数据库
        NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bathroom fetchRequest] error:nil];
        
        for (Bathroom *bathroom  in temp) {
            bathroom.finishedCount = @(1);
        }
        
    }else{
        //更新数据库
        NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bathroom fetchRequest] error:nil];
        
        for (Bathroom *bathroom  in temp) {
            bathroom.finishedCount = @(0);
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
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bathroom fetchRequest] error:nil];
    
    //打印结果集
    for (Bathroom *bathroom in temp) {
        NSLog(@"bathroom.finishedCount %@",bathroom.finishedCount);
    }
    
    //    //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:BathroomNotification object:nil];
        
}

@end

