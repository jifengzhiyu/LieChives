//
//  MySetting+CoreDataProperties.h
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/6.
//
//

#import "MySetting+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MySetting (CoreDataProperties)

+ (NSFetchRequest<MySetting *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, retain) NSMutableArray *datesArr;

@property (nullable, nonatomic, retain) NSNumber *allFinishedCount;

@end

NS_ASSUME_NONNULL_END
