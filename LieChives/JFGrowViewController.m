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
@interface JFGrowViewController ()
///已经坚持的天数View
@property (nonatomic, strong) JFGrowNormalView *dayCountView;
///本轮还剩View
@property (nonatomic, strong) JFGrowNormalView *leftCountView;
///完成次数View
@property (nonatomic, strong) JFGrowNormalView *finishedCountView;
///进度条
@property (nonatomic, strong) UIProgressView *progressView;

///对应coredata模型的缓存模型
@property (nonatomic, strong) MySetting *mySettingModel;

///DaysLblText 坚持天数标签的文字
@property (nonatomic, strong) NSString *daysLblText;



@end

@implementation JFGrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    
    self.progressView.progress = 0.7;

    [self setupSubViews];
    
    [self initGrowData];
    
    [self writeDateData];
    
    [self writeKeepDaysLbl];
    
//    [self fetch];
}

- (void)writeKeepDaysLbl{
    [self fetchLblTexts];
    //富文本设置（大小，居中）
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.daysLblText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:25], NSParagraphStyleAttributeName : paragraphStyle}];
//        self.growNormalView.growNormalViewLbl.attributedText = attrString;
    self.dayCountView.growNormalViewLbl.attributedText = attrString;
}

#pragma mark - 有关coreData方法
///每次打开app就取出之前记录的日期，没有重复就添加
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
    NSLog(@"%@",self.mySettingModel);
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

- (void)fetchLblTexts{
    //先获取一下
    NSArray *fetchTemp = [[JFCoreDataManager sharedManager].managerContext executeFetchRequest:[MySetting fetchRequest] error:nil];
    
    for (MySetting *mySetting in fetchTemp) {
//        NSLog(@"fetch--%@---fetchTemp.count:%lu",mySetting.datesArr, (unsigned long)fetchTemp.count);
        self.daysLblText = [NSString stringWithFormat:@"我已坚持%zd天",mySetting.datesArr.count];
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
    setting.datesArr = [NSMutableArray arrayWithObjects:@"0000-00-00",@"1111-11-11", nil];
    
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
