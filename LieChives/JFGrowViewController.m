//
//  JFGrowViewController.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/1.
//

#import "JFGrowViewController.h"
#import "JFGrowNormalView.h"

#import "JFGrowNormalView.h"
#import "MySetting+CoreDataClass.h"

#import "Kitchen+CoreDataClass.h"
#import "Livingroom+CoreDataClass.h"
#import "Bedroom+CoreDataClass.h"
#import "Bathroom+CoreDataClass.h"
@interface JFGrowViewController ()
///已经坚持的天数View
@property (nonatomic, strong) JFGrowNormalView *dayCountView;
///本轮还剩View
@property (nonatomic, strong) JFGrowNormalView *leftCountView;
///完成次数View
@property (nonatomic, strong) JFGrowNormalView *finishedCountView;
///进度条
@property (nonatomic, strong) UIProgressView *progressView;



///DaysLblText 坚持天数标签的文字
@property (nonatomic, strong) NSString *daysLblText;
///allFinishedCountLblText完成总轮数标签的文字
@property (nonatomic, strong) NSString *allFinishedCountLblText;


///对应coredata模型的缓存模型
@property (nonatomic, strong) MySetting *mySettingModel;
//房间coreData模型
@property (nonatomic, strong) Kitchen *kitchenModel;

@property (nonatomic, strong) Livingroom *livingroomModel;

@property (nonatomic, strong) Bedroom *bedroomModel;

@property (nonatomic, strong) Bathroom *bathroomModel;


@end

@implementation JFGrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.progressView.progress = 0.7;

    [self setupSubViews];
    
    //初始化 设置数据库表
    [self initGrowData];
    
    //每次打开app就取出之前记录的日期，没有重复就添加到数据库
    [self writeDateData];
    //写入坚持天数Ui
    [self writeKeepDaysLbl];
    

}

#pragma mark - 通知相关
- (instancetype)init{
    if(self = [super init]){
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRoomsFinishedCount) name:MainNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRoomsFinishedCount) name:KitchenNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRoomsFinishedCount) name:LivingroomNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRoomsFinishedCount) name:BedroomNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRoomsFinishedCount) name:BathroomNotification object:nil];

    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MainNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KitchenNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:LivingroomNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:BedroomNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:BathroomNotification object:nil];

}

#pragma mark - fetchRoomsFinishedCount
- (void)fetchRoomsFinishedCount{
#pragma mark 查询四个房间数据库
    //查询厨房
    NSArray *kitchenTempArr = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Kitchen fetchRequest] error:nil];
    //这里要判断，因为数据库表初始化是要下载app点开一次厨房的按钮
    if(kitchenTempArr.count){
        for (Kitchen *kitchenTempModel in kitchenTempArr) {
            self.kitchenModel = kitchenTempModel;
        }
    
//    NSLog(@"kitchenModel: %@",self.kitchenModel.shuiChi);
    }
    
    //查询客厅
    NSArray *livingroomTempArr = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Livingroom fetchRequest] error:nil];
    //这里要判断，因为数据库表初始化是要下载app点开一次厨房的按钮
    if(livingroomTempArr.count){
        for (Livingroom *livingroomTempNodel in livingroomTempArr) {
            self.livingroomModel = livingroomTempNodel;
        }
//    NSLog(@"isKitchenFinished: %d",self.isKitchenFinished);
    }
    
    //查询卧室
    NSArray *bedroomTempArr = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bedroom fetchRequest] error:nil];
    //这里要判断，因为数据库表初始化是要下载app点开一次厨房的按钮
    if(bedroomTempArr.count){
        for (Bedroom *bedroomTempModel in bedroomTempArr) {
            self.bedroomModel = bedroomTempModel;
        }

//    NSLog(@"isKitchenFinished: %d",self.isKitchenFinished);
    }
    
    //查询卫生间
    NSArray *bathroomTempArr = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[Bathroom fetchRequest] error:nil];
    //这里要判断，因为数据库表初始化是要下载app点开一次厨房的按钮
    if(bathroomTempArr.count){
        for (Bathroom *bathroomTempModel in bathroomTempArr) {
            self.bathroomModel = bathroomTempModel;
        }
        
//    NSLog(@"isBathroomFinished: %d",self.isBathroomFinished);
    }
    
