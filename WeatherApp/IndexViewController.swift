import UIKit

import Keys

class IndexViewController: UIViewController {
  @IBOutlet weak var iconView: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var conditionsLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchWeatherData("Wroclaw")
  }
  
  func setupBackground(_ metadata: [String: Any]) {
    UIGraphicsBeginImageContext(self.view.frame.size)

    ImagesChooser().background(metadata["sunrise"] as! Double, metadata["sunset"] as! Double).draw(in: self.view.bounds)
    view.backgroundColor = UIColor(patternImage: UIGraphicsGetImageFromCurrentImageContext()!)
    
    UIGraphicsEndImageContext()
  }
  
  func setupConditions(_ conditions: [String: Any]) {
    let icon = ImagesChooser().icon(conditions["icon"] as! String)
    
    iconView.image = icon
    conditionsLabel.text = (conditions["description"] as! String).capitalized
  }
  
  func setupCity(_ city: String) {
    cityLabel.text = city
  }
  
  func setupTemperature(_ temperature: Int) {
    temperatureLabel.text = "\(temperature)°"
  }
  
  func setupDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMMM dd"

    dateLabel.text = dateFormatter.string(from: Date())
  }
  
  func fetchWeatherData(_ city: String) {
    let apiKey             = WeatherAppKeys().openWeatherMapAPIKey
    let baseUrl            = "http://api.openweathermap.org/data/2.5"
    let currentWeatherUrl  = "\(baseUrl)/weather?q=\(city)&units=metric&APPID=\(apiKey)"
//    let forecastWeatherUrl = "\(baseUrl)/forecast?q=\(city)&APPID=\(apiKey)"
    
    var request = URLRequest(url: URL(string: currentWeatherUrl)!)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    session.dataTask(with: request) { data, _, error in
      if  (error == nil) {
        do {
          let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
          print(parsedData)
          let weather    = parsedData["main"] as! [String: Any]
          print(weather)
          let conditions = (parsedData["weather"] as! NSArray)[0] as! [String: Any]
          print(conditions)
          let metadata   = parsedData["sys"] as! [String: Any]
          print(metadata)
          
          DispatchQueue.main.async {
            self.setupBackground(metadata)
            self.setupCity(parsedData["name"] as! String)
            self.setupDate()
            self.setupConditions(conditions)
            self.setupTemperature(weather["temp"] as! Int)
          }

        } catch {}
      }
    }.resume()
  }
}

