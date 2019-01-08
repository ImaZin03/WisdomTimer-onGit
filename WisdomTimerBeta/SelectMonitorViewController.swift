//
//  SelectMonitorViewController.swift
//  WisdomTimerBeta
//
//  Created by 田中惇貴 on 2019/01/04.
//  Copyright © 2019 田中惇貴. All rights reserved.
//

import UIKit

class SelectMonitorViewController: UITableViewController {
    
    var pickerView: UIPickerView!
    
    var pickerCell: WisdomTableViewCell!
    
    var timerTableDelegate: TimerTableDelegate?
    
    // 時・分・秒のデータ
    let timeDatas = [[Int](0...23), [Int](0...59), [Int](0...59)]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func cancelButtonDidTouch(sender: AnyObject) {
        // Cancelが押されたら
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonDidTouch(sender: AnyObject) {
        // Doneが押されたら
        // 新しいタイマーを作る
        let newTimer = pickerCell.makeTimer()
        print(newTimer.initialWholeSecond)
        
        if newTimer.initialWholeSecond == 0 {
            // 秒数０、失敗、アラートビュー
        } else {
            // 秒数１以上、成功、メニュービューに追加
            let menuView = MenuViewController()
            menuView.timerArray.append(newTimer)
            
            self.dismiss(animated: true, completion: {
                self.timerTableDelegate?.updateTableView()
            })
        }
    }
    
//    These are the tableView (timePicker) Settings
//    これらはテーブルビュー(timePicker)の設定です
    
    let sections = ["Set Your Time", ""]
    let normalCells = ["Notification", "Sounds"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // テーブルビューのセクションの数
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // テーブルビューのセクションごとのセルの数
        var rows = 0
        if section == 0 {
            rows = 1
        } else if section == 1 {
            rows = normalCells.count
        }
        return rows
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // セクションのヘッダーの名前
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // テーブルビューのセルの設定
        
        if indexPath.section == 0 {
            
            pickerCell = tableView.dequeueReusableCell(withIdentifier: "WisdomTableViewCell", for: indexPath) as? WisdomTableViewCell
            pickerCell.timePicker = pickerView
            
            return pickerCell
            
        } else {
            
            var normalCell: UITableViewCell!
            normalCell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
            
            normalCell.textLabel?.text = normalCells[indexPath.row]
            if indexPath.row == 1 {
                normalCell.accessoryType = .disclosureIndicator
            }
            
            return normalCell
        }
    }

}
