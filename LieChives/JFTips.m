//
//  JFTips.m
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/5.
//

#import "JFTips.h"

@implementation JFTips

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)tipsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
