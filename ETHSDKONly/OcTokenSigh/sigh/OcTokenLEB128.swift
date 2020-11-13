//
//  OcTokenLEB128.swift
//  ocToken
//
//  Created by xm6leefun on 2020/7/27.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

import UIKit
import LEB128
class OcTokenLEB128: NSObject {
    
    @objc func LED128(variable: Int) ->NSArray {
        /// Encoding
        let value: Int = variable
        let buff = ByteBuffer(size: 10)
        let length = encodeSignedLEB(buff, value: value)
        print("Value: \(buff[0..<length])")
        let array = NSMutableArray.init();
        for num in buff[0..<length] {
            array .add(num);
        }
        return array;
    }
   @objc func decodeLEB128(variable: NSArray) ->NSString {
        
        
        let array = NSMutableArray.init();
    for num in variable {
        let value: Int = num as! Int
        let buff = ByteBuffer(size: 10)
        let length = encodeSignedLEB(buff, value: value)
        print(buff[0])
        array .add(buff[0])
    }
    let encodedUSigned = decodeSignedLEB(ByteBuffer(elements:array as! Array<Byte>))
    
        print("Value: \(encodedUSigned)")
//         let encodedUSigned = decodeSignedLEB(ByteBuffer())
//        let length = decodeSignedLEB(value as! ByteIn)
//        print("Value: \(buff[0..<length])")
        
//        for num in buff[0..<length] {
//            array .add(encodedUSigned);
//        }
    return String(encodedUSigned) as NSString;
    }
}
