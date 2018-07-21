//
//  ReadingViewController.swift
//  Book
//
//  Created by Fabio Barboza on 7/21/18.
//  Copyright © 2018 Rodrigo Leite. All rights reserved.
//

import UIKit

class ReadingViewController: UIViewController {

  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var startButton: UIButton!
  var countdownTimer: Timer?
  var totalTime = 0
  var isReading: Bool = false
  
  override func viewDidLoad() {
        super.viewDidLoad()
  }

  @IBAction func changeTimerValue(_ sender: UISlider) {
    totalTime = Int(sender.value) * 60
    updateTime()
  }
  
  func startTimer() {
    startButton.setTitle("Cancel", for: .normal)
    slider.isEnabled = false
    slider.alpha = 0.5
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
    slider.isEnabled = true
    slider.alpha = 1.0
    slider.value = 0.0
    timerLabel.text = "\(timeFormatted(totalTime))"
    startButton.setTitle("Start", for: .normal)
  }
  
  func timeFormatted(_ totalSeconds: Int) -> String {
    guard totalSeconds > 0 else {
      return "00:00"
    }
    let seconds: Int = totalSeconds % 60
    let minutes: Int = (totalSeconds / 60) % 60
    return String(format: "%02d:%02d", minutes, seconds)
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

}
