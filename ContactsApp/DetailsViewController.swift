import UIKit

import Contacts

class DetailsViewController: UIViewController {
  let contactsStore = CNContactStore()
  var contact: CNContact?
  
  @IBOutlet weak var contactPhone: UILabel!
  @IBOutlet weak var contactName: UILabel!
  @IBOutlet weak var contactEmail: UILabel!
  @IBOutlet weak var contactImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadContact()
  }
  
  func loadContact() {
    if (contact != nil) {
      do {
        let keysToFetch = [

          CNContactPhoneNumbersKey,
          CNContactEmailAddressesKey,
          CNContactPostalAddressesKey,
          CNContactImageDataAvailableKey,
          CNContactImageDataKey
        ].map { $0 as CNKeyDescriptor }
        
        let detailedContact = try contactsStore.unifiedContact(withIdentifier: contact!.identifier, keysToFetch: keysToFetch)
        
        DispatchQueue.main.async {
          if detailedContact.imageDataAvailable {
            if let data = detailedContact.imageData {
              self.contactImage.image = UIImage(data: data)
            }
          }
          
          self.contactName.text = "\(self.contact!.givenName) \(self.contact!.familyName)"
          self.contactPhone.text = detailedContact.phoneNumbers.first?.value.stringValue
          self.contactEmail.text = detailedContact.emailAddresses.first?.value as? String
        }
      } catch {}
    }
  }
}
