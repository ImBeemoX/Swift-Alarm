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
    let dateformatter = DateFormatter()
    private let log = Log()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func consumeLog(log: String) {
        dateformatter.dateFormat = "HH:mm:ss"
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