#pragma mark 更新数据库总体完成轮次

    //拿到数据库里的设置表
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[MySetting fetchRequest] error:nil];
   
        //如果一个轮次，更新数据库完成轮次，并把四个房间的对勾清理掉
    for (MySetting *upDateSetting in temp) {
        if([self.kitchenModel.finishedCount isEqual:@(1)] &&
           [self.livingroomModel.finishedCount isEqual:@(1)] &&
           [self.bedroomModel.finishedCount isEqual:@(1)] &&
           [self.bathroomModel.finishedCount isEqual:@(1)]
           ){
            /*
             //NSNumber对象不能自增
             将NSNumber转化为int
             将int数据自增
             将int数据转化成NSNumber更新保存
             */
            int intAllFinishedCount = [upDateSetting.allFinishedCount intValue];
            intAllFinishedCount++;
            upDateSetting.allFinishedCount = [NSNumber numberWithInt:intAllFinishedCount];
            NSLog(@"allFinishedCount----%@",upDateSetting.allFinishedCount);
            //添加标签文本
            self.allFinishedCountLblText = [NSString stringWithFormat:@"已完成%@轮",upDateSetting.allFinishedCount];
            //给主页完成次数发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:RefreshHomeOverCount object:nil userInfo:@{@"allFinishedCountText" : [NSString stringWithFormat:@"%@次",upDateSetting.allFinishedCount]}];
                  
            /*
             获取之前所有的数据，清零四个房间的数据库
             */
            self.kitchenModel.finishedCount = @(0);
            self.livingroomModel.finishedCount = @(0);
            self.bedroomModel.finishedCount = @(0);
            self.bathroomModel.finishedCount = @(0);

            self.kitchenModel.gongZuoTai = @(0);
            self.kitchenModel.chuGui = @(0);
            self.kitchenModel.zaoTai = @(0);
            self.kitchenModel.shuiChi = @(0);
            
            self.livingroomModel.shaFa = @(0);
            self.livingroomModel.shuGui = @(0);
            self.livingroomModel.dianShiGui = @(0);
            self.livingroomModel.bingXiang = @(0);
            self.livingroomModel.canZhuo = @(0);
            self.livingroomModel.qiangBi = @(0);
            self.livingroomModel.xieGui = @(0);
            self.livingroomModel.chuWuGui = @(0);
            self.livingroomModel.chaJi = @(0);

            self.bedroomModel.yiGui = @(0);
            self.bedroomModel.chuangTouGui = @(0);
            self.bedroomModel.chuang = @(0);
            self.bedroomModel.shuGui = @(0);
            self.bedroomModel.yangTai = @(0);
            self.bedroomModel.qiangBi = @(0);
            self.bedroomModel.xueXiZhuo = @(0);
            self.bedroomModel.men = @(0);
            self.bedroomModel.chuWuGui = @(0);

            self.bathroomModel.shuiChi = @(0);
            self.bathroomModel.yuGang = @(0);
            self.bathroomModel.xiYuWeiShengYongPinJiaZi = @(0);
            self.bathroomModel.maoJinJia = @(0);

            //刷新四个房间的数据(如果不退回主页，直接点成长，再返回主页面的房间里面的话，就还是打勾的)
            //使用通知
            //发送通知给四个房间VC
            [[NSNotificationCenter defaultCenter] postNotificationName:RefreshRoomsNotification object:nil];
            
        }
        }
//        保存
        NSError *error = nil;
        if ([[JFCoreDataManager sharedManager].managerContext save:&error]) {
            NSLog(@"更新数据成功");
        }else{
            NSLog(@"更新数据失败, %@", error);
        }
    
    [self writeAllFinishedCountLbl];

    
}

#pragma mark - 写入UI文字
///完成总轮次
- (void)writeAllFinishedCountLbl{
    //富文本设置（大小，居中）
    NSMutableParagraphStyle *allFinishedCountParagraphStyle = [NSMutableParagraphStyle new];
    allFinishedCountParagraphStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *allFinishedCountAttrString = [[NSMutableAttributedString alloc] initWithString:self.allFinishedCountLblText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:25], NSParagraphStyleAttributeName : allFinishedCountParagraphStyle}];
//        self.growNormalView.growNormalViewLbl.attributedText = attrString;
    self.finishedCountView.growNormalViewLbl.attributedText = allFinishedCountAttrString;
}

///坚持时间
- (void)writeKeepDaysLbl{
    //获取文字
    [self fetchKeepDaysLblTexts];
    //富文本设置（大小，居中）
    NSMutableParagraphStyle *keepDayParagraphStyle = [NSMutableParagraphStyle new];
    keepDayParagraphStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *keepDayAttrString = [[NSMutableAttributedString alloc] initWithString:self.daysLblText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:25], NSParagraphStyleAttributeName : keepDayParagraphStyle}];
//        self.growNormalView.growNormalViewLbl.attributedText = attrString;
    self.dayCountView.growNormalViewLbl.attributedText = keepDayAttrString;
}

