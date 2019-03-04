//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Jobson Mateus on 27/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit

protocol MovieDetailViewControllerDelegate {
    func didPopViewController()
}

class MovieDetailViewController: UIViewController {
    
    var movieId: Int!
    var movie: MovieView!
    var trailers: [TrailerView] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: MovieDetailViewControllerDelegate!
    
    var service: MovieService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled = true
        
        self.movie = MovieViewModel.get(by: self.movieId)
        self.title = self.movie.nome
        
        self.navigationItem.titleView?.tintColor = Colors.titleColor
        self.navigationItem.backBarButtonItem?.title = " "
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.setColors()
        self.configureTableView()
        self.service = MovieService.init(delegate: self)
        
        self.startLoading()
        self.service.getMovieTrailer(movieId: self.movieId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let delegate = self.delegate {
            delegate.didPopViewController()
        }
    }
    
    func configureTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellType: MovieDetailTableViewCell.self)
        self.tableView.register(cellType: TrailerTableViewCell.self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 500
        self.tableView.separatorStyle = .none
    }
    
    func setColors() {
        
        self.view.backgroundColor = Colors.primaryColor
        self.tableView.backgroundColor = Colors.primaryColor
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : self.trailers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath) as MovieDetailTableViewCell
            
            cell.bind(with: self.movie)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as TrailerTableViewCell
        
        cell.bind(trailer: self.trailers[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return CGFloat.leastNonzeroMagnitude
    }
}

extension MovieDetailViewController: TrailerTableViewCellDelegate {
    
    func openTrailer(id: String) {
        
        let trailer = TrailerViewModel.get(by: id)
        
        if let url = URL(string: baseUrlYoutube + "\(trailer.key)") {
            UIApplication.shared.open(url)
        }
    }
}

extension MovieDetailViewController: StatefulViewController {
    
    func hasContent() -> Bool {
        return !self.trailers.isEmpty
    }
    
    func success(_ type: ResponseType) {
        
        switch type {
        case .getTrailers:
            
            self.trailers = TrailerViewModel.getAll()
            self.tableView.reloadData()
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
