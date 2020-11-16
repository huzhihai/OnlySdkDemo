
#ONLY

引入项目中需要将  OcTokenSigh，eth  这两个文件导入到项目中一下是需要注意的事项：

1 在需要使用的地方 引入 #import "DCEther.h"

2 build setting > vaild architectures 去掉对 armv7的支持

3  Only 主要是OC语言开发  包含了swift 需要配置  xxxx-Bridging-Header，改完引入项目需要替换 ETHSDKONly-Swift 换成 xxxx-swift （重点重点重点重点!!!，配置swift）
注释：由于用到了  LEB128  是swift 因此需要配置

 4 需要引入
    pod 'CB_RIPEMD', '~> 0.9.0'
    pod 'LEB128', '~> 2.0.0'
 建议cocopods 引入
 
5  providsBaseUrl  only的节点，可以替换自己所需要的节点
  
6.使用Only 直接用dc 为开头的方法
 
 7.所有有关金额都是以亿为单位 
 
 8.普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账
 
