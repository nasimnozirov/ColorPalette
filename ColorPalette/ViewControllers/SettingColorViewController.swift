//
//  ViewController.swift
//  ColorPalette
//
//  Created by Nasim Nozirov on 13.04.2022.
//

import UIKit

class SettingColorViewController: UIViewController {
    
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
    
    var colorV: UIColor!
    var delegate: RenderingColorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorView.backgroundColor = colorV
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        settingToolbar()
        settingColorView()
        setValue(redTF, greenTF, blueTF)
        setValue(redLabel, greenLabel, blueLabel)
    }
   
    @IBAction func clauseView(_ sender: UIButton) {
        delegate.setColor(for: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func setColor(_ sender: UISlider) {
        settingColor()
        setValue(redLabel, greenLabel, blueLabel)
        
        switch sender{
        case redSlider:
            redLabel.text = string(redSlider)
            redTF.text = string(redSlider)
        case greenSlider:
            greenLabel.text = string(greenSlider)
            greenTF.text = string(greenSlider)
        default:
            blueLabel.text = string(blueSlider)
            blueTF.text = string(blueSlider)
        }
    }

    private func settingColorView() {
        let ciColor = CIColor(color: colorV)
        redSlider.value = Float(ciColor .red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    private func settingColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(_ labels: UILabel...) {
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
    
    private func setValue(_ textFields: UITextField...) {
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

extension SettingColorViewController {
    private func string(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension SettingColorViewController: UITextFieldDelegate {

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
   
               guard let text = textField.text else { return }
   
               if let currentValue = Float(text) {
   
                   switch textField.tag {
                   case 0:
                       redSlider.value = currentValue
                   case 1:
                       greenSlider.value = currentValue
                   default:
                       blueSlider.value = currentValue
                   }
   
                   settingColor()
                   setValue(redLabel, greenLabel, blueLabel)
               } else {
                   showAlert(title: "Wrong format!", message: "Please enter correct value")
               }
           }
       }

extension SettingColorViewController {
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension SettingColorViewController {
        private func settingToolbar() {
            let toolbar = UIToolbar(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: view.frame.size.width,
                    height: 50
                )
            )
    
            let flexibleSpase = UIBarButtonItem(
                barButtonSystemItem: .fixedSpace,
                target: self,
                action: nil
            )
    
            let doneButton = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(didTabDone)
            )
    
            toolbar.items = [flexibleSpase, doneButton]
            toolbar.sizeToFit()
            redTF.inputAccessoryView = toolbar
            greenTF.inputAccessoryView = toolbar
            blueTF.inputAccessoryView = toolbar
        }
    
    @objc private func didTabDone() {
       
        view.endEditing(true)
           }
}
