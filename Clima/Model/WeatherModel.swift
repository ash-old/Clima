//
//  WeatherModel.swift
//  Clima
//
//  Created by Ash Oldham on 16/06/2021.
//

import Foundation

struct WeatherModel {
  let conditionId: Int
  let cityName: String
  let temperature: Double
  
  var conditionName: String {
    switch conditionId {
    case 200...232:
      return "cloud.bolt.rain"
    case 300...321:
      return "cloud.drizzle"
    case 500...531:
      return "cloud.rain"
    case 600...622:
      return "snow"
    case 701...781:
      return "cloud.fog"
    case 800:
      return "sun.min"
    case 801...804:
      return "sun.max"
    default:
      return "cloud"
    }
  }
  
}