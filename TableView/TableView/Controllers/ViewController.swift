//
//  ViewController.swift
//  TableView
//
//  Created by 김태완 on 10/29/24.
//

import UIKit

class ViewController: UIViewController {
    
    var movieDataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 120
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "영화목록"
        
        movieDataManager.makeMovieData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        movieDataManager.addMovieData()
        tableView.reloadData()
    }
    
    @IBAction func trashButtonPressed(_ sender: UIBarButtonItem) {
        movieDataManager.popMovieData()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDataManager.getMovieData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.mainImageView.image = movieDataManager.getMovieData()[indexPath.row].movieImage // .row == 행
        cell.movieNameLabel.text = movieDataManager.getMovieData()[indexPath.row].movieName
        cell.descriptionLabel.text = movieDataManager.getMovieData()[indexPath.row].movieDescription
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    // didSelectRowAt -> 셀 선택시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath) // ⭐️
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath // ⭐️
            
            detailVC.movieData = movieDataManager.getMovieData()[indexPath.row]
        }
    }
}
