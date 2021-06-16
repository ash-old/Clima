//
//  ViewController.swift
//  Clima
//
//  Created by Ash Oldham on 04/06/2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

 
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  
  var weatherManager = WeatherManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //textField should report back to ViewController
    searchTextField.delegate = self
  }

  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
//    print(searchTextField.text!)
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
//    print(searchTextField.text!)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      searchTextField.placeholder = "Search a City"
      return false
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let city = searchTextField.text {
      weatherManager.fetchWeather(cityName: city)
    }
    searchTextField.text = ""
  }
  
}

