//
//  DCAcountMsgInfoModel.m
//  dc
//
//  Created by xm6leefun on 2020/11/4.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import "DCAcountMsgInfoModel.h"

@implementation DCAcountMsgInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pledge" : [DCAcountMsgInfopledgeModel class],
             @"lockUp" : [DCAcountMsgInfolockUpModel class],
             };
}
@end
@implementation DCAcountMsgInfopledgeModel

@end
@implementation DCAcountMsgInfolockUpModel

@end
