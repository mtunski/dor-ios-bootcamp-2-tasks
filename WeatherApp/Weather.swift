import SwiftyJSON

struct Weather {
  var city: String
  var dateTime: Date
  var temperature: Int
  var conditions: String
  var meta = [String: Any]()
  
  init(_ data: JSON) {
    self.city        = data["name"].stringValue
    self.dateTime    = Date(timeIntervalSince1970: data["dt"].doubleValue)
    self.temperature = data["main"]["temp"].intValue
    self.conditions  = data["weather"][0]["description"].stringValue.capitalized
    
    self.meta["icon"]    = data["weather"][0]["icon"].stringValue
    self.meta["sunrise"] = Date(timeIntervalSince1970: data["sys"]["sunrise"].doubleValue)
    self.meta["sunset"]  = Date(timeIntervalSince1970: data["sys"]["sunset"].doubleValue)
  }
}
