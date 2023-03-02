//
//  ImageLoadView.swift
//  ImageDownloader
//
//  Created by Wonbi on 2023/03/02.
//

import UIKit

enum ImageLoadViewFactory {
    static func makeImageLoadView(multiplier: Int) -> [ImageLoadView] {
        var result: [ImageLoadView] = []
        
        for _ in 0..<multiplier {
            result.append(ImageLoadView())
        }
        
        return result
    }
}

final class ImageLoadView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.5
        return progressView
    }()
    
    private let button: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("Load", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButtonAction(_ action: UIAction) {
        button.addAction(action, for: .touchUpInside)
    }
    
    func configureImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    private func configureView() {
        [imageView, progressView, button].forEach(stackView.addArrangedSubview(_:))
            
        addSubview(stackView)
    }
    
    private func configureLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9),
            imageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.3),
            
            button.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.2)
        ])
    }
}
