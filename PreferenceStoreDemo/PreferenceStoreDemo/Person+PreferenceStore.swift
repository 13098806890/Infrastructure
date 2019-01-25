//
//  Person+PreferenceStore.swift
//  PreferenceStoreDemo
//
//  Created by doxie on 1/15/19.
//  Copyright © 2019 Xie. All rights reserved.
//

import Foundation

extension Person: MSTRDevicePreferenceStoreProtocol {

    public func storeToPreference() {
        MSTRDevicePreference.devicePreference.person = self
    }

    static func defaultValueInstance() -> MSTRDevicePreferenceStoreProtocol {
        let person = Person()
        person.name = "name"
        person.age = 0

        return person
    }

    public static var supportsSecureCoding: Bool {
        return true
    }

    public static func useDefaultValue() -> Bool {
        return false
    }
    

}
