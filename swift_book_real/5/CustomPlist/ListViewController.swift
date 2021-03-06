//
//  ListViewController.swift
//  Chapter05-CustomPlist
//
//  Created by ๊น๊ธฐ๋ฆผ on 2021/12/14.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    var accountlist = [String]()
    // ๐ฅ๋ฉ์ธ ๋ฒ๋ค์ ์ ์๋ PList ๋ด์ฉ์ ์ ์ฅํ  ๋์๋๋ฆฌ
    var defaultPList : NSDictionary!
    
    
    override func viewDidLoad() {
        // ๐ฅ ๋ฉ์ธ ๋ฒ๋ค์ UserInfo.plist๊ฐ ํฌํจ๋์ด ์์ผ๋ฉด ์ด๋ฅผ ์ฝ์ด์ ๋์๋๋ฆฌ์ ๋ด๋๋ค.
        if let defaultPListPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist") {
            self.defaultPList = NSDictionary(contentsOfFile: defaultPListPath)
        }
        let picker = UIPickerView()
        
        // (1) ํผ์ปค ๋ทฐ์ ๋ธ๋ฆฌ๊ฒ์ดํธ ๊ฐ์ฒด ์ง์ 
        picker.delegate = self
        // (2) account ํ์คํธ ํ๋ ์๋ ฅ ๋ฐฉ์์ ๊ฐ์ ํค๋ณด๋ ๋์  ํผ์ปค ๋ทฐ๋ก ์ค์ 
        self.account.inputView = picker
        
        // 1๏ธโฃ ํด ๋ฐ ๊ฐ์ฒด ์ ์
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = .lightGray
        // ์ก์ธ์๋ฆฌ ๋ทฐ ์์ญ์ ํด ๋ฐ๋ฅผ ํ์
        self.account.inputAccessoryView = toolbar
        
        // 2๏ธโฃ ํด ๋ฐ์ ๋ค์ด๊ฐ ๋ซ๊ธฐ ๋ฒํผ
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        
        // 3๏ธโฃ ๊ฐ๋ณ ํญ ๋ฒํผ ์ ์
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
     
        // 4๏ธโฃ ์ ๊ท ๊ณ์  ๋ฑ๋ก ๋ฒํผ
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        // ๋ฒํผ์ ํด ๋ฐ์ ์ถ๊ฐ
        toolbar.setItems([new, flexSpace, done], animated: true)
        
        // 5๏ธโฃ ๊ธฐ๋ณธ ์ ์ฅ์ ๊ฐ์ฒด ๋ถ๋ฌ์ค๊ธฐ
        let plist = UserDefaults.standard
        
        // ๋ถ๋ฌ์จ ๊ฐ์ ์ค์ 
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        
        // ๐คก
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        self.accountlist = accountlist
        if let account = plist.string(forKey: "selectedAccount") {
            self.account.text = account
        }
        
        // ๐์ฌ์ฉ์ ๊ณ์ ์ ๊ฐ์ด ๋น์ด ์๋ค๋ฉด ๊ฐ์ ์ค์ ํ๋ ๊ฒ์ ๋ง๋๋ค.
        if (self.account.text?.isEmpty)! {
            self.account.placeholder = "๋ฑ๋ก๋ ๊ณ์ ์ด ์์ต๋๋ค."
            self.gender.isEnabled = false
            self.married.isEnabled = false
        }
        
        // ๋ด๋น๊ฒ์ด์ ๋ฐ์ newAccount ๋ฉ์๋์ ์ฐ๊ฒฐ๋ ๋ฒํผ์ ์ถ๊ฐํ๋ค.
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
    }
    
    @objc func pickerDone(_ sender: Any) {
        self.view.endEditing(true)
        
        
        // โจ ์ ํ๋ ๊ณ์ ์ ๋ํ ์ปค์คํ ํ๋กํผํฐ ํ์ผ์ ์ฝ์ด์ ์ธํํ๋ค.
        if let _account = self.account.text {
            let customPlist = "\(_account).plist" // ์ฝ์ด์ฌ ํ์ผ๋ช
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
    }
    
    @objc func newAccount(_ sender: Any) {
        self.view.endEditing(true) // ์ผ๋จ ์ด๋ ค์๋ ์๋ ฅ์ฉ ๋ทฐ๋ถํฐ ๋ซ์์ค๋ค.
        
        // ์๋ฆผ์ฐฝ ๊ฐ์ฒด ์์ฑ
        let alert = UIAlertController(title: "์ ๊ณ์ฉก์ ์๋ ฅํ์ธ์", message: nil, preferredStyle: .alert)
        
        // ์๋ ฅํผ ์ถ๊ฐ
        alert.addTextField {
            $0.placeholder = "ex) abc@gmail.com"
        }
        
        // ๋ฒํผ ๋ฐ ์ก์ ์ ์
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
            if let account = alert.textFields?[0].text {
//                // ๊ณ์  ๋ชฉ๋ก ๋ฐฐ์ด์ ์ถ๊ฐํ๋ค.
//                self.accountlist.append(account)
//                // ๊ณ์  ํ์คํธ ํ๋์ ํ์ํ๋ค.
//                self.account.text = account
//
//                // ์ปจํธ๋กค ๊ฐ์ ๋ชจ๋ ์ด๊ธฐํํ๋ค.
//                self.name.text = ""
//                self.gender.selectedSegmentIndex = 0
//                self.married.isOn = false
//
//                // ๐ ๊ณ์  ๋ชฉ๋ก์ ์ ์ฅํ๋ค.
//                let plist = UserDefaults.standard
//
//                // ๋ฐฉ๋ฒ1. ํต์งธ๋ก
////                plist.set(self.accountlist, forKey: "accountlist")
//                // ๋ฐฉ๋ฒ2. ๋ฐฐ์ด์ ๋ถ๋ฌ์์ ์ ์ฅ
//                var savedAccountlist = plist.array(forKey: "accountlist") ?? [String]()
//                savedAccountlist.append(account)
//                plist.set(savedAccountlist, forKey: "accountlist")
//                /*-----*/
//
//                // ๐คก
//                plist.set(account, forKey: "selectedAccount")
//                plist.synchronize()
                
                // โจ ์ปค์คํplist์ฌ์ฉ
                self.account.text = account
                let customPlist = "\(account).plist" // ์ฝ์ด์ฌ ํ์ผ๋ช
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let path = paths[0] as NSString
                let clist = path.strings(byAppendingPaths: [customPlist]).first!
                let data = NSDictionary(contentsOfFile: clist)
                
                self.name.text = data?["name"] as? String
                self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
                self.married.isOn = data?["married"] as? Bool ?? false
                
                // ๐์๋ ฅ ํญ๋ชฉ์ ํ์ฑํํ๋ค.
                self.gender.isEnabled = true
                self.married.isEnabled = true
            }
        })
        // ์๋ฆผ์ฐฝ ์คํ
        self.present(alert, animated: false, completion: nil)
    }
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex // 0 ์ด๋ฉด ๋จ์, 1 ์ด๋ฉด ์ฌ์
        
