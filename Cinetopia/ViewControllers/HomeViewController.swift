//
//  ViewController.swift
//  Cinetopia
//
//  Created by João Victor Mantese on 16/07/24.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: .logo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var coupleImageView: UIImageView = {
        let imageView = UIImageView(image: .couple)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "O lugar ideal para buscar, salvar e organizar seus filmes favoritos!"
        label.textAlignment = .center
        label.textColor = .accent
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var welcomeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Quero começar!", for: .normal)
        button.setTitleColor(.background, for: .normal)
        button.backgroundColor = .buttonBackground
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 32
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var homeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoImageView, coupleImageView, welcomeLabel, welcomeButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .background
        adicionarSubviews()
        setupConstraints()
    }
    
    @objc private func buttonPressed() {
        navigationController?.pushViewController(MoviesViewController(), animated: true)
    }
    
    func adicionarSubviews() {
        view.addSubview(homeStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            homeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
            
            welcomeButton.heightAnchor.constraint(equalToConstant: 64),
            welcomeButton.leadingAnchor.constraint(equalTo: homeStackView.leadingAnchor, constant: 64),
            welcomeButton.trailingAnchor.constraint(equalTo: homeStackView.trailingAnchor, constant: -64)
        ])
    }
}

