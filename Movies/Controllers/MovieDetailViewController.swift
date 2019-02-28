//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Jobson Mateus on 27/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieId: Int!
    var movie: MovieView!
    var trailers: [String] = ["trailer 1", "Trailer 2"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.setColors()
        self.configureTableView()
        
        self.movie = MovieViewModel.get(by: self.movieId)
        
        self.title = self.movie.nome
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
            cell.delegate = self
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as TrailerTableViewCell
        
        cell.bind(text: self.trailers[indexPath.row])
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

extension MovieDetailViewController: MovieDetailTableViewCellDelegate, TrailerTableViewCellDelegate {
    
    func didFavorited() {
        
        
    }
    
    func openTrailler() {
        
        let controller = StoryboardScene.Main.trailerViewController.instantiate()
        
        self.present(controller, animated: true)
    }
}
