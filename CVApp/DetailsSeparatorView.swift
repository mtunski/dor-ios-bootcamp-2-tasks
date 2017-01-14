import UIKit

class DetailsSeparatorView: UIView {
    var separatorColor: UIColor = UIColor.white { didSet { setNeedsDisplay() }}
    
    @IBInspectable var lineWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() }}
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(separatorColor.cgColor)
        context?.setLineWidth(lineWidth)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: rect.width, y: 0))
        context?.strokePath()
    }
}
