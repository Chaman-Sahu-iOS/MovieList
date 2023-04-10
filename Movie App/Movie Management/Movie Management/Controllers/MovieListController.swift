//
//  MovieListController.swift
//  Movie Management
//
//  Created by chaman-8419 on 10/12/22.
//

import UIKit

class MovieListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var moviesDetailsList = [Movie]()
    var moviesPosterList = [Int : UIImage]()
    var moviesBackDropList = [Int : UIImage]()
    
    var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        self.view.backgroundColor = .white
        
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        self.view.addSubview(moviesTableView)
        
        moviesTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        moviesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        moviesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
       
        self.moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        
        gettingDataFromAPI()
    }
    
    func gettingDataFromAPI() {
        
        let url = URL(string: "http://api.themoviedb.org/3/search/movie?api_key=7e588fae3312be4835d4fcf73918a95f&query=a%20&page=01")
        var  urlRequest  = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 30
        
      //  let configuration = URLSessionConfiguration.default
       // let urlSession = URLSession(configuration: configuration)
        
      let task =  URLSession.shared.dataTask(with: urlRequest) {  data, response, error in
            
            if let error = error {
                print("Error....\(error.localizedDescription)")
            }
            
            if let movieData = data {
                
                do {
                    let decode = try JSONDecoder().decode(MoviesAPIModel.self, from: movieData)
                    
                    self.moviesDetailsList = decode.results
                    DispatchQueue.main.async {
                        self.gettingMoviesPosterImages()
                        self.gettingMoviesBackDropImages()
                        self.moviesTableView.reloadData()
                    }
                   
                } catch let error {
                    print("Not parse: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
    func gettingMoviesPosterImages() {
        moviesPosterList.removeAll()
        for moviesDetails in moviesDetailsList {
            guard let moviePosterUrl = moviesDetails.poster_path else { continue }
            guard let url = URL(string: "http://image.tmdb.org/t/p/w92\(moviePosterUrl)") else { continue }
            // create a URLSession to handle the request tasks
            let session = URLSession.shared
            // create a "data task" to make the request and run completion handler
            let task = session.dataTask(with: url, completionHandler: {
                data, response, error in
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.moviesPosterList[moviesDetails.id] = image
                    self.moviesTableView.reloadData()
                }
            })
            task.resume()
        }
    }
    
    func gettingMoviesBackDropImages() {
        moviesPosterList.removeAll()
        for moviesDetails in moviesDetailsList {
            guard let movieBackDropUrl = moviesDetails.backdrop_path else { continue }
            guard let url = URL(string: "http://image.tmdb.org/t/p/w92\(movieBackDropUrl)") else { continue }
            // create a URLSession to handle the request tasks
            let session = URLSession.shared
            // create a "data task" to make the request and run completion handler
            let task = session.dataTask(with: url, completionHandler: {
                data, response, error in
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.moviesBackDropList[moviesDetails.id] = image
                    self.moviesTableView.reloadData()
                }
            })
            task.resume()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        cell.backgroundColor = .yellow
        cell.movieImageView.image = MovieImage(movieID: moviesDetailsList[indexPath.row].id, imageList: moviesPosterList)
        cell.movieNameLabel.text = moviesDetailsList[indexPath.row].title
        cell.movieOverViewLabel.text = moviesDetailsList[indexPath.row].overview
        cell.moviePopularityLabel.text = "Popularity: \(moviesDetailsList[indexPath.row].popularity ?? 0)"
        cell.movieReleaseDateLabel.text = "Release Date: \(moviesDetailsList[indexPath.row].release_date!)"
        cell.addToWatchListLabel.text = "Add to Watchlist"
        cell.isWatchListed = moviesDetailsList[indexPath.row].isAddInWatchList
        cell.updateWatchList()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieDetailsViewController = MovieDetailsController()
        movieDetailsViewController.title = moviesDetailsList[indexPath.row].original_title
        movieDetailsViewController.movieImageView.image = MovieImage(movieID: moviesDetailsList[indexPath.row].id, imageList: moviesBackDropList)
        movieDetailsViewController.movieTitleLabel.text = "Title: \(moviesDetailsList[indexPath.row].title!)"
        movieDetailsViewController.movieOverViewLabel.text = moviesDetailsList[indexPath.row].overview
        movieDetailsViewController.moviePopularityLabel.text = "Popularity: \(moviesDetailsList[indexPath.row].popularity ?? 0)"
        movieDetailsViewController.movieReleaseDateLabel.text = "Release Date: \(moviesDetailsList[indexPath.row].release_date!)"
        movieDetailsViewController.movieVoteCountLabel.text = "Vote Count: \(moviesDetailsList[indexPath.row].vote_count!)"
        movieDetailsViewController.addToWatchListLabel.text = "Add to Watchlist"
        
        movieDetailsViewController.closire = { [weak self] res in
            guard let weakaSelf = self else {return}
            weakaSelf.moviesDetailsList[indexPath.row].isAddInWatchList = res
            weakaSelf.moviesTableView.reloadData()
        }
        
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
