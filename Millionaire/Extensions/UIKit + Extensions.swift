import UIKit

extension UIStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        spacing: CGFloat = 10,
        alignment: UIStackView.Alignment = .center
    ){
        self.init()
        
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        self.alignment = alignment
    }
}

extension UILabel {
    
    convenience init(
        text: String,
        font: UIFont = .systemFont(ofSize: 24, weight: .medium)
    ) {
        self.init()
        
        self.numberOfLines = 0
        self.text = text
        self.font = font
        self.textColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
    }
}

extension UIImageView {
    convenience init(withImage imageName: UIImage?) {
        self.init()
        
        self.isUserInteractionEnabled = true
        self.image = imageName ?? UIImage()
        self.contentMode = .scaleAspectFit
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false

    }
}

