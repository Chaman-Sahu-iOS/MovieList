//
//  MovieListController.swift
//  Movie Management
//
//  Created by chaman-8419 on 10/12/22.
//

import UIKit

class MovieListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movieViewModel = MovieListViewModel()
    
    var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var sortBy: String?
    
//   override init(sortBy: String) {
//       super.init()
//     //  self.init(sortBy: sortBy)
//        self.sortBy = sortBy
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        setData()
        fetchMovieList()
        
        self.moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
    }
    
    // MARK: - Local Methods
    
    func prepareUI() {
        
        self.view.backgroundColor = .white
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        self.view.addSubview(moviesTableView)
        
        moviesTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        moviesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        moviesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setData() {
        self.navigationItem.title = "Movies"
    }
    
    func fetchMovieList() {
        movieViewModel.fetchMovieList(sortBy: sortBy!)
        self.prepareViewModelObserver()
    }
    
    func prepareViewModelObserver() {
        self.movieViewModel.movieDidChanges = { (finished, error) in
            if !error {
                self.moviesTableView.reloadData()
            }
        }
    }
    
    
    func MovieImage(movieID: Int, imageList: [Int : UIImage]) -> UIImage {
        for movieImage in imageList {
            if (movieImage.key == movieID) {
                return movieImage.value
            }
        }
        
        guard let defaultImage = UIImage(named: "defaultImage") else { return UIImage() }
        return defaultImage
    }
    
    //MARK: - TableView Delegate & DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movies!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        let movie = movieViewModel.movies![indexPath.row]
        cell.movieItem = movie
        
        if let  moviePosterList = movieViewModel.moviesPosterList {
            cell.movieImageView.image = MovieImage(movieID: movieViewModel.movies![indexPath.row].id, imageList: moviePosterList)
        }
  
        cell.updateWatchList()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieDetailsViewController = MovieDetailsController()
        
        movieDetailsViewController.movieItem = movieViewModel.movies![indexPath.row]
        
        movieDetailsViewController.movieImageView.image = MovieImage(movieID: movieViewModel.movies![indexPath.row].id, imageList: movieViewModel.moviesBackDropList)
        
        movieDetailsViewController.closire = { [weak self] res in
            guard let weakaSelf = self else {return}
            weakaSelf.movieViewModel.movies![indexPath.row].isAddInWatchList = res
            weakaSelf.moviesTableView.reloadData()
        }
        
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
