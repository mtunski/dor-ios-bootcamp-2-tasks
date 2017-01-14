import UIKit

import ALAccordion

class DetailsSkillsViewController: UIViewController, ALAccordionSectionDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:))))
  }
  
  let headerView: UIView = {
    let header = DetailsHeaderView()
    
    header.titleLabel.text = "Skills"
    
    return header
  }()
  
  func headerTapped(_ recognizer: UITapGestureRecognizer) {
    if let sectionIndex = accordionController?.sectionIndexForViewController(self) {
      if accordionController!.openSectionIndex == sectionIndex {
        accordionController?.closeSectionAtIndex(sectionIndex, animated: true)
      } else {
        accordionController?.openSectionAtIndex(sectionIndex, animated: true)
      }
    }
  }
}
