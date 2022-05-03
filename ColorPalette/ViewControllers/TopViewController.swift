//
//  TopViewController.swift
//  ColorPalette
//
//  Created by Nasim Nozirov on 27.04.2022.
//

import UIKit

protocol SettingColorViewControllerDelegate {
    func setColor(for colorView: UIColor)
}

class TopViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingColorViewController else { return }
        settingVC.colorV = view.backgroundColor
        settingVC.delegate = self
    }
}
// MARK - RenderingColorDeLegate
extension TopViewController: SettingColorViewControllerDelegate {
    func setColor(for colorView: UIColor) {
        view.backgroundColor = colorView
    }
    
    
}
