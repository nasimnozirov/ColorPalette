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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        settingColor()
        setValue(redLabel, greenLabel, blueLabel)
    }
    
    @IBAction func setColor(_ sender: UISlider) {
        settingColor()
        switch sender{
        case redSlider:
            redLabel.text = string(redSlider)
        case greenSlider:
            greenLabel.text = string(greenSlider)
        default:
            blueLabel.text = string(blueSlider)
        }
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
}

extension SettingColorViewController {
    private func string(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

