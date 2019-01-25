//
//  DemoViewController.swift
//  PreferenceStoreDemo
//
//  Created by doxie on 1/11/19.
//  Copyright © 2019 Xie. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    @IBOutlet weak var folderCachingSwitchButton: UISwitch!
    @IBOutlet weak var netWorkTimeOutTextField: UITextField!
    @IBOutlet weak var logLevelTextField: UITextField!
    @IBOutlet weak var bicycleLockSwitchButton: UISwitch!
    @IBOutlet weak var frontWheelPressureTextField: UITextField!
    @IBOutlet weak var frontWheelPumpSwitchButton: UISwitch!
    @IBOutlet weak var backWheelPressureTextField: UITextField!
    @IBOutlet weak var backWheelPumpSwitchButton: UISwitch!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!

    var preference = MSTRDevicePreference.devicePreference

    override func viewDidLoad() {
        super.viewDidLoad()
        updataUI()
        // Do any additional setup after loading the view.
    }

    func updataUI() {
        self.folderCachingSwitchButton.isOn = preference.folderCaching
        self.netWorkTimeOutTextField.text = String(preference.networkTimeOut)
        self.logLevelTextField.text = preference.logLevel
        self.bicycleLockSwitchButton.isOn = preference.bicycle.isLock
        self.frontWheelPressureTextField.text = String(preference.bicycle.fontWheel.pressure)
        self.frontWheelPumpSwitchButton.isOn = preference.bicycle.fontWheel.needTobePumped
        self.backWheelPressureTextField.text = String(preference.bicycle.backWheel.pressure)
        self.backWheelPumpSwitchButton.isOn = preference.bicycle.backWheel.needTobePumped
        self.nameTextField.text = preference.person.name
        self.ageTextField.text = String(preference.person.age)
    }

    @IBAction func changeFolderCaching(_ sender: Any) {
        preference.folderCaching = self.folderCachingSwitchButton.isOn
    }

    @IBAction func changeNetWorkTimeOut(_ sender: Any) {
        preference.networkTimeOut = NSInteger(self.netWorkTimeOutTextField.text ?? "-1") ?? -1
    }

    @IBAction func changeLogLevel(_ sender: Any) {
        preference.logLevel = self.logLevelTextField.text ?? "default"
    }

    @IBAction func changeBicycleLock(_ sender: Any) {
        preference.bicycle.isLock = self.bicycleLockSwitchButton.isOn
        preference.bicycle.store()
    }

    @IBAction func changeBicycleFrontWheelPressure(_ sender: Any) {
        let bicycle = preference.bicycle
        bicycle.fontWheel.pressure = NSInteger(self.frontWheelPressureTextField.text ?? "-1") ?? -1
        bicycle.store()
    }

    @IBAction func changeBicycleFrontPump(_ sender: Any) {
        let bicycle = preference.bicycle.copy() as! Bicycle
        bicycle.fontWheel.needTobePumped = self.frontWheelPumpSwitchButton.isOn
        bicycle.store()
    }

    @IBAction func changeBicycleBackWheelPressure(_ sender: Any) {
        preference.bicycle.backWheel.pressure = NSInteger(self.backWheelPressureTextField.text ?? "-1") ?? -1
        preference.bicycle.store()
    }

    @IBAction func changeBicycleBackWheelPump(_ sender: Any) {
        preference.bicycle.backWheel.needTobePumped = self.backWheelPumpSwitchButton.isOn
        preference.bicycle.store()
    }

    @IBAction func changeName(_ sender: Any) {
        preference.person.name = self.nameTextField.text ?? "default"
        preference.person.store()
    }

    @IBAction func changeAge(_ sender: Any) {
        preference.person.age = NSInteger(self.ageTextField.text ?? "-1") ?? -1
        preference.person.store()
    }
    
    @IBAction func refresh(_ sender: Any) {
        updataUI()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