//        let plist = UserDefaults.standard // ๊ธฐ๋ณธ ์ ์ฅ์ ๊ฐ์ฒด๋ฅผ ๊ฐ์ ธ์จ๋ค.
//        plist.set(value, forKey: "gender") // "gender"๋ผ๋ ํค๋ก ๊ฐ์ ์ง์ ํ๋ค.
//        plist.synchronize() // ๋๊ธฐํ ์ฒ๋ฆฌ
        // โจ ์ ์ฅ ๋ก์ง ์์
        let customPlist = "\(self.account.text!).plist" // ์ฝ์ด์ฌ ํ์ผ๋ช
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
//        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList) // ๐ฅ
        
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
        
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        
//        let plist = UserDefaults.standard
//        plist.set(value, forKey: "married")
//        plist.synchronize()
        // โจ ์ ์ฅ ๋ก์ง ์์
        let customPlist = "\(self.account.text!).plist" // ์ฝ์ด์ฌ ํ์ผ๋ช
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
//        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)// ๐ฅ
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        
        print("custom plist =\(plist)")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && !(self.account.text?.isEmpty)! { // ๋ ๋ฒ์งธ ์์ด ํด๋ฆญ๋์์ ๋์๋ง
            // ์๋ ฅ์ด ๊ฐ๋ฅํ ์๋ฆผ์ฐฝ์ ๋์ ์ด๋ฆ์ ์์ ํ  ์ ์๋๋ก ํ๋ค.
            let alert = UIAlertController(title: nil, message: "์ด๋ฆ์ ์๋ ฅํ์ธ์", preferredStyle: .alert)
            alert.addTextField {
                $0.text = self.name.text // name ๋ ์ด๋ธ์ ํ์คํธ๋ฅผ ์๋ ฅํผ์ ๊ธฐ๋ณธ๊ฐ์ผ๋ก ๋ฃ์ด์ค๋ค.
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default) {(_) in
                // ์ฌ์ฉ์๊ฐ OK ๋ฒํผ์ ๋๋ฅด๋ฉด ์๋ ฅ ํ๋์ ์๋ ฅ๋ ๊ฐ์ ์ ์ฅํ๋ค.
                let value = alert.textFields?[0].text
                
                // โจ ์ ์ฅ ๋ก์ง ์์
                let customPlist = "\(self.account.text!).plist" // ์ฝ์ด์ฌ ํ์ผ๋ช
                
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let path = paths[0] as NSString
                let plist = path.strings(byAppendingPaths: [customPlist]).first!
//                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)// ๐ฅ
                
                data.setValue(value, forKey: "name")
                data.write(toFile: plist, atomically: true)
                
                self.name.text = value
            })
            // ์๋ฆผ์ฐฝ ๋์
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    
    // ์์ฑํ  ์ปดํฌ๋ํธ์ ๊ฐ์๋ฅผ ์ ์ํฉ๋๋ค.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ์ง์ ๋ ์ปดํฌ๋ํธ๊ฐ ๊ฐ์ง ๋ชฉ๋ก์ ๊ธธ์ด๋ฅผ ์ ์ํฉ๋๋ค.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    
    // ์ง์ ๋ ์ปดํฌ๋ํธ์ ๋ชฉ๋ก ๊ฐ ํ์ ์ถ๋ ฅ๋  ๋ด์ฉ์ ์ ์ํฉ๋๋ค.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }
    
    // ์ง์ ๋ ์ปดํฌ๋ํธ์ ๋ชฉ๋ก ๊ฐ ํ์ ์ฌ์ฉ์๊ฐ ์ ํํ์ ๋ ์คํํ  ์ก์์ ์ ์ํฉ๋๋ค.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // (1) ์ ํ๋ ๊ณ์ ๊ฐ์ ํ์คํธ ํ๋์ ์๋ ฅ
        let account = self.accountlist[row]
        self.account.text = account
        
        // (2) ์๋ ฅ ๋ทฐ๋ฅผ ๋ซ์
//        self.view.endEditing(true) => "Done"๋ฒํผ์์ ์ฒ๋ฆฌ
        
        // ๐คก ์ฌ์ฉ์๊ฐ ๊ณ์ ์ ์์ฑํ๋ฉด ์ด ๊ณ์ ์ ์ ํํ ๊ฒ์ผ๋ก ๊ฐ์ฃผํ๊ณ  ์ ์ฅ
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
    }
}
