//
//  DCAcountMsgInfoModel.h
//  dc
//
//  Created by xm6leefun on 2020/11/4.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DCAcountMsgInfopledgeModel,DCAcountMsgInfolockUpModel;
@interface DCAcountMsgInfoModel : NSObject
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *rightValue;
@property (nonatomic, copy) NSString *rightTime;
@property (nonatomic, copy) NSString *superPledge;
@property (nonatomic, copy) NSString *superPledgeTime;
@property (nonatomic, copy) NSString *pledgeNum;
@property (nonatomic, strong) NSArray <DCAcountMsgInfopledgeModel *> *pledge;
@property (nonatomic, copy) NSString *lockUpNum;
@property (nonatomic, strong) NSArray <DCAcountMsgInfolockUpModel *> *lockUp;
@property (nonatomic, copy) NSString *blockHeight;
@property (nonatomic, copy) NSString *noce;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *encode;
@end
@interface DCAcountMsgInfopledgeModel : NSObject
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *unLockTime;

@end
@interface DCAcountMsgInfolockUpModel : NSObject
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *unLockTime;

@end

