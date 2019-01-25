//
//  Bicycle.swift
//  PreferenceStoreDemo
//
//  Created by doxie on 1/11/19.
//  Copyright © 2019 Xie. All rights reserved.
//

import UIKit

class Bicycle: NSObject, MSTRDevicePreferenceStoreProtocol {

    static var supportsSecureCoding: Bool = UserDefaults.supportsSecureCoding


    var isLock: Bool
    var fontWheel: Wheel
    var backWheel: Wheel

    override init() {
        self.isLock = true
        self.fontWheel = Wheel()
        self.backWheel = Wheel()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.isLock, forKey: "isLock")
        aCoder.encode(self.fontWheel, forKey: "fontWheel")
        aCoder.encode(self.backWheel, forKey: "backWheel")
    }

    required init?(coder aDecoder: NSCoder) {
        isLock = aDecoder.decodeBool(forKey: "isLock")
        fontWheel = aDecoder.decodeObject(forKey: "fontWheel") as! Wheel
        backWheel = aDecoder.decodeObject(forKey: "backWheel") as! Wheel
    }

    func storeToPreference() {
        MSTRDevicePreference.devicePreference.bicycle = self
    }

    static func defaultValueInstance() -> MSTRDevicePreferenceStoreProtocol {
        let defaultSelf = Bicycle()
        if let dic = MSTRDevicePreference.preferenceDefaultDic["bicycle"] as? NSDictionary {
            defaultSelf.isLock = dic["isLock"] as! Bool
            if let frontWheel = dic["frontWheel"] as? NSDictionary {
                defaultSelf.fontWheel.pressure = frontWheel["pressure"] as! NSInteger
                defaultSelf.fontWheel.needTobePumped = frontWheel["needTobePumped"] as! Bool
            }
            if let backWheel = dic["backWheel"] as? NSDictionary {
                defaultSelf.backWheel.pressure = backWheel["pressure"] as! NSInteger
                defaultSelf.backWheel.needTobePumped = backWheel["needTobePumped"] as! Bool
            }
        }
        return defaultSelf
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Bicycle()
        copy.isLock = self.isLock
        copy.fontWheel = self.fontWheel.copy() as! Wheel
        copy.backWheel = self.backWheel.copy() as! Wheel

        return copy
    }

    static func useDefaultValue() -> Bool {

        return false
//        if let dic = MSTRDevicePreference.preferenceDefaultDic["bicycle"] as? NSDictionary {
//            if let useDefaultKey = dic["useDefaultValue"] as? Bool {
//                if useDefaultKey {
//                    return true
//                }
//            }
//        }
//
//        return false
    }

}
