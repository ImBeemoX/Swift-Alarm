//
//  ViewController.swift
//  Alarm
//
//  Created by Yichuan Wang on 23/1/20.
//  Copyright © 2020 Wang Yichuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLbel: UILabel!
    
    private let log = Log()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let dateformatter = DateFormatter()

        dateformatter.dateFormat = "HH:mm:ss"// 自定义时间格式

        let time = dateformatter.string(from: Date())
        myLbel.text = time
    }
    
    func consumeLog(log: String) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm:ss"// 自定义时间格式
        myLbel.text = dateformatter.string(from: Date())
        
       }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            self?.log.requestLog{ data in
                self?.consumeLog(log: data)
            }
        }
    }
}
class Log {
    func requestLog(consume: (_ log: String) -> Void) {
        let slog = "Data from wherever"
        consume(slog)
    }
}

