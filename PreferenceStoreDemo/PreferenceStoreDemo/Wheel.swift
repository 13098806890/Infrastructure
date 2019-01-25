//
//  Wheel.swift
//  PreferenceStoreDemo
//
//  Created by doxie on 1/11/19.
//  Copyright © 2019 Xie. All rights reserved.
//

import UIKit

class Wheel: NSObject, NSSecureCoding, NSCopying {

    static var supportsSecureCoding: Bool = UserDefaults.supportsSecureCoding


    var pressure: NSInteger
    var needTobePumped: Bool

    override init() {
        self.pressure = 1
        self.needTobePumped = false
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.pressure, forKey: "pressure")
        aCoder.encode(self.needTobePumped, forKey: "needTobePumped")
    }

    required init?(coder aDecoder: NSCoder) {
        self.pressure = aDecoder.decodeInteger(forKey: "pressure")
        self.needTobePumped = aDecoder.decodeBool(forKey: "needTobePumped")
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Wheel()
        copy.pressure = self.pressure
        copy.needTobePumped = self.needTobePumped

        return copy
    }

}
