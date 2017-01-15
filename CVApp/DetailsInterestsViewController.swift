class DetailsInterestsViewController: DetailsSectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  func setup() {
    let h = headerView as! DetailsHeaderView
    
    h.topSeparator.alpha = 0
    h.titleLabel.text = "Interests"
  }
}
