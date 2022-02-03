//
//  Kitchen+CoreDataProperties.h
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//
//

#import "Kitchen+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Kitchen (CoreDataProperties)

+ (NSFetchRequest<Kitchen *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) BOOL chuGui;
@property (nonatomic) BOOL gongZuoTai;
@property (nonatomic) BOOL shuiChi;
@property (nonatomic) BOOL zaoTai;

@end

NS_ASSUME_NONNULL_END
