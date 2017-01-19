import UIKit

import Contacts

class DetailsViewController: UIViewController {
  var contact: CNContact?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(contact ?? nil)
  }
}
