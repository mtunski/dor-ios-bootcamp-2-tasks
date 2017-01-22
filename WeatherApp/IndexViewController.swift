import UIKit

import SwiftHEXColors
import Keys

class IndexViewController: UIViewController {
  @IBOutlet weak var iconView: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var conditionsLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var forecastsStackView: UIStackView!
  
  @IBAction func cityTextFieldPrimaryActionTriggered(_ sender: Any) {
  
    print(cityTextField.text!)
    cityTextField.resignFirstResponder()
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cityTextField.backgroundColor = UIColor(hex: 0x000000, alpha: 0.5)

    cityTextField.attributedPlaceholder =
      NSAttributedString(string: "Enter city…", attributes: [NSForegroundColorAttributeName : UIColor.white])
    
    fetchCurrentWeather("Wroclaw")
    fetchForecast("Wroclaw")
  }
  
  func setupBackground(_ metadata: [String: Any]) {
    UIGraphicsBeginImageContext(self.view.frame.size)

    ImagesChooser().background(metadata["sunrise"] as! Double, metadata["sunset"] as! Double).draw(in: self.view.bounds)
    view.backgroundColor = UIColor(patternImage: UIGraphicsGetImageFromCurrentImageContext()!)
    
    UIGraphicsEndImageContext()
  }
  
  func setupConditions(_ conditions: [String: Any]) {
    conditionsLabel.text = (conditions["description"] as! String).capitalized
    setupIcon(iconView, conditions)
  }
  
  func setupIcon(_ view: UIImageView, _ conditions: [String: Any]) {
    let icon = ImagesChooser().icon(conditions["icon"] as! String)
    view.image = icon
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
  
  func fetchCurrentWeather(_ city: String) {
    let apiKey             = WeatherAppKeys().openWeatherMapAPIKey
    let baseUrl            = "http://api.openweathermap.org/data/2.5"
    let currentWeatherUrl  = "\(baseUrl)/weather?q=\(city)&units=metric&APPID=\(apiKey)"
    
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
  
  func fetchForecast(_ city: String) {
    let apiKey      = WeatherAppKeys().openWeatherMapAPIKey
    let baseUrl     = "http://api.openweathermap.org/data/2.5"
    let forecastUrl = "\(baseUrl)/forecast?q=\(city)&units=metric&APPID=\(apiKey)"
    
    var request = URLRequest(url: URL(string: forecastUrl)!)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    session.dataTask(with: request) { data, _, error in
      if  (error == nil) {
        do {
          let parsedData = try (JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any])["list"] as! NSArray
          let forecasts = parsedData.objects(at: [0, 1, 2, 3, 4])
          forecasts.enumerated().forEach({ index, forecast in 
            
            if let forecast = (forecast as? [String: Any]) {
              let hour = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: forecast["dt"] as! Double))
              let temperature = ((forecast["main"] as! [String: Any])["temp"] as! Int)
              let conditions = (forecast["weather"] as! NSArray)[0] as! [String: Any]

              DispatchQueue.main.async {
                (self.forecastsStackView.subviews[index].subviews[0] as! UILabel).text = "\(hour)"
                self.setupIcon((self.forecastsStackView.subviews[index].subviews[1] as! UIImageView), conditions)
                (self.forecastsStackView.subviews[index].subviews[2] as! UILabel).text = "\(temperature)°"
              }
            }
          })          
        } catch {}
      }
    }.resume()
  }
}

