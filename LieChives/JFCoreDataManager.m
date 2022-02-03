//
//  JFCoreDataManager.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//

#import "JFCoreDataManager.h"

@implementation JFCoreDataManager
//实现单例
static JFCoreDataManager *sharemanager;

+(instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharemanager = [JFCoreDataManager new];
    });
    return sharemanager;
}


-(NSManagedObjectContext *)managerContext
{
    if (_managerContext == nil) {
        //创建对象
        _managerContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        //给上下文设置持久化存储协调器
        //模型文件的url
        NSURL *url = [[NSBundle mainBundle]URLForResource:@"LieChives" withExtension:@"momd"];
        //根据url 获取到模型文件
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
        //设置模型文件
        NSPersistentStoreCoordinator *per = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        
        //数据路径一般放在沙盒
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//        NSURL *file = [NSURL fileURLWithPath:@"/Users/kaixin/Desktop/person/person.db"];
        NSURL *file = [NSURL fileURLWithPath: docPath];
        
        //添加数据库文件路径
        [per addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:file options:nil error:nil];
        
        [_managerContext setPersistentStoreCoordinator:per];
    }
    return _managerContext;

}
@end
