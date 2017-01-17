import UIKit

import Contacts

class IndexViewController: UIViewController {
  let contactsStore = CNContactStore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadContacts()
  }
  
  func loadContacts() {
    switch CNContactStore.authorizationStatus(for: .contacts) {
    case .notDetermined:
      authorizeContacts()
    case .denied, .restricted:
      self.showUnauthorizedAlert("Please allow the app to access your contacts through the Settings.")
    case .authorized:
      fetchContacts()
    }
  }
  
  func authorizeContacts() {
    contactsStore.requestAccess(for: .contacts) {
      (authorized, _) -> Void in
        if authorized {
          self.fetchContacts()
        } else {
          self.showUnauthorizedAlert("Please allow the app to access your contacts through the Settings.")
        }
    }
  }
  
  func fetchContacts() {
    let keysToFetch = [
      CNContactGivenNameKey,
      CNContactFamilyNameKey
      ].map { $0 as CNKeyDescriptor }
    
    let fetch = CNContactFetchRequest(keysToFetch: keysToFetch)
    fetch.unifyResults = true
    fetch.predicate    = nil
    
    try? contactsStore.enumerateContacts(with: fetch) {
      (contact, _) -> Void in
        print(contact)
    }
  }
  
  func showUnauthorizedAlert(_ message: String) {
    let alert = UIAlertController(
      title:          "ContactsApp",
      message:        message,
      preferredStyle: UIAlertControllerStyle.alert
    )
    
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    
    DispatchQueue.main.async { self.present(alert, animated: true, completion: nil) }
  }
}