//
//  FavoritesViewController.swift
//  Movies
//
//  Created by Jobson Mateus on 01/03/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [MovieView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled = true
        
        self.title = L10n.Favorite.title
        self.navigationItem.titleView?.tintColor = Colors.titleColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.configureBarButton()
        self.setColors()
        self.movies = MovieViewModel.getFavorites()
        self.configureCollectionView()
        self.transitionViewStates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupInitialViewState(emptyText: L10n.EmptyText.notFavorite)
    }
    
    func configureBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.close.getImage(), style: .done, target: self, action: #selector(dismissController))
                                                                 
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setColors() {
        
        self.view.backgroundColor = Colors.primaryColor
        self.collectionView.backgroundColor = Colors.primaryColor
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(cellType: MovieCollectionViewCell.self)
    }
    
    @objc func dismissController() {
        
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destino = segue.destination as? MovieDetailViewController {
            
            destino.movieId = sender as? Int
            destino.delegate = self
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as MovieCollectionViewCell
        
        cell.bind(movie: self.movies[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.perform(segue: StoryboardSegue.Main.detalheSegue, sender: self.movies[indexPath.item].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.width - 80)/3, height: (UIScreen.main.bounds.width + 64)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 32
    }
}

extension FavoritesViewController: StatefulViewController {
    
    func hasContent() -> Bool {
        
        return !self.movies.isEmpty
    }
    
    func success(_ type: ResponseType) {}
    
    func failure(_ type: ResponseType, error: String?) {}
}

extension FavoritesViewController: MovieDetailViewControllerDelegate {
    
    func didPopViewController() {
        
        self.movies = MovieViewModel.getFavorites()
        self.collectionView.reloadData()
        self.transitionViewStates()
    }
}
