//
//  Bedroom+CoreDataProperties.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//
//

#import "Bedroom+CoreDataProperties.h"

@implementation Bedroom (CoreDataProperties)

+ (NSFetchRequest<Bedroom *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Bedroom"];
}

@dynamic chuang;
@dynamic chuangTouGui;
@dynamic chuWuGui;
@dynamic men;
@dynamic qiangBi;
@dynamic shuGui;
@dynamic xueXiZhuo;
@dynamic yangTai;
@dynamic yiGui;

@dynamic finishedCount;


@end
