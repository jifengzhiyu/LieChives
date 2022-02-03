//
//  JFCoreDataManager.h
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFCoreDataManager : NSObject
//创建一个管理对象上下文
@property (nonatomic , strong)NSManagedObjectContext *managerContext;

//简单的单例
+ (instancetype)sharedManager;
@end

NS_ASSUME_NONNULL_END
