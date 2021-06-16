//
//  WeatherManager.swift
//  Clima
//
//  Created by Ash Oldham on 09/06/2021.
//

import Foundation


struct WeatherManager {
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=71606a5dd0bece3cf6198a09448d2592"
  
  func fetchWeather(cityName: String) {
    let urlString = "\(weatherURL)&q=\(cityName)"
    print(urlString)
    performRequest(urlString: urlString)
  }
  
  func performRequest(urlString: String) {
    //1. create URL session
    if let url = URL(string: urlString) {
      
      //2. create URLSession
      let session = URLSession(configuration: .default)
      
      //3. give the session a task
      let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          print(error!)
          return
        }
        
        if let safeData = data {
          parseJSON(weatherData: safeData)
        }
      }
      
      //4. start the task
      task.resume()
    }
  }
  
  func parseJSON(weatherData: Data) {
    let decoder = JSONDecoder()
    do {
    let decodedData = try decoder.decode(WeatherData.self, from: weatherData)

//      print(decodedData.weather[0].description)
      let id = decodedData.weather[0].id
      let temp = decodedData.main.temp
      let name = decodedData.name
      
      let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
      
      print(weatherModel.conditionName)
      print(weatherModel.temperatureString)
    } catch {
      print(error)
    }
  }
  

}
