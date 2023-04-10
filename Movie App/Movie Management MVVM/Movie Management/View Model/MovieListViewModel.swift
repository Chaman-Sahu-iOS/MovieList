//
//  MovieListViewModel.swift
//  Movie Management
//
//  Created by chaman-8419 on 10/12/22.
//

import UIKit

class MovieListViewModel {
    
    var movieDidChanges: ((Bool, Bool) -> Void)?
    
    var movies: [Movie]? {
        didSet {
            self.movieDidChanges?(true, false)
        }
    }
    
    var moviesPosterList: [Int : UIImage]? {
        didSet {
            self.movieDidChanges?(true, false)
        }
    }
    
    var moviesBackDropList = [Int : UIImage]()
    
    
    func fetchMovieList(sortBy: String) {
        
        self.movies = [Movie]()
        
        APIService.instance.fetchMovies { result in
            
            switch result {
                
            case .success(let data):
                
                let mappedModel = try? JSONDecoder().decode(MoviesAPIModel.self, from: data)
                
                self.movies = mappedModel?.results
                
                if sortBy == "Latest" {
                    self.movies?.sort(by: { m1, m2 in
                        m2.release_date! < m1.release_date!
                    })
                }
                
                if sortBy == "Popular" {
                    self.movies?.sort(by: { m1, m2 in
                        m2.popularity! < m1.popularity!
                    })
                }
                
                self.fetchPosterList()
                self.fetchBackDropList()
                
                break
            case .failure(let error):
                
                print(error.description)
            }
        }
    }
    
    func fetchPosterList() {
        
        self.moviesPosterList = [Int : UIImage]()
        
        if let movieList = movies {
            
            for movieDetails in movieList {
                guard let moviePosterUrl = movieDetails.poster_path else { continue }
                
                APIService.instance.fetchImage(imageExtension: moviePosterUrl) { result in
                    
                    switch result {
                        
                    case .success(let data):
                        
                        let image = UIImage(data: data)
                        self.moviesPosterList?[movieDetails.id] = image
                        
                        break
                    case .failure(let error):
                        
                        print(error.description)
                    }
                }
                
            }
        }
    }
    
    func fetchBackDropList() {
        
        self.moviesBackDropList = [Int : UIImage]()
        
        if let movieList = movies {
            
            for movieDetails in movieList {
                guard let movieBackDropUrl = movieDetails.backdrop_path else { continue }
                
                APIService.instance.fetchImage(imageExtension: movieBackDropUrl) { result in
                    
                    switch result {
                        
                    case .success(let data):
                        
                        let image = UIImage(data: data)
                        self.moviesBackDropList[movieDetails.id] = image
                        
                        break
                    case .failure(let error):
                        
                        print(error.description)
                    }
                }
                
            }
        }
    }
}
