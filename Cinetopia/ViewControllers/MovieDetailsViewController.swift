//
//  MovieDetailsViewController.swift
//  Cinetopia
//
//  Created by João Victor Mantese on 23/07/24.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    var movie: Movie
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = movie.title
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .accent
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        let url = URL(string: movie.image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.kf.setImage(with: url)
        
        return imageView
    }()
    
    private lazy var movieRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Classificação dos usuários: \(movie.rate)"
        label.textColor = .accent
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var movieSynopsisLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = movie.synopsis
        label.textColor = .accent.withAlphaComponent(0.75)
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        adicionarSubviews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func adicionarSubviews() {
        view.addSubview(movieTitleLabel)
        view.addSubview(moviePosterImageView)
        view.addSubview(movieRatingLabel)
        view.addSubview(movieSynopsisLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            moviePosterImageView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 30),
            moviePosterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moviePosterImageView.widthAnchor.constraint(equalToConstant: 192),
            moviePosterImageView.heightAnchor.constraint(equalToConstant: 264),
            
            movieRatingLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 30),
            movieRatingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            movieSynopsisLabel.topAnchor.constraint(equalTo: movieRatingLabel.bottomAnchor, constant: 30),
            movieSynopsisLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieSynopsisLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
