//
//  Livingroom+CoreDataProperties.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//
//

#import "Livingroom+CoreDataProperties.h"

@implementation Livingroom (CoreDataProperties)

+ (NSFetchRequest<Livingroom *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Livingroom"];
}

@dynamic bingXiang;
@dynamic canZhuo;
@dynamic chaJi;
@dynamic chuWuGui;
@dynamic dianShiGui;
@dynamic qiangBi;
@dynamic shaFa;
@dynamic shuGui;
@dynamic xieGui;

@end
