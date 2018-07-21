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

  override func viewDidLoad() {
        super.viewDidLoad()
  }

  @IBAction func changeTimerValue(_ sender: UISlider) {
    timerLabel.text = "\(Int(sender.value))"+":00"
  }

}
