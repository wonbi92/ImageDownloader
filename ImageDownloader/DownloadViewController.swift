//
//  DownloadViewController.swift
//  ImageDownloader
//
//  Created by Wonbi on 2023/02/28.
//

import UIKit

final class DownloadViewController: UIViewController {
    private let imageLoadViews: [ImageLoadView] = ImageLoadViewFactory.makeImageLoadView(multiplier: 5)
    
    private let loadAllButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("Load All Images", for: .normal)
        return button
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageManager: ImageManager
    
    init(imageManager: ImageManager) {
        self.imageManager = imageManager

        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        imageLoadViews.forEach(mainStackView.addArrangedSubview(_:))
        mainStackView.addArrangedSubview(loadAllButton)
        
        view.addSubview(mainStackView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
    }
}

