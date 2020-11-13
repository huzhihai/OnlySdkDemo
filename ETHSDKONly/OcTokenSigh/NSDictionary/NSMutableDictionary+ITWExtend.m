//
//  NSMutableDictionary+ITWExtend.m
//  IndustrialWorkers
//
//  Created by admin on 2019/11/28.
//  Copyright © 2019 Chengdu songzi information technology co. LTD. All rights reserved.
//

#import "NSMutableDictionary+ITWExtend.h"

@implementation NSMutableDictionary (ITWExtend)

- (void)setObj:(id)obj forKey:(NSString *)key {
    if (obj != nil) {
        self[key] = obj;
    }
}

@end
