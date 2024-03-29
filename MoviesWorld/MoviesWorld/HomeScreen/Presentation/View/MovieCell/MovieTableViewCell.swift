//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 24/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell, CellViewProtocol {
    @IBOutlet private weak var MovieImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var movieDescLabel: UILabel!
    @IBOutlet private weak var voteAvgLabel: UILabel!
    @IBOutlet private weak var voteCountLabel: UILabel!
    
    func setup(viewModel: BaseCellViewModelProtocol) {
        guard let viewModel = viewModel as? MovieTableViewCellModel else {return}
        MovieImageView.sd_setImage(with: URL(string: viewModel.image ), placeholderImage: UIImage(named: "placeholder"))
        movieNameLabel.text = viewModel.movieTitle
        movieDescLabel.text = viewModel.movieDesc
        voteAvgLabel.text = viewModel.rating
        voteCountLabel.text = viewModel.votingCount
    }
}
