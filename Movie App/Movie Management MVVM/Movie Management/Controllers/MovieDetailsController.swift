//
//  MovieDetailsController.swift
//  Movie Management
//
//  Created by chaman-8419 on 10/12/22.
//

import UIKit

class MovieDetailsController: UIViewController {
    
    //MARK: - Views
    
    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var movieOverViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var moviePopularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var movieVoteCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var addToWatchListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var watchListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let image = UIImage(named: "remove_watchlist")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK:- Properties
    
    var isWatchListed: Bool = false
    
    var closire: ((Bool) -> Void)?
    
    var movieItem: Movie? {
        
        didSet {
            
            if let movie = movieItem {
                
                self.title = movie.original_title
                self.movieTitleLabel.text = movie.title
                self.movieOverViewLabel.text    = movie.overview
                self.moviePopularityLabel.text  = "Popularity: \(movie.popularity!)"
                self.movieReleaseDateLabel.text = "Release Date: \(movie.release_date!)"
                self.movieVoteCountLabel.text   = "Vote Count: \(movie.vote_count!)"
                self.addToWatchListLabel.text   = "Add to Watchlist"
                self.isWatchListed              = movie.isAddInWatchList
            }
        }
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        updateWatchList()
    }
    
    //MARK: - Local Methods
    
    func setUpUI() {
        
        view.backgroundColor = .white
        view.addSubview(movieImageView)
        movieImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(movieTitleLabel)
        
        if let text = movieTitleLabel.text {
            if text.isEmpty {
                movieTitleLabel.text = "No Data"
            }
        }
        
        
        NSLayoutConstraint.activate([
            movieTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(movieOverViewLabel)
        
        if let text = movieOverViewLabel.text {
            if text.isEmpty {
                movieOverViewLabel.text = "No Data"
            }
        }
        
        NSLayoutConstraint.activate([
            movieOverViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            movieOverViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieOverViewLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor),
            movieOverViewLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        
        
        view.addSubview(moviePopularityLabel)
        
        if let text = moviePopularityLabel.text {
            if text.isEmpty {
                moviePopularityLabel.text = "No Data"
            }
        }
        
        NSLayoutConstraint.activate([
            moviePopularityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            moviePopularityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            moviePopularityLabel.topAnchor.constraint(equalTo: movieOverViewLabel.bottomAnchor),
            moviePopularityLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        view.addSubview(movieReleaseDateLabel)
        
        if let text = movieReleaseDateLabel.text {
            if text.isEmpty {
                movieReleaseDateLabel.text = "No Data"
            }
        }
        
        NSLayoutConstraint.activate([
            movieReleaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            movieReleaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieReleaseDateLabel.topAnchor.constraint(equalTo: moviePopularityLabel.bottomAnchor),
            movieReleaseDateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        view.addSubview(movieVoteCountLabel)
        
        if let text = movieVoteCountLabel.text {
            if text.isEmpty {
                movieVoteCountLabel.text = "No Data"
            }
        }
        
        NSLayoutConstraint.activate([
            movieVoteCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            movieVoteCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieVoteCountLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor),
            movieVoteCountLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        view.addSubview(addToWatchListLabel)
        
        if let text = movieVoteCountLabel.text {
            if text.isEmpty {
                movieVoteCountLabel.text = "No Data"
            }
        }
        
        NSLayoutConstraint.activate([
            addToWatchListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            addToWatchListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            addToWatchListLabel.topAnchor.constraint(equalTo: movieVoteCountLabel.bottomAnchor),
            addToWatchListLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        watchListButton.addTarget(self, action: #selector(addToWatchList), for: .touchUpInside)
        self.view!.addSubview(watchListButton)
        
        NSLayoutConstraint.activate([
            watchListButton.leadingAnchor.constraint(equalTo: addToWatchListLabel.trailingAnchor,constant: 0),
            watchListButton.topAnchor.constraint(equalTo: movieVoteCountLabel.bottomAnchor, constant: 10),
            watchListButton.heightAnchor.constraint(equalToConstant: 30),
            watchListButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func updateWatchList() {
        if isWatchListed {
            let image = UIImage(named: "add_watchlist")?.withRenderingMode(.alwaysTemplate)
            watchListButton.setImage(image, for: .normal)
            watchListButton.tintColor = .red
        } else {
            let image = UIImage(named: "remove_watchlist")?.withRenderingMode(.alwaysTemplate)
            watchListButton.setImage(image, for: .normal)
            watchListButton.tintColor = .white
        }
    }
    
    //MARK: - Actions
    
    @objc func addToWatchList(sender: UIButton!) {
        
        self.isWatchListed = !self.isWatchListed
        
        if (self.isWatchListed){
            print("Added in Watchlist")
            
            let image = UIImage(named: "add_watchlist")?.withRenderingMode(.alwaysTemplate)
            watchListButton.setImage(image, for: .normal)
            watchListButton.tintColor = .red
            
            closire?(true)
        }
        else{
            
            print("Removed from watchlist")
            let image = UIImage(named: "remove_watchlist")?.withRenderingMode(.alwaysTemplate)
            watchListButton.setImage(image, for: .normal)
            watchListButton.tintColor = .black
            
            closire?(false)
        }
    }
}
