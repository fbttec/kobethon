//
//  ReadingViewController.swift
//  Book
//
//  Created by Fabio Barboza on 7/21/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import UIKit

class ReadingViewController: UIViewController, CircularSliderDelegate {
    @IBOutlet weak var circularSlider: CircularSlider!
    @IBOutlet weak var btReading: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var countdownTimer: Timer?
    var totalTime = 0
    var isReading: Bool = false
    var book: Book?
    @IBOutlet weak var imgBook: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circularSlider.delegate = self
        btReading.layer.cornerRadius = btReading.frame.height/2
    }
    
    @IBAction func changeTimerValue(_ sender: UISlider) {
        totalTime = Int(sender.value) * 60
        updateTime()
    }
    
    func startTimer() {
        startButton.setTitle("Cancel", for: .normal)
        circularSlider.isUserInteractionEnabled = false
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer?.invalidate()
        totalTime = 0
        circularSlider.isUserInteractionEnabled = true
        circularSlider.value = 0.0
        timerLabel.text = "\(timeFormatted(totalTime))"
        startButton.setTitle("Start", for: .normal)
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        guard totalSeconds > 0 else {
          return "00:00:00"
        }
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hour: Int = (totalSeconds / 3600)
        return String(format: "%02d:%02d:%02d", hour, minutes, seconds)
    }
    
    @IBAction func startTimerPressed(_ sender: UIButton) {
        guard totalTime > 0 else { return }
        isReading = !isReading
        if isReading {
            startTimer()
        } else {
            endTimer()
        }
    }
    
    //mark - circular delegate
    func circularSlider(_ circularSlider: CircularSlider, valueForValue value: Float) -> Float {
        totalTime = Int(value) * 60
        changeImage(value: value)
        updateTime()
        return value
    }
    
    func changeImage(value: Float) {
        if (value / circularSlider.maximumValue) < 0.33 {
            imgBook.image = #imageLiteral(resourceName: "bookSmall")
        } else if (value / circularSlider.maximumValue) < 0.77 {
            imgBook.image = #imageLiteral(resourceName: "bookMedium")
        } else {
            imgBook.image = #imageLiteral(resourceName: "bookLarge")
        }
    }
}

