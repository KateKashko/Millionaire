//
//  AudienceHelpViewController.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 03.03.2024.
//

import UIKit


final class AudienceHelpViewController: UIViewController {

    private let containerView = UIView()
    private let helpBarsView  = HelpBarsView()
    private let closeButton   = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCloseButton()
        configureViewController()
    }
    
    func set(data: [HelpBar.Data]) {
        helpBarsView.configure(with: data)
    }
    
    
    private func configureViewController() {
        
        view.addSubviews(containerView, closeButton)
        helpBarsView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(helpBarsView)
        
        NSLayoutConstraint.activate([
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            
            helpBarsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            helpBarsView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            helpBarsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            helpBarsView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
            
            closeButton.trailingAnchor.constraint(equalTo: helpBarsView.trailingAnchor, constant: -5),
            closeButton.topAnchor.constraint(equalTo: helpBarsView.topAnchor, constant: 5)
            
        ])
        
        let data = createDataSet()
        self.set(data: data)
    }
    
    
    private func configureCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.setTitleColor(.label, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        closeButton.backgroundColor = .clear
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
    
    
    @objc private func closeTapped(){
        dismiss(animated: true)
    }
    
}


extension AudienceHelpViewController {
    
    private func createDataSet() -> [HelpBar.Data] {
        let barLabels = ["A", "B", "C", "D"]
        
        var data: [HelpBar.Data] = []
        
        barLabels.enumerated().forEach { index, barName in
            
            let votes = Int.random(in: 10...80)
            
            let dataItem = HelpBar.Data(
                value: String(votes),
                heightMultiplier: Double(votes) * 0.01,
                index: index,
                columnName: barName)
            data.append(dataItem)
        }
        return data
    }
}
