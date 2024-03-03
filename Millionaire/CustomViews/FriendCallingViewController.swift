import UIKit
import SnapKit

class FriendCallingСustomView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "FriendCalling")
        return imageView
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let answers = ["A", "B", "C", "D"]
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gameBG")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        layer.cornerRadius = 12
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        addSubview(backgroundImage)
        addSubview(imageView)
        addSubview(hintLabel)
    }
    
    private func setupConstraints() {
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(350)
        }
        
        hintLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(150)
            make.right.equalToSuperview().offset(-150)
            
        }
    }
    
    
    
    func showHint() {
        
        let randomAnswer = answers.randomElement() ?? "A"
        hintLabel.text = "Я думаю, что правильный ответ - \(randomAnswer)"
        
        
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }
    }
    
    func hideHint() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc private func closeButtonTapped() {
            hideHint()
        }
}
