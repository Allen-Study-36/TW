//
//  ViewController.swift
//  BMI
//
//  Created by 김태완 on 10/2/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var bmiCalculateButton: UIButton!
    
    var bmiManager = BMICalculatorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heightInput.delegate = self
        weightInput.delegate = self

        figureUI()
    }

    func figureUI() {
        mainLabel.text = "키와 몸무게를 입력하세요"
        mainLabel.textColor = .black

        bmiCalculateButton.clipsToBounds = true
        bmiCalculateButton.layer.cornerRadius = 8

        heightInput.text = ""
        heightInput.placeholder = "키(cm)"
        heightInput.keyboardType = .numberPad
        
        weightInput.text = ""
        weightInput.placeholder = "몸무게(kg)"
        weightInput.keyboardType = .numberPad
    }

    // MARK: - 화면이동 메서드
    @IBAction func bmiCalculateButtonClicked(_ sender: UIButton) {
        
        if heightInput.text == "" || weightInput.text == "" {
            mainLabel.text = "빈칸을 채워주세요"
            mainLabel.textColor = .red
            
        } else {
            guard let resultVC = storyboard?.instantiateViewController(withIdentifier: "resultVC") as? ResultViewController else { return }
            resultVC.modalPresentationStyle = .fullScreen
            
            guard let height = heightInput.text, let weight = weightInput.text else { return }
            resultVC.bmi = bmiManager.getBMI(height: height, weight: weight)
            
            self.present(resultVC, animated: true)
            
            figureUI()
        }
    }

    

}

extension ViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true
        }
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if heightInput.text != "", weightInput.text != "" {
            weightInput.resignFirstResponder()
            return true
        } else if heightInput.text != "" {
            weightInput.resignFirstResponder()
            return true
        }
        return false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightInput.resignFirstResponder()
        weightInput.resignFirstResponder()
    }
    
}
