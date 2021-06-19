//
//  ViewController.swift
//  Clima
//
//  Created by Ash Oldham on 04/06/2021.
//

import UIKit

class ViewController: UIViewController {

 
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  
  var weatherManager = WeatherManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //textField should report back to ViewController
    searchTextField.delegate = self
    weatherManager.delegate = self
  }
}


extension ViewController: UITextFieldDelegate {
  
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

extension ViewController: WeatherManagerDelegate {
  
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
    DispatchQueue.main.async {
      self.temperatureLabel.text = weather.temperatureString
      self.conditionImageView.image = UIImage(systemName: weather.conditionName)
      self.cityLabel.text = weather.cityName
    }
  }
  
  func didFailWithError(error: Error) {
    print(error)
  }
}

