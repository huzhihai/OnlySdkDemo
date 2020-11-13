//
//  NSDictionary+ITWExtend.h
//  IndustrialWorkers
//
//  Created by admin on 2019/11/28.
//  Copyright © 2019 Chengdu songzi information technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ITWExtend)

- (NSDictionary*)dictionaryForKey:(id)key;
- (NSArray *)arrayForKey:(id)key;
- (NSString *)stringForKey:(id)key;
- (NSNumber *)numberForKey:(id)key;
- (BOOL)boolForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (double)doubleForKey:(id)key;

@end

NS_ASSUME_NONNULL_END
