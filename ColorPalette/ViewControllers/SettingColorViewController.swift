//
//  ViewController.swift
//  ColorPalette
//
//  Created by Nasim Nozirov on 13.04.2022.
//

import UIKit

class SettingColorViewController: UIViewController {
    
    //    MARK - IB Outlet
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    //MARK: - Public Properties
    var colorV: UIColor!
    var delegate: SettingColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.backgroundColor = colorV
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        setSliders()
        setValue(for: redTF, greenTF, blueTF)
        setValue(for: redLabel, greenLabel, blueLabel)
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
    }
    
    // MARK - IB Action
    @IBAction func clauseView() {
        delegate?.setColor(for: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func setColor(_ sender: UISlider) {
        
        switch sender{
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTF)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTF)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTF)
        }
        
        setColor()
    }
    
    // MARK Private Func
    private func setSliders() {
        let ciColor = CIColor(color: colorV)
        
        redSlider.value = Float(ciColor .red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(redSlider)
            case greenLabel:
                greenLabel.text = string(greenSlider)
            default:
                blueLabel.text = string(blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                redTF.text = string(redSlider)
            case greenTF:
                greenTF.text = string(greenSlider)
            default:
                blueTF.text = string(blueSlider)
            }
        }
    }
}

//MARK - RGB Values
extension SettingColorViewController {
    private func string(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

//MARK - Setting Text Field
extension SettingColorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //    мы тут берем переданные значение из текстфилд и передаём на слайдер и лейбл
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            
            switch textField.tag {
            case 0:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redLabel)
            case 1:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: redLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: redLabel)
            }
            
            setColor()
            return
        }
        showAlert(title: "Wrong format!", message: "Please enter correct value")
    }
}


//MARK - Show Alert
extension SettingColorViewController {
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK - Setting Keyboard Text Field
extension SettingColorViewController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTabDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbar.items = [flexBarButton, doneButton]
        
    }
    
    @objc private func didTabDone() {
        view.endEditing(true)
    }
}
