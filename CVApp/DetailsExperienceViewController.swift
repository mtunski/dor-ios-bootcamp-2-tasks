class DetailsExperienceViewController: DetailsSectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  func setup() {
    let h = headerView as! DetailsHeaderView
    
    headerTopSeparatorAlpha = 1
    h.titleLabel.text = "Experience"
  }
}
