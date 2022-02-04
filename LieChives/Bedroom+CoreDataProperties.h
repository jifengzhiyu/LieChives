//
//  Bedroom+CoreDataProperties.h
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//
//

#import "Bedroom+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Bedroom (CoreDataProperties)

+ (NSFetchRequest<Bedroom *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, retain) NSNumber *chuang;
@property (nullable, nonatomic, retain) NSNumber *chuangTouGui;
@property (nullable, nonatomic, retain) NSNumber *chuWuGui;
@property (nullable, nonatomic, retain) NSNumber *men;
@property (nullable, nonatomic, retain) NSNumber *qiangBi;
@property (nullable, nonatomic, retain) NSNumber *shuGui;
@property (nullable, nonatomic, retain) NSNumber *xueXiZhuo;
@property (nullable, nonatomic, retain) NSNumber *yangTai;
@property (nullable, nonatomic, retain) NSNumber *yiGui;

@property (nullable, nonatomic, retain) NSNumber *finishedCount;

@end

NS_ASSUME_NONNULL_END
