import Keys
import SwiftyJSON

enum Result {
  case Success(JSON)
  case Error(String)
}

class OpenWeatherMapAPIClient {
  let apiKey  = WeatherAppKeys().openWeatherMapAPIKey
  
  func currentWeather(_ city: String, _ callback: @escaping (Result) -> ()) {
    call("weather", city, callback)
  }
  
  func forecast(_ city: String, _ callback: @escaping (Result) -> ()) {
    call("forecast", city, callback)
  }

  private func call(_ method: String, _ city: String, _ callback: @escaping (Result) -> ()) {
    let urlString = "http://api.openweathermap.org/data/2.5/\(method)?q=\(city)&units=metric&APPID=\(apiKey)".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
    var request   = URLRequest(url: URL(string: urlString)!)
    
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      if (error == nil && data != nil) {
        callback(Result.Success(JSON(data: data!)))
      } else {
        callback(Result.Error(error.debugDescription))
      }
    }.resume()
  }
}
