//
//  ViewController.swift
//  Movies
//
//  Created by Jobson Mateus on 25/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit
import SwiftMessages

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [MovieView] = []
    
    var service: MovieService!
    
    var searchTimer: Timer?
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = L10n.App.title
        self.navigationItem.titleView?.tintColor = Colors.titleColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.service = MovieService(delegate: self)
        self.configureCollectionView()
        self.setColors()
        self.setupSearchController()
        self.setupFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        self.setupInitialViewState(emptyText: L10n.EmptyText.notFound)
    }
    
    func setColors() {
        
        self.view.backgroundColor = Colors.primaryColor
        self.collectionView.backgroundColor = Colors.primaryColor
    }
    
    func setupSearchController() {
        
        self.searchController = UISearchController.init(searchResultsController: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(presentSearchController))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setupFavorites() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Asset.emptyStar.getImage(), style: .done, target: self, action: #selector(presentFavoritesController))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(cellType: MovieCollectionViewCell.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destino = segue.destination as? MovieDetailViewController {
            
            destino.movieId = sender as? Int
        }
    }
}

extension ViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.searchTimer?.invalidate()
        
        if let text = searchController.searchBar.text, text.count > 2 {
            
            self.searchTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(search), userInfo: text, repeats: false)
        }
    }
    
    @objc func search(_ timer: Timer) {
    
        if let text = timer.userInfo as? String {
            
            self.movies = []
            
            self.startLoading()
            
            self.service.getSearchMovies(text: text)
        }
    }
    
    @objc func presentSearchController() {
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        
        self.searchController.searchBar.sizeToFit()
        self.setSearchTextFieldAppearence()
        
        self.present(self.searchController, animated: true)
    }
    
    @objc func presentFavoritesController() {
        
        let controller = StoryboardScene.Main.favoritesViewController.instantiate()
        
        self.present(UINavigationController.init(rootViewController: controller), animated: true)
    }
    
    func setSearchTextFieldAppearence() {
        
        let textFieldInsideSearchBar = self.searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.placeholder = L10n.SearchBar.placeholder
        textFieldInsideSearchBar?.textColor = Colors.primaryText
        textFieldInsideSearchBar?.tintColor = Colors.primaryText
        
        
        self.searchController.searchBar.barStyle = .black
        self.searchController.searchBar.tintColor = Colors.primaryText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.movies = []
        self.collectionView.reloadData()
        self.update(emptyText: L10n.EmptyText.notFound)
        self.transitionViewStates()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as MovieCollectionViewCell
        
        cell.bind(movie: self.movies[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.searchController.dismiss(animated: true)
        
        self.perform(segue: StoryboardSegue.Main.detalheSegue, sender: self.movies[indexPath.item].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.width - 80)/3, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 32
    }
}

extension ViewController: StatefulViewController, BackingViewProvider {
    
    var backingView: UIView {
        
        return self.collectionView
    }
    
    func hasContent() -> Bool {
        
        return !self.movies.isEmpty
    }
    
    func success(_ type: ResponseType) {
        
        switch type {
        case .searchMovies:
            
            self.movies = MovieViewModel.get(by: self.searchController.searchBar.text ?? "")
            
            self.collectionView.reloadData()
            
            self.update(emptyText: L10n.EmptyText.notFound)
            
        default:
            break
        }
        
        self.endLoading()
    }
    
    func failure(_ type: ResponseType, error: String?) {
        
        self.endLoading()
        Message.init(text: error, target: self).show()
    }
}
