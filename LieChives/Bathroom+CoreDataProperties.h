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

@property (nonatomic) BOOL maoJinJia;
@property (nonatomic) BOOL shuiChi;
@property (nonatomic) BOOL xiYuWeiShengYongPinJiaZi;
@property (nonatomic) BOOL yuGang;

@end

NS_ASSUME_NONNULL_END
