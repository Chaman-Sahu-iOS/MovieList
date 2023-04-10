//
//  MovieDetailsController.swift
//  Movie Management
//
//  Created by chaman-8419 on 10/12/22.
//

import UIKit

class MovieDetailsController: UIViewController {
    
    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var movieOverViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
      //  label.shadowColor = .black
       // label.shadowOffset = CGSize(width: -2, height: -2)
       // label.layer.shadowColor = UIColor.black.cgColor
     //   label.layer.shadowRadius = 3.0
      //  label.layer.shadowOpacity = 1.0
      //  label.layer.shadowOffset = CGSize(width: 2, height: 2)
       // label.layer.masksToBounds = false
        return label
    }()
    
    var moviePopularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var movieVoteCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var addToWatchListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
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
        button.tintColor = .black
        return button
    }()
    
    var isWatchListed: Bool = false
    
    var closire: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(movieImageView)
        movieImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(movieTitleLabel)
        
        if movieTitleLabel.text!.isEmpty {
            movieTitleLabel.text = "No Data"
        }
        
        NSLayoutConstraint.activate([
            movieTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(movieOverViewLabel)
        
        if movieOverViewLabel.text!.isEmpty {
            movieOverViewLabel.text = "No Data"
        }
        
        NSLayoutConstraint.activate([
            movieOverViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            movieOverViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieOverViewLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor),
            movieOverViewLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        
        
        view.addSubview(moviePopularityLabel)
        
        if moviePopularityLabel.text!.isEmpty {
            moviePopularityLabel.text = "No Data"
        }
        
        NSLayoutConstraint.activate([
            moviePopularityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            moviePopularityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            moviePopularityLabel.topAnchor.constraint(equalTo: movieOverViewLabel.bottomAnchor),
            moviePopularityLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        view.addSubview(movieReleaseDateLabel)
        
        if movieReleaseDateLabel.text!.isEmpty {
            movieReleaseDateLabel.text = "No Data"
        }
        
        NSLayoutConstraint.activate([
            movieReleaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            movieReleaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieReleaseDateLabel.topAnchor.constraint(equalTo: moviePopularityLabel.bottomAnchor),
            movieReleaseDateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        view.addSubview(movieVoteCountLabel)
        
        if movieVoteCountLabel.text!.isEmpty {
            movieVoteCountLabel.text = "No Data"
        }
        
        NSLayoutConstraint.activate([
            movieVoteCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            movieVoteCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieVoteCountLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor),
            movieVoteCountLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        view.addSubview(addToWatchListLabel)
        
        if addToWatchListLabel.text!.isEmpty {
            addToWatchListLabel.text = "No Data"
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
