//
//  DetailViewController.swift
//  TableView
//
//  Created by 김태완 on 10/29/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var movieData: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
    }

    func makeUI() {
        mainImageView.image = movieData?.movieImage
        movieNameLabel.text = movieData?.movieName
        descriptionLabel.text = movieData?.movieDescription
        descriptionLabel.numberOfLines = 0
    }
}
