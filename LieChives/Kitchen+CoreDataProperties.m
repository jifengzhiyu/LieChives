//
//  Kitchen+CoreDataProperties.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//
//

#import "Kitchen+CoreDataProperties.h"

@implementation Kitchen (CoreDataProperties)

+ (NSFetchRequest<Kitchen *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Kitchen"];
}

@dynamic chuGui;
@dynamic gongZuoTai;
@dynamic shuiChi;
@dynamic zaoTai;

@end
