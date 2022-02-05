//
//  JFTips.h
//  LieChives
//
//  Created by 翟佳阳 on 2022/2/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFTips : NSObject
//组标题
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *tips;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)tipsWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
