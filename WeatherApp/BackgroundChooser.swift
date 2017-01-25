import UIKit

class ImagesChooser {
  func background(_ sunrise: Date, _ sunset: Date) -> UIImage {
    var image: UIImage
    let now = Date()
    
    if (now < sunrise || now > sunset) {
      image = #imageLiteral(resourceName: "Night")
    } else {
      image = #imageLiteral(resourceName: "Day")
    }
  
    return image
  }
  
  func icon(_ code: String) -> UIImage {
    var image: UIImage
    
    switch code {
      case "01d":
        image = #imageLiteral(resourceName: "Clear")
      case "02d":
        image = #imageLiteral(resourceName: "Few Clouds")
      case "03d", "04d":
        image = #imageLiteral(resourceName: "Clouds")
      case "09d":
        image = #imageLiteral(resourceName: "Showers")
      case "10d":
        image = #imageLiteral(resourceName: "Rain")
      case "11d":
        image = #imageLiteral(resourceName: "Thunderstorms")
      case "13d", "13n":
        image = #imageLiteral(resourceName: "Snow")
      case "50d", "50n":
        image = #imageLiteral(resourceName: "Mist")
      case "01n":
        image = #imageLiteral(resourceName: "Clear_night")
      case "02n", "03n", "04n":
        image = #imageLiteral(resourceName: "Clouds_night")
      case "09n", "10n":
        image = #imageLiteral(resourceName: "Rain_night")
      case "11n":
        image = #imageLiteral(resourceName: "Thunderstorms_night")
      default:
        image = #imageLiteral(resourceName: "Clear")
    }
    
    return image
  }
}
