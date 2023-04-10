//
//  MovieTableViewCell.swift
//  Movie Management
//
//  Created by chaman-8419 on 10/12/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.backgroundColor = .clear
        label.textAlignment = .left
        return label
    }()
    
    var movieOverViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
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
    
    var addToWatchListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var watchListToggleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let image = UIImage(named: "remove_watchlist")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    var isWatchListed: Bool = false
    
    
    var movieItem: Movie? {
        
        didSet {
            
            if let movie = movieItem {
                
                self.movieNameLabel.text = movie.title
                
                self.movieOverViewLabel.text    = movie.overview
                self.moviePopularityLabel.text  = "Popularity: \(movie.popularity!)"
                self.movieReleaseDateLabel.text = "Release Date: \(movie.release_date!)"
                self.addToWatchListLabel.text   = "Add to Watchlist"
                self.isWatchListed              = movie.isAddInWatchList
            }
        }
    }
    
    //MARK: - Intializers
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
        
        updateWatchList()
    }
    
    func initialSetup() {
        
        contentView.addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        contentView.addSubview(movieNameLabel)
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20).isActive = true
        movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        contentView.addSubview(movieOverViewLabel)
        movieOverViewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        movieOverViewLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 0).isActive = true
        movieOverViewLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 0).isActive = true
        movieOverViewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        movieOverViewLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        contentView.addSubview(moviePopularityLabel)
        moviePopularityLabel.translatesAutoresizingMaskIntoConstraints = false

        moviePopularityLabel.topAnchor.constraint(equalTo: movieOverViewLabel.bottomAnchor, constant: 0).isActive = true
        moviePopularityLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 0).isActive = true
        moviePopularityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        moviePopularityLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        contentView.addSubview(movieReleaseDateLabel)
        movieReleaseDateLabel.translatesAutoresizingMaskIntoConstraints = false

        movieReleaseDateLabel.topAnchor.constraint(equalTo: moviePopularityLabel.bottomAnchor, constant: 0).isActive = true
        movieReleaseDateLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 0).isActive = true
        movieReleaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        movieReleaseDateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        contentView.addSubview(addToWatchListLabel)
        addToWatchListLabel.translatesAutoresizingMaskIntoConstraints = false

        addToWatchListLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: 0).isActive = true
        addToWatchListLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 0).isActive = true
        addToWatchListLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        addToWatchListLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        contentView.addSubview(watchListToggleButton)
        watchListToggleButton.translatesAutoresizingMaskIntoConstraints = false

        watchListToggleButton.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: 0).isActive = true
        watchListToggleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        watchListToggleButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        watchListToggleButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func updateWatchList() {
        if isWatchListed {
            let image = UIImage(named: "add_watchlist")?.withRenderingMode(.alwaysTemplate)
            watchListToggleButton.setImage(image, for: .normal)
            watchListToggleButton.tintColor = .red
        } else {
            let image = UIImage(named: "remove_watchlist")?.withRenderingMode(.alwaysTemplate)
            watchListToggleButton.setImage(image, for: .normal)
            watchListToggleButton.tintColor = .black
        }
    }
}



