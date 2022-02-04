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

@property (nullable, nonatomic, retain) NSNumber *chuGui;
@property (nullable, nonatomic, retain) NSNumber *gongZuoTai;
@property (nullable, nonatomic, retain) NSNumber *shuiChi;
@property (nullable, nonatomic, retain) NSNumber *zaoTai;

@property (nullable, nonatomic, retain) NSNumber *finishedCount;


@end

NS_ASSUME_NONNULL_END
