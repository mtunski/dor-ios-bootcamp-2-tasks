import UIKit

import SwiftHEXColors

class IndexViewController: UIViewController {
  let apiClient = OpenWeatherMapAPIClient()
    
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentWeatherImage: UIImageView!
  @IBOutlet weak var currentConditionsLabel: UILabel!
  @IBOutlet weak var currentTemperatureLabel: UILabel!
  @IBOutlet weak var forecastStackView: UIStackView!
  @IBOutlet weak var cityField: UITextField!
  @IBOutlet weak var editingTipStackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCityPicker()
    setupCurrentWeather("Wroclaw")
    setupForecast("Wroclaw")
  }
  
  func setupCityPicker() {
    cityLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cityLabelTapped)))
  }
  
  func cityLabelTapped() {
    cityField.becomeFirstResponder()
    cityLabel.isHidden           = true
    editingTipStackView.isHidden = true
    cityField.isHidden           = false
    cityField.text               = cityLabel.text
  }
  
  @IBAction func cityFieldPrimaryActionTriggered(_ sender: Any) {
    cityField.resignFirstResponder()
    cityLabel.isHidden           = false
    editingTipStackView.isHidden = false
    cityField.isHidden           = true
    cityLabel.text               = cityField.text
    
    self.setupCurrentWeather(cityLabel.text!)
    self.setupForecast(cityLabel.text!)
  }

  func setupIcon(_ view: UIImageView, _ code: String) {
    view.image = ImagesChooser().icon(code)
  }
  
  func setupBackground(_ sunrise: Date, _ sunset: Date) {
    UIGraphicsBeginImageContext(self.view.frame.size)
    ImagesChooser().background(sunrise, sunset).draw(in: self.view.bounds)
    view.backgroundColor = UIColor(patternImage: UIGraphicsGetImageFromCurrentImageContext()!)
    UIGraphicsEndImageContext()
  }
  
  func setupTemperature(_ label: UILabel, _ temperature: Int) {
    label.text = "\(temperature)°"
  }

  func setupDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMMM dd"
    dateLabel.text = dateFormatter.string(from: Date())
  }
  
  func setupCurrentWeather(_ city: String) {
    apiClient.currentWeather(city) { result in
      switch result {
      case .Success(let json):
        let weather = Weather(json)
        
        DispatchQueue.main.async {
          self.setupBackground(weather.meta["sunrise"] as! Date, weather.meta["sunset"] as! Date)
          self.cityLabel.text = weather.city
          self.setupDate()
          self.setupIcon(self.currentWeatherImage, weather.meta["icon"] as! String)
          self.setupTemperature(self.currentTemperatureLabel, weather.temperature)
          self.currentConditionsLabel.text = weather.conditions
        }
        break
      case .Error(let message):
        print(message)
        break
      }
    }
  }
  
  func setupForecast(_ city: String) {
    apiClient.forecast(city) { result in
      switch result {
      case .Success(let json):
        json["list"].arrayValue.prefix(5).enumerated().forEach({ index, forecast in
          let weather          = Weather(forecast)
          let hourLabel        = self.forecastStackView.subviews[index].subviews[0] as! UILabel
          let conditionsImage  = self.forecastStackView.subviews[index].subviews[1] as! UIImageView
          let temperatureLabel = self.forecastStackView.subviews[index].subviews[2] as! UILabel
          
          DispatchQueue.main.async {
            hourLabel.text = "\(Calendar.current.component(.hour, from: weather.dateTime))"
            self.setupIcon(conditionsImage, weather.meta["icon"] as! String)
            self.setupTemperature(temperatureLabel, weather.temperature)
          }
        })
        break
      case .Error(let message):
        print(message)
        break
      }
    }
  }
}

