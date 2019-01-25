//
//  MSTRDevicePreference.swift
//  PreferenceStoreDemo
//
//  Created by doxie on 1/11/19.
//  Copyright © 2019 Xie. All rights reserved.
//

import Foundation

protocol MSTRDevicePreferenceStoreBaseProtocol {
    static func useDefaultValue() -> Bool
    static func registerDefaults()
}

extension MSTRDevicePreferenceStoreBaseProtocol {
    static func useDefaultValue() -> Bool {
        return false
    }
}

protocol MSTRUserDefaultsSettable: MSTRDevicePreferenceStoreBaseProtocol {
    associatedtype defaultKeys: RawRepresentable
}

extension MSTRUserDefaultsSettable where defaultKeys.RawValue == String {

    static func set(value: Any, forKey key: defaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    static func string(forKey key: defaultKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }

    static func bool(forKey key: defaultKeys) -> Bool? {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }

    static func integer(forKey key: defaultKeys) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }

    static func removeObject(forKey keys: [defaultKeys]) {
        for key in keys {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}

extension UserDefaults {

    @objc public static var supportsSecureCoding: Bool = true

    struct Settings: MSTRUserDefaultsSettable {
        static func useDefaultValue() -> Bool {
            return false
        }

        enum defaultKeys: String {
            case networkTimeOut
            case folderCaching
            case logLevel
        }

        static public func registerDefaults() {
            if useDefaultValue() {
                UserDefaults.Settings.removeObject(forKey: [.networkTimeOut, .folderCaching, .logLevel])
            }
            UserDefaults.standard.register(defaults: [defaultKeys.networkTimeOut.rawValue: 120,
                                                      defaultKeys.folderCaching.rawValue: false,
                                                      defaultKeys.logLevel.rawValue: "ERROR"])
            if let settings = MSTRDevicePreference.preferenceDefaultDic["settings"] as? NSDictionary {
                for key in settings.allKeys {
                    UserDefaults.standard.register(defaults: [key as! String : settings[key]])
                }
            }

        }
    }
}

protocol MSTRDevicePreferenceStoreProtocol: MSTRDevicePreferenceStoreBaseProtocol, NSSecureCoding {
    func store(process: () -> Void)
    func synchronizedStore(process: () -> Void)
    static func defaultValueInstance() -> MSTRDevicePreferenceStoreProtocol
    static func userDefaultStoreKey() -> String
}

extension MSTRDevicePreferenceStoreProtocol {

    static func userDefaultStoreKey() -> String{
        return String(describing: Self.self)
    }

    public func store(process: () -> Void) {
        process()
        var data: Data
        do {
            data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
        } catch {
            data = NSKeyedArchiver.archivedData(withRootObject: self)
        }
        UserDefaults.standard.set(data, forKey: Self.userDefaultStoreKey())
    }

    public func synchronizedStore(process: () -> Void) {
        objc_sync_enter(self)
        self.store(process: process)
        objc_sync_exit(self)
    }

    public static func registerDefaults() {
        if useDefaultValue() {
            UserDefaults.standard.removeObject(forKey: userDefaultStoreKey())
        }
        let defaultSelf = defaultValueInstance()
        var data: Data
        do {
            data = try NSKeyedArchiver.archivedData(withRootObject: defaultSelf, requiringSecureCoding: true)
        } catch {
            data = NSKeyedArchiver.archivedData(withRootObject: defaultSelf)
        }
        UserDefaults.standard.register(defaults: [userDefaultStoreKey(): data])
    }
}


@objc public class MSTRDevicePreference: NSObject {
    var useDefaultValue = false

    @objc public static var devicePreference: MSTRDevicePreference = MSTRDevicePreference()
    @objc public static let preferenceDefaultDic: NSDictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "preference", ofType: "plist")!) as! NSDictionary
    @objc public var networkTimeOut: NSInteger {
        set{
            UserDefaults.Settings.set(value: newValue, forKey: .networkTimeOut)
        }
        get{
            return UserDefaults.Settings.integer(forKey: .networkTimeOut)!
        }
    }

    @objc public var folderCaching: Bool {
        set{
            UserDefaults.Settings.set(value: newValue, forKey: .folderCaching)
        }
        get{
            return UserDefaults.Settings.bool(forKey: .folderCaching)!
        }
    }

    @objc public var logLevel: String {
        set{
            UserDefaults.Settings.set(value: newValue, forKey: .logLevel)
        }
        get{
            return UserDefaults.Settings.string(forKey: .logLevel)!
        }
    }

    private(set) var bicycle: Bicycle = MSTRDevicePreference.instanceFromUserDefaults(key: Bicycle.userDefaultStoreKey()) as! Bicycle
    var person: Person


    override init() {
        UserDefaults.Settings.registerDefaults()
        Bicycle.registerDefaults()
        Person.registerDefaults()
        person = MSTRDevicePreference.instanceFromUserDefaults(key: Person.userDefaultStoreKey()) as! Person
    }

    private static func instanceFromUserDefaults(key: String) -> MSTRDevicePreferenceStoreProtocol? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! MSTRDevicePreferenceStoreProtocol
            }catch {
                return NSKeyedUnarchiver.unarchiveObject(with: data) as! MSTRDevicePreferenceStoreProtocol
            }
        }
        return nil
    }


}
