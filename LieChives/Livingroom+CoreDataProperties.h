//
//  Livingroom+CoreDataProperties.h
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//
//

#import "Livingroom+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Livingroom (CoreDataProperties)

+ (NSFetchRequest<Livingroom *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, retain) NSNumber *bingXiang;
@property (nullable, nonatomic, retain) NSNumber *canZhuo;
@property (nullable, nonatomic, retain) NSNumber *chaJi;
@property (nullable, nonatomic, retain) NSNumber *chuWuGui;
@property (nullable, nonatomic, retain) NSNumber *dianShiGui;
@property (nullable, nonatomic, retain) NSNumber *qiangBi;
@property (nullable, nonatomic, retain) NSNumber *shaFa;
@property (nullable, nonatomic, retain) NSNumber *shuGui;
@property (nullable, nonatomic, retain) NSNumber *xieGui;

@property (nullable, nonatomic, retain) NSNumber *finishedCount;

@end

NS_ASSUME_NONNULL_END
