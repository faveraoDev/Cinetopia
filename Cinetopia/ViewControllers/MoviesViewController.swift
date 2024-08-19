//
//  MoviesViewController.swift
//  Cinetopia
//
//  Created by João Victor Mantese on 21/07/24.
//

import UIKit

class MoviesViewController: UIViewController {
    private var filteredMovies: [Movie] = []
    private var isSearchActive: Bool = false
    private let movieService: MovieService = MovieService()
    private var movies: [Movie] = []
    
    private lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        return tableView
    }()
    
    private lazy var moviesSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            if let leftView = searchTextField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = .lightGray
            }
            
            if let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton {
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    clearButton.tintColor = .lightGray
                }
            
            searchTextField.textColor = .black
            searchTextField.attributedPlaceholder = NSAttributedString(string: "Pesquisar", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = .accent
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .background
        setupNavBar()
        adicionarSubviews()
        setupConstraints()
        configureSearchBar()
        
        Task {
            await fetchMovies()
        }
    }
    
    private func fetchMovies() async {
        do {
            movies = try await movieService.getMovies()
            moviesTableView.reloadData()
        } catch (let error) {
            print(error)
        }
    }
    
    private func configureSearchBar() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        moviesSearchBar.resignFirstResponder()
    }
    
    private func adicionarSubviews() {
        view.addSubview(moviesTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavBar() {
        title = "Filmes Populares"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.accent
        ]
        navigationItem.hidesBackButton = true
        navigationItem.titleView = moviesSearchBar
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

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredMovies.count : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell {
            let movieList = isSearchActive ? filteredMovies[indexPath.row] : movies[indexPath.row]
            
            cell.configureCell(movie: movieList)
            cell.selectionStyle = .none
            
            return cell
        }
    
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieList = isSearchActive ? filteredMovies[indexPath.row] : movies[indexPath.row]
        
        let detailsVC = MovieDetailsViewController(movie: movieList)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearchActive = false
        } else {
            isSearchActive = true
            filteredMovies = movies.filter({ movie in
                movie.title.lowercased().contains(searchText.lowercased())
            })
        }
        
        moviesTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        if isMatchFound(for: searchText) == false {
            showAlert(message: "Nenhum resultado encontrado para '\(searchText)'")
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        isSearchActive = false
        searchBar.resignFirstResponder()
        moviesTableView.reloadData()
    }
    
    func isMatchFound(for searchText: String) -> Bool {
        for movie in movies {
            if movie.title.lowercased().contains(searchText.lowercased()) {
                return true
            }
        }
        return false
    }
    
    func showAlert(message: String) {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
}
