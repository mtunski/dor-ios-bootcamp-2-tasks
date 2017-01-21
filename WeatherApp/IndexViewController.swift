import UIKit

import Keys

class IndexViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchWeatherData("Wroclaw")
  }
  
  func fetchWeatherData(_ city: String) {
    let apiKey             = WeatherAppKeys().openWeatherMapAPIKey
    let baseUrl            = "http://api.openweathermap.org/data/2.5"
    let currentWeatherUrl  = "\(baseUrl)/weather?q=\(city)&APPID=\(apiKey)"
//    let forecastWeatherUrl = "\(baseUrl)/forecast?q=\(city)&APPID=\(apiKey)"
    
    var request = URLRequest(url: URL(string: currentWeatherUrl)!)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    session.dataTask(with: request) { data, _, error in
      if  (error == nil) {
        do {
          let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
          let weather = parsedData["main"] as! [String:Any]
          print(weather)
        } catch {}
      }
    }.resume()
  }
}

