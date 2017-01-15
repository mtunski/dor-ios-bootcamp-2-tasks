import UIKit

import ALAccordion

class DetailsLanguagesViewController: UIViewController, ALAccordionSectionDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:))))
  }
  
  let headerView: UIView = {
    let header = DetailsHeaderView()
    
    header.titleLabel.text    = "Languages"
    header.topSeparator.alpha = 0

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
