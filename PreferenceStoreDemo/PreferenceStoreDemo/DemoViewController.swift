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
        preference.bicycle.store {
            preference.bicycle.isLock = self.bicycleLockSwitchButton.isOn
        }
        DispatchQueue.global().async {
            self.preference.bicycle.store {
                sleep(1)
                self.preference.bicycle.fontWheel.pressure = 100
                sleep(1)
                self.preference.bicycle.backWheel.pressure = 100
            }
        }
        DispatchQueue.global().async {
            self.preference.bicycle.store {
                self.preference.bicycle.fontWheel.pressure = 1
                sleep(3)
                self.preference.bicycle.backWheel.pressure = 1
            }
        }
        updataUI()
    }

    @IBAction func changeBicycleFrontWheelPressure(_ sender: Any) {
        let bicycle = preference.bicycle
        bicycle.store(process: {bicycle.fontWheel.pressure = NSInteger(self.frontWheelPressureTextField.text ?? "-1") ?? -1})
    }

    @IBAction func changeBicycleFrontPump(_ sender: Any) {
        let bicycle = preference.bicycle
        bicycle.store(process: {
            bicycle.fontWheel.needTobePumped = self.frontWheelPumpSwitchButton.isOn
        })
    }

    @IBAction func changeBicycleBackWheelPressure(_ sender: Any) {
        preference.bicycle.store(process: {preference.bicycle.backWheel.pressure = NSInteger(self.backWheelPressureTextField.text ?? "-1") ?? -1})
    }

    @IBAction func changeBicycleBackWheelPump(_ sender: Any) {
        preference.bicycle.store {
            preference.bicycle.backWheel.needTobePumped = self.backWheelPumpSwitchButton.isOn
        }
    }

    @IBAction func changeName(_ sender: Any) {
        preference.person.store {
            preference.person.name = self.nameTextField.text ?? "default"
        }
    }

    @IBAction func changeAge(_ sender: Any) {
        preference.person.store {
            preference.person.age = NSInteger(self.ageTextField.text ?? "-1") ?? -1
        }
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
