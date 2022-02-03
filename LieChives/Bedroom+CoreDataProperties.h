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

@property (nonatomic) BOOL chuang;
@property (nonatomic) BOOL chuangTouGui;
@property (nonatomic) BOOL chuWuGui;
@property (nonatomic) BOOL men;
@property (nonatomic) BOOL qiangBi;
@property (nonatomic) BOOL shuGui;
@property (nonatomic) BOOL xueXiZhuo;
@property (nonatomic) BOOL yangTai;
@property (nonatomic) BOOL yiGui;

@end

NS_ASSUME_NONNULL_END
