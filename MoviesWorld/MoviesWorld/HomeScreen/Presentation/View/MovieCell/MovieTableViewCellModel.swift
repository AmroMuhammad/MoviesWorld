//
//  MovieTableViewCellModel.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 28/03/2024.
//

import Foundation

struct MovieTableViewCellModel: BaseCellViewModelProtocol {
    let image: String
    let movieTitle: String
    let movieDesc: String
    let rating: String
    let votingCount: String
    
    init(image: String, movieTitle: String, movieDesc: String, rating: Double, votingCount: Int) {
        self.image = Constants.APIConstatnts.imageURLPath + image
        self.movieTitle = movieTitle
        self.movieDesc = movieDesc
        self.rating  = "\(rating)/10"
        self.votingCount = "\(Localize.MoviesHome.votes): \(votingCount)"
    }
}

class x:BaseCellViewModelProtocol  {
    let m:String
    
    init(m: String) {
        self.m = m
    }
}
