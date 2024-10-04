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

    var bmi: Double?

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
            bmi = calculateBMI(height: height, weight: weight)
            
            resultVC.resultBMI = self.bmi
            resultVC.bmiColor = getBackgroundColor()
            resultVC.adviceString = getBMIAdviceString()
            
            self.present(resultVC, animated: true)
            
            figureUI()
        }
    }

    // MARK: - 기능 메서드
    func calculateBMI(height: String, weight: String) -> Double {
        guard let h = Double(height), let w = Double(weight) else { return 0.0 }
        var bmi = w / (h * h) * 10000
        bmi = round(bmi * 10) / 10
        return bmi
    }

    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
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