- (void)fetchKeepDaysLblTexts{
    //先获取一下
    NSArray *fetchTemp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[MySetting fetchRequest] error:nil];
    
    for (MySetting *mySetting in fetchTemp) {
//        NSLog(@"fetch--%@---fetchTemp.count:%lu",mySetting.datesArr, (unsigned long)fetchTemp.count);
        //count - 1 减去初始化加的数据
        self.daysLblText = [NSString stringWithFormat:@"我已坚持%zd天",mySetting.datesArr.count - 1];
    }
}

#pragma mark - 有关coreData方法
///每次打开app就取出之前记录的日期，没有重复就添加到数据库
- (void)writeDateData{
    
    //获取现在时间
    NSDate *presentDate = [NSDate date];
    //创建一个时间格式化对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYY:MM:dd"];
    //当天的日期
    NSString *presentDateString = [dateFormatter stringFromDate:presentDate];
    
//    NSLog(@"%@",presentDateString);
    
    //拿到数据库里的日期数组
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[MySetting fetchRequest] error:nil];
    self.mySettingModel = temp[0];
//    NSLog(@"%@",self.mySettingModel);
    //判断数据库是否需要添加当天日期
    BOOL isWrite = YES;
    
    //遍历数据库里的日期数组
    for (NSString *datesStr in self.mySettingModel.datesArr) {
//        NSLog(@"便利日期数组--%@",datesStr);
        //判断是否重复
        if([datesStr isEqualToString:presentDateString]){
            isWrite = NO;
            break;
        }
    }
    
    //如果没有重复就添加
    if(isWrite == YES){
        //更新数据库
        for (MySetting *upDateSetting in temp) {
//            NSLog(@"upDateSetting.datesArr--%@",upDateSetting.datesArr);
            
            NSMutableArray *copyMutableArr = [upDateSetting.datesArr mutableCopy];
            [copyMutableArr addObject:presentDateString];
            upDateSetting.datesArr = copyMutableArr;
        }
        
//        保存
        NSError *error = nil;
        if ([[JFCoreDataManager sharedManager].managerContext save:&error]) {
            NSLog(@"更新数据成功");
        }else{
            NSLog(@"更新数据失败, %@", error);
        }
    }
    
    
    
    
}



///如果没有创建数据库就创建（一次性初始化）
- (void)initGrowData{
    //先获取一下
    NSArray *temp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[MySetting fetchRequest] error:nil];
    if(temp.count == 0){
        
    //通过实体描述描述出实体对象
    MySetting *setting = [NSEntityDescription insertNewObjectForEntityForName:@"MySetting" inManagedObjectContext:[JFCoreDataManager sharedManager].managerContext];
    
    //数据存储插入操作  KVC
    //初始化数据库元素
    //先搞成复数来测试
    setting.datesArr = [NSMutableArray arrayWithObject:@"0000-00-00"];
    setting.allFinishedCount = @(0);
    
    //通过上下文进行提交存储
    [[JFCoreDataManager sharedManager].managerContext save:nil];
    }else{
        return;
    }
}

#pragma mark - setupSubViews
- (void)setupSubViews{
    //添加子视图
    [self.view addSubview:self.dayCountView];
    [self.view addSubview:self.finishedCountView];
    [self.view addSubview:self.leftCountView];
    [self.view addSubview:self.progressView];


    //设置自动布局
    [self.dayCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.view.mas_top).offset(100);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(80);
    }];
    
    [self.finishedCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.dayCountView.mas_bottom).offset(50);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(80);
    }];
    
    [self.leftCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.finishedCountView.mas_bottom).offset(50);
            make.width.mas_equalTo(320);
            make.height.mas_equalTo(80);
    }];
    
    //设置进度条布局，给一个负的y距离
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.leftCountView.mas_bottom).offset(-10);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(5);
    }];
    
}


# pragma mark - 懒加载
- (NSString *)allFinishedCountLblText{
    if(!_allFinishedCountLblText){
        _allFinishedCountLblText = @"已完成0轮";
    }
    return _allFinishedCountLblText;
}

- (MySetting *)mySettingModel{
    if(!_mySettingModel){
        _mySettingModel = [MySetting new];
    }
    return _mySettingModel;
}

- (UIProgressView *)progressView{
    if(!_progressView){
        _progressView = [UIProgressView new];
        _progressView.tintColor = [UIColor systemGreenColor];
    }
    return _progressView;
}

- (JFGrowNormalView *)dayCountView{
    if(!_dayCountView){
        _dayCountView = [JFGrowNormalView new];
    }
    return _dayCountView;
}

- (JFGrowNormalView *)leftCountView{
    if(!_leftCountView){
        _leftCountView = [JFGrowNormalView new];
    }
    return _leftCountView;
}

- (JFGrowNormalView *)finishedCountView{
    if(!_finishedCountView){
        _finishedCountView = [JFGrowNormalView new];
    }
    return _finishedCountView;
}



@end
