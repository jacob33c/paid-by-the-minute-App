//
//  ViewController.swift
//  paid-by-the-minute
//
//  Created by Jacob Fraizer on 8/25/19.
//  Copyright © 2019 Jacob Fraizer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var timer = Timer()
    var duration = 0
    var total : Float = 0.00
    var timerOn = false
    
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var hourlyRate: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func toggleTimer(on: Bool, increment: Float){
        if on == false{
                timer.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                let twoDecimalPlaces = String(format: "%.2f", self.total)
                self.moneyLabel.text = "$ \(twoDecimalPlaces)"
                self.total += increment
                print("increment = \(increment)")
                print("total = $\(self.total) ")
                self.timerOn = true
                self.startButton.backgroundColor = UIColor.red
                self.startButton.setTitle("Stop", for: .normal)
                self.hourlyRate.isHidden = true
            })
        }
        else{
                timer.invalidate()
                self.startButton.backgroundColor = UIColor.green
                self.startButton.setTitle("Start", for: .normal)
                self.timerOn = false
                self.hourlyRate.isHidden = false
        }
    }
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        if let rate = hourlyRate.text{
            if let rateNum = Float(rate){
                hourlyRate.resignFirstResponder()
                print("rate = \(rate)")
                print("rateNum = \(rateNum)")
                let increment: Float = Float(rateNum / 3600)
                toggleTimer(on: timerOn, increment: increment)
            }
        }
    }
    
    @IBAction func restartButtonPressed(_ sender: Any) {
            timer.invalidate()
            self.total = 0.00
            self.moneyLabel.text = "$0.00"
            self.timerOn = false
            self.startButton.backgroundColor = UIColor.green
            self.startButton.setTitle("Start", for: .normal)
            self.hourlyRate.text = ""
            self.hourlyRate.isHidden = false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        hourlyRate.resignFirstResponder()
        return true
    }
    
    
}
       

    
    


