import UIKit

class DetailsHeaderView: UIView {
  let topSeparator: DetailsSeparatorView = {
    let view = DetailsSeparatorView()
    
    view.separatorColor                            = UIColor.black.withAlphaComponent(0.5)
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  let bottomSeparator: DetailsSeparatorView = {
    let view = DetailsSeparatorView()
    
    view.separatorColor                            = UIColor.black.withAlphaComponent(0.5)
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    
    label.font                                      = UIFont.systemFont(ofSize: 17.0)
    label.textColor                                 = UIColor.black
    label.textAlignment                             = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  func setup() {
    addSubview(topSeparator)
    addSubview(titleLabel)
    addSubview(bottomSeparator)
    
    let views                      = ["topSeparator": topSeparator, "titleLabel": titleLabel, "bottomSeparator": bottomSeparator]
    let vertical                   = NSLayoutConstraint.constraints(withVisualFormat: "V:|[topSeparator(1)]-(15)-[titleLabel]-(15)-[bottomSeparator(1)]|", options: [], metrics: nil, views: views)
    let horizontal_topSeparator    = NSLayoutConstraint.constraints(withVisualFormat: "H:|[topSeparator]|", options: [], metrics: nil, views: views)
    let horizontal_titleLabel      = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[titleLabel]-15-|", options: [], metrics: nil, views: views)
    let horizontal_bottomSeparator = NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomSeparator]|", options: [], metrics: nil, views: views)
    
    addConstraints(vertical + horizontal_topSeparator + horizontal_titleLabel + horizontal_bottomSeparator)
  }
}
