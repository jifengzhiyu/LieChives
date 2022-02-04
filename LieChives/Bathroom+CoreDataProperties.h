//
//  Bathroom+CoreDataProperties.h
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//
//

#import "Bathroom+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Bathroom (CoreDataProperties)

+ (NSFetchRequest<Bathroom *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, retain) NSNumber *maoJinJia;
@property (nullable, nonatomic, retain) NSNumber *shuiChi;
@property (nullable, nonatomic, retain) NSNumber *xiYuWeiShengYongPinJiaZi;
@property (nullable, nonatomic, retain) NSNumber *yuGang;

@property (nullable, nonatomic, retain) NSNumber *finishedCount;

@end

NS_ASSUME_NONNULL_END
