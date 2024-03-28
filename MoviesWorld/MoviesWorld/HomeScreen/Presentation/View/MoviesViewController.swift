//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 12/10/21.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MoviesViewController: BaseViewController {
    @IBOutlet private weak var moviesTableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    private var disposeBag: DisposeBag!
    var moviesViewModel: MoviesViewModelContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        registerCellNibFile()
        instantiateRXItems()
        listenOnObservables()
        instantiateRefreshControl()
    }
    
    private func setupNavigationController(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        let logout = UIBarButtonItem(image: .logoutImage, style: .plain, target: self, action: #selector(logout))
        logout.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.rightBarButtonItem  = logout
        self.navigationItem.title = Localize.appName
        
        //clear background
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    @objc private func logout(){
        moviesViewModel.logout()
        moviesViewModel.navigateTo(to: .Login)
    }
    
    private func registerCellNibFile(){
        let movieNibCell = UINib(nibName: Constants.movieCellNibName, bundle: nil)
        moviesTableView.register(movieNibCell, forCellReuseIdentifier: Constants.movieCellNibName)
    }
    
    private func instantiateRXItems(){
        disposeBag = DisposeBag()
        moviesTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func instantiateRefreshControl(){
        moviesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
    }
    
    @objc private func refreshControlTriggered() {
        moviesViewModel.refreshControlAction.onNext(())
    }
    
    private func listenOnObservables(){
        moviesViewModel.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else{
                print("PVC* error in errorObservable")
                return
            }
            self.showAlert(title: "Error", body: message, actions: [UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)])
        }).disposed(by: disposeBag)

        moviesViewModel.loadingObservable.subscribe(onNext: {[weak self] (boolValue) in
            guard let self = self else{
                print("PVC* error in doneObservable")
                return
            }
            switch boolValue{
            case true:
                self.showLoading()
            case false:
                self.hideLoading()
            }
        }).disposed(by: disposeBag)
        moviesViewModel.items.bind(to: moviesTableView.rx.items) { tableView, row, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCellNibName, for: IndexPath(index: row)) as? CellViewProtocol
            let model = MovieTableViewCellModel(
                image: item.backdropPath ?? "",
                movieTitle: item.title ?? "",
                movieDesc: item.overview ?? "",
                rating: item.voteAverage ?? 0.0,
                votingCount: item.voteCount ?? 0)
            cell?.setup(viewModel: model)
            return cell as! UITableViewCell
        }
        .disposed(by: disposeBag)


        moviesTableView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else {
                print("PVC* error in didScroll")
                return }
            let offSetY = self.moviesTableView.contentOffset.y
            let contentHeight = self.moviesTableView.contentSize.height

            if offSetY > (contentHeight - self.moviesTableView.frame.size.height - 20) {
                self.moviesViewModel.fetchMoreDatas.onNext(())
            }
        }.disposed(by: disposeBag)

        moviesViewModel.isLoadingSpinnerAvaliable.subscribe { [weak self] isAvaliable in
            guard let isAvaliable = isAvaliable.element,
                let self = self else { return }
            if(isAvaliable){
                self.showLoading()
            }else{
                self.hideLoading()
            }
        }
        .disposed(by: disposeBag)

        moviesViewModel.refreshControlCompelted.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
        }
        .disposed(by: disposeBag)

        moviesTableView.rx.modelSelected(Movie.self).subscribe(onNext: {[weak self] (MovieItem) in
            guard let self = self else {return}
//            self.MoviesViewModel.navigateTo(to: .Details(MovieItem))
        }).disposed(by: disposeBag)
    }
}

extension MoviesViewController : UICollectionViewDelegateFlowLayout {

}
