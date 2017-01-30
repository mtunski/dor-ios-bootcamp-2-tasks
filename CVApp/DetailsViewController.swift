import ALAccordion

class DetailsViewController: ALAccordionController {
  override func viewDidLoad() {
    super.viewDidLoad()

    createSections()
  }

  func createSections() {
    let storyboard                      = UIStoryboard(name: "Main", bundle: Bundle.main)
    let detailsExperienceViewController = storyboard.instantiateViewController(withIdentifier: "DetailsExperienceViewController") as! DetailsSectionViewController
    let detailsEducationViewController  = storyboard.instantiateViewController(withIdentifier: "DetailsEducationViewController")  as! DetailsSectionViewController
    let detailsSkillsViewController     = storyboard.instantiateViewController(withIdentifier: "DetailsSkillsViewController")     as! DetailsSectionViewController
    let detailsLanguagesViewController  = storyboard.instantiateViewController(withIdentifier: "DetailsLanguagesViewController")  as! DetailsSectionViewController
    let detailsInterestsViewController  = storyboard.instantiateViewController(withIdentifier: "DetailsInterestsViewController")  as! DetailsSectionViewController

    detailsExperienceViewController.headerTopSeparatorAlpha                            = CGFloat(1)
    (detailsExperienceViewController.headerView as! DetailsHeaderView).titleLabel.text = "Experience"
    (detailsEducationViewController.headerView  as! DetailsHeaderView).titleLabel.text = "Education"
    (detailsSkillsViewController.headerView     as! DetailsHeaderView).titleLabel.text = "Skills"
    (detailsLanguagesViewController.headerView  as! DetailsHeaderView).titleLabel.text = "Languages"
    (detailsInterestsViewController.headerView  as! DetailsHeaderView).titleLabel.text = "Interests"

    setViewControllers(
      detailsExperienceViewController,
      detailsEducationViewController,
      detailsSkillsViewController,
      detailsLanguagesViewController,
      detailsInterestsViewController
    )
  }
}
