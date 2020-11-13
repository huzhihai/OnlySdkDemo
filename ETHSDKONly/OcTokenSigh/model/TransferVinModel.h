//
//  TransferVinModel.h
//  ocToken
//
//  Created by xm6leefun on 2020/8/5.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransferVinModel : NSObject
@property (nonatomic, strong) NSString *n;
@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *price;
@end

NS_ASSUME_NONNULL_END
