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
        configureButtonAction()
    }
}

// MARK: - ViewController configuration
extension DownloadViewController {
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
    
    private func configureButtonAction() {
        loadAllButton.addAction(UIAction(handler: loadAllImage), for: .touchUpInside)
        
        for (index, view) in imageLoadViews.enumerated() {
            view.configureButtonAction(UIAction(handler: { _ in
                self.loadImage(for: index, view: view)
            }))
        }
    }
}
    
// MARK: - ButtonAction
extension DownloadViewController {
    private func loadAllImage(_ action: UIAction) {
        for (index, view) in imageLoadViews.enumerated() {
            loadImage(for: index, view: view)
        }
    }
    
    private func loadImage(for index: Int, view: ImageLoadView) {
        view.configureImage(UIImage(systemName: "photo"))
        
        self.imageManager.createThumbnail(for: index) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    view.configureImage(image)
                }
            case .failure(let error):
                var errorMessage: String = "Unknown Error"
                
                if let error = error as? ImageError {
                    errorMessage = error.localizedDescription
                }
                
                let alert = AlertBuilder()
                    .withTitle("\(index + 1)번 사진 로딩 실패")
                    .withMessage(errorMessage)
                    .withStyle(.alert)
                    .withDefaultActions()
                    .build()
                
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
