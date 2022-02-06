//
//  MySetting+CoreDataProperties.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/6.
//
//

#import "MySetting+CoreDataProperties.h"

@implementation MySetting (CoreDataProperties)

+ (NSFetchRequest<MySetting *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MySetting"];
}

@dynamic datesArr;

@end
