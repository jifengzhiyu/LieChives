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

@property (nonatomic) BOOL bingXiang;
@property (nonatomic) BOOL canZhuo;
@property (nonatomic) BOOL chaJi;
@property (nonatomic) BOOL chuWuGui;
@property (nonatomic) BOOL dianShiGui;
@property (nonatomic) BOOL qiangBi;
@property (nonatomic) BOOL shaFa;
@property (nonatomic) BOOL shuGui;
@property (nonatomic) BOOL xieGui;

@end

NS_ASSUME_NONNULL_END
