#only2.0

1 添加pch文件，全局引入 #import <UIKit/UIKit.h>
2 在需要使用的地方 引入 #import "DCEther.h"
3 build setting > vaild architectures 去掉对 armv7的支持

4  Only 主要是OC语言开发  包含了swift 需要配置  xxxx-Bridging-Header，改完引入项目需要替换 ETHSDKONly-Swift 换成 xxxx-swift （重点，配置swift）

 5 需要引入加密规则
    pod 'CB_RIPEMD', '~> 0.9.0'
    pod 'LEB128', '~> 2.0.0'
 建议cocopods 引入
  providsBaseUrl  only的节点，可以替换自己所需要的节点
 6.使用Only 直接用dc 为开头的方法
