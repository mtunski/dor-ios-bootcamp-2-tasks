import UIKit

import ALAccordion
import SwiftHEXColors

class DetailsExperienceViewController: UIViewController, ALAccordionSectionDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:))))
  }
  
  let headerView: UIView = {
    let header = DetailsHeaderView()
    
    header.titleLabel.text = "Experience"
    
    return header
  }()
  
  func sectionWillOpen(animated: Bool) {
    let duration = animated ? accordionController!.animationDuration : 0.0
    
    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
      let h = self.headerView as! DetailsHeaderView
      h.topSeparator.alpha = 0
      h.backgroundColor = UIColor(hex: 0xe3e3e3)
    }, completion: nil)
  }
  
  func sectionWillClose(animated: Bool) {
    let duration = animated ? accordionController!.animationDuration : 0.0
    
    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
      let h = self.headerView as! DetailsHeaderView
      h.topSeparator.alpha = 1
      h.backgroundColor = UIColor(hex: 0xffffffff)
    }, completion: nil)
  }
  
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
