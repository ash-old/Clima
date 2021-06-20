//
//  WeatherManager.swift
//  Clima
//
//  Created by Ash Oldham on 09/06/2021.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
  func didFailWithError(error: Error)
}

struct WeatherManager {
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=71606a5dd0bece3cf6198a09448d2592"
  
  var delegate: WeatherManagerDelegate?
  
  func fetchWeather(cityName: String) {
    let urlString = "\(weatherURL)&q=\(cityName)"
    print("city", urlString)
    performRequest(with: urlString)
  }
  
  func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
    print("coordinates", urlString)
    performRequest(with: urlString)
  }
  
  func performRequest(with urlString: String) {
    //1. create a URL
    if let url = URL(string: urlString) {
      
      //2. create a URLSession
      let session = URLSession(configuration: .default)
      
      //3. give the session a task
      let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          delegate?.didFailWithError(error: error!)
          return
        }
        
        if let safeData = data {
          if let weather = parseJSON(safeData) {
            delegate?.didUpdateWeather(self, weather: weather)
          }
        }
      }
      
      //4. start the task
      task.resume()
    }
  }
  
  func parseJSON(_ weatherData: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    do {
    let decodedData = try decoder.decode(WeatherData.self, from: weatherData)

//      print(decodedData.weather[0].description)
      let id = decodedData.weather[0].id
      let temp = decodedData.main.temp
      let name = decodedData.name
      
      let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
      return weatherModel
      
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }
  

}
