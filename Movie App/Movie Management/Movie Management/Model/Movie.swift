//
//  Movie.swift
//  Movie Management
//
//  Created by chaman-8419 on 10/12/22.
//

import Foundation

struct MoviesAPIModel: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Movie: Codable, Equatable {
    
    public var adult: Bool?
    public var backdrop_path: String?
    public var genre_ids: [Int]?
    public var id: Int
    public var original_language: String?
    public var original_title: String?
    public var overview: String?
    public var popularity: Double?
    public var poster_path: String?
    public var release_date: Date?
    public var title: String?
    public var video: Bool?
    public var vote_average: Double?
    public var vote_count: Int?
    public var isAddInWatchList: Bool = false
    
    public init(adult: Bool? = nil,
                backdropPath: String? = nil,
                genres: [Int]? = nil,
                id: Int,
                originalLanguage: String? = nil,
                originalTitle: String? = nil,
                overview: String? = nil,
                popularity: Double? = nil,
                poster_path: String? = nil,
                releaseDate: Date? = nil,
                title: String? = nil,
                video: Bool? = nil,
                voteAverage: Double? = nil,
                voteCount: Int? = nil,
                isAddInWatchList:Bool) {
        self.adult = adult
        self.backdrop_path = backdropPath
        self.genre_ids = genres
        self.id = id
        self.original_language = originalLanguage
        self.original_title = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = releaseDate
        self.title = title
        self.video = video
        self.vote_average = voteAverage
        self.vote_count = voteCount
        self.isAddInWatchList = isAddInWatchList
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case isWatchListed
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(adult, forKey: .adult)
        try? container.encode(backdrop_path, forKey: .backdropPath)
        try? container.encode(genre_ids, forKey: .genreIDs)
        try container.encode(id, forKey: .id)
        try? container.encode(original_language, forKey: .originalLanguage)
        try? container.encode(original_title, forKey: .originalTitle)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(poster_path, forKey: .posterPath)
        

        if let releaseDate = release_date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            try? container.encode(dateFormatter.string(from: releaseDate), forKey: .releaseDate)
        }
       
        try? container.encode(title, forKey: .title)
        try? container.encode(video, forKey: .video)
        try? container.encode(vote_average, forKey: .voteAverage)
        try? container.encode(vote_count, forKey: .voteCount)
        
        try? container.encode(isAddInWatchList, forKey: .isWatchListed)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        adult = try? container.decode(Bool.self, forKey: .adult)
        backdrop_path = try? container.decode(String.self, forKey: .backdropPath)
        if let genreIDs = try? container.decode([Int].self, forKey: .genreIDs) {
            genre_ids = genreIDs
        }
        id = try container.decode(Int.self, forKey: .id)
        original_language = try? container.decode(String.self, forKey: .originalLanguage)
        original_title = try? container.decode(String.self, forKey: .originalTitle)
        overview = try? container.decode(String.self, forKey: .overview)
        popularity = try? container.decode(Double.self, forKey: .popularity)
        poster_path = try? container.decode(String.self, forKey: .posterPath)
    

        if let dateString = try? container.decode(String.self, forKey: .releaseDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            release_date = dateFormatter.date(from: dateString)
        }

       
        title = try? container.decode(String.self, forKey: .title)
        video = try? container.decode(Bool.self, forKey: .video)
        vote_average = try? container.decode(Double.self, forKey: .voteAverage)
        vote_count = try? container.decode(Int.self, forKey: .voteCount)
        
        isAddInWatchList = ((try? container.decode(Bool.self, forKey: .isWatchListed)) != nil)
    }
}

