import ALAccordion

class DetailsViewController: ALAccordionController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createSections()
  }
  
  func createSections() {
    let storyboard                      = UIStoryboard(name: "Main", bundle: Bundle.main)
    let detailsExperienceViewController = storyboard.instantiateViewController(withIdentifier: "DetailsExperienceViewController") as! DetailsExperienceViewController
    let detailsEducationViewController  = storyboard.instantiateViewController(withIdentifier: "DetailsEducationViewController")  as! DetailsEducationViewController
    let detailsSkillsViewController     = storyboard.instantiateViewController(withIdentifier: "DetailsSkillsViewController")     as! DetailsSkillsViewController
    let detailsLanguagesViewController  = storyboard.instantiateViewController(withIdentifier: "DetailsLanguagesViewController")  as! DetailsLanguagesViewController
    let detailsInterestsViewController  = storyboard.instantiateViewController(withIdentifier: "DetailsInterestsViewController")  as! DetailsInterestsViewController
    
    setViewControllers(
      detailsExperienceViewController,
      detailsEducationViewController,
      detailsSkillsViewController,
      detailsLanguagesViewController,
      detailsInterestsViewController
    )
  }
}
