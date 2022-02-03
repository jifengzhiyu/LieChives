//
//  Bathroom+CoreDataProperties.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/3.
//
//

#import "Bathroom+CoreDataProperties.h"

@implementation Bathroom (CoreDataProperties)

+ (NSFetchRequest<Bathroom *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Bathroom"];
}

@dynamic maoJinJia;
@dynamic shuiChi;
@dynamic xiYuWeiShengYongPinJiaZi;
@dynamic yuGang;

@end
