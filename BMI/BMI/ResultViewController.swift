//
//  ResultViewController.swift
//  BMI
//
//  Created by 김태완 on 10/2/24.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var reCalculateButton: UIButton!
    
    var resultBMI: Double?
    var bmiColor: UIColor?
    var adviceString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        figureUI()
    }
    
    func figureUI() {
        resultLabel.clipsToBounds = true
        resultLabel.layer.cornerRadius = 10
        resultLabel.backgroundColor = .link
        
        reCalculateButton.clipsToBounds = true
        reCalculateButton.layer.cornerRadius = 8
        
        guard let resultBMI else { return }
        resultLabel.text = String(resultBMI)
        resultLabel.backgroundColor = bmiColor
        adviceLabel.text = adviceString
    }
    
    
    @IBAction func reCalculateButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    

}
