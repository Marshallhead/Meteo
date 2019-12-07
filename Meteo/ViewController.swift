//
//  ViewController.swift
//  Meteo
//
//  Created by Macbook on 07/12/2019.
//  Copyright © 2019 Marshall Lawal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ConditionImageView: UIImageView!
    @IBOutlet weak var TemperatureLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    
    
    @IBOutlet weak var SearchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func locationPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
    }
    
    
}

