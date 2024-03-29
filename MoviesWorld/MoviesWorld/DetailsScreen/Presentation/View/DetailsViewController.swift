//
//  DetailsViewController.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 28/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import WebKit

class DetailsViewController: BaseViewController, WKNavigationDelegate {
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var voteCountLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet private weak var storylineLabel: UILabel!
    @IBOutlet private weak var movieDescLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!
    @IBOutlet private weak var movieHomePageLabel: UILabel!

    var detailsViewModel:DetailsViewModelContract!
    var photo:Movie!
    private var disposeBag:DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disposeBag = DisposeBag()
        showLoading()
        //        assignLabels()
        listenOnObservables()
        detailsViewModel.fetchMovieDetails()
    }
    
    private func listenOnObservables(){
        detailsViewModel.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else{
                print("DVC* error in errorObservable")
                return
            }
            self.showAlert(title: "Error", body: message, actions: [UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)])
        }).disposed(by: disposeBag)
        
        detailsViewModel.loadingObservable.subscribe(onNext: {[weak self] (boolValue) in
            guard let self = self else{
                print("DVC* error in doneObservable")
                return
            }
            switch boolValue{
            case true:
                self.showLoading()
            case false:
                self.hideLoading()
            }
        }).disposed(by: disposeBag)
        
        detailsViewModel.dataObservable.subscribe (onNext: {[weak self] movieDetails in
            guard let self = self else {return}
            print(movieDetails)
            self.setData(movie: movieDetails)
        }).disposed(by: disposeBag)
    }
    
    private func setData(movie: MovieDetailsModel) {
        let imageURL = Constants.APIConstatnts.imageURLPath + (movie.backdropPath ?? "")
        movieImageView.sd_setImage(with: URL(string: imageURL ), placeholderImage: UIImage(named: "placeholder"))
        self.movieTitleLabel.text = movie.title
        if let movieGenres = movie.genres {
            self.genresLabel.text = generateGenres(genres: movieGenres)
            self.genresLabel.isHidden = false
        }
        if let movieVoteAverage = movie.voteAverage {
            self.ratingLabel.text  = "\(movieVoteAverage)/10"
            self.voteCountLabel.text = "\(Localize.MoviesHome.votes): \(movie.voteCount ?? 0)"
            self.ratingView.isHidden = false
        }
        
        if let overview = movie.overview, !overview.isEmpty {
            self.storylineLabel.text = Localize.MovieDetails.storyline
            self.movieDescLabel.text = overview
            self.storylineLabel.isHidden = false
            self.movieDescLabel.isHidden = false
        }
        if let popularity = movie.popularity {
            self.popularityLabel.text = Localize.MovieDetails.popularity + ": \(popularity)"
            self.popularityLabel.isHidden = false

        }
        if let budget = movie.budget {
            self.budgetLabel.text = Localize.MovieDetails.budget + ": \(budget)$"
            self.budgetLabel.isHidden = false

        }
        if let homepage = movie.homepage, !homepage.isEmpty {
            self.movieHomePageLabel.isHidden = false
            makeHyperLink(link: homepage)
        }
    }
    
    private func generateGenres(genres: [Genre]) -> String {
        var genresString = ""
        for (index, genre) in genres.enumerated() {
            if index == 0 {
                genresString = genre.name ?? ""
            } else {
                guard let genreName = genre.name else {continue}
                genresString += ", \(genreName)"
            }
        }
        return genresString
    }
    
    private func makeHyperLink(link: String) {
        let attributedString = NSMutableAttributedString(string: link)
        let url = URL(string: link)!
        attributedString.setAttributes([.link: url], range: NSMakeRange(0, attributedString.length))
        
        movieHomePageLabel.attributedText = attributedString
        movieHomePageLabel.isUserInteractionEnabled = true
        
        // Add tap gesture recognizer to handle link tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        movieHomePageLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        guard let  text = movieHomePageLabel.attributedText?.string else { return }
        let webViewController = WebViewController(url: URL(string: text)!)
        present(webViewController, animated: true, completion: nil)
    }
    
}
