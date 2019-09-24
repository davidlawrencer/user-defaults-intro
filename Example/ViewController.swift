//
//  ViewController.swift
//  Example
//
//  Created by David Rifkin on 9/24/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var fontSize: Double = 10.0{
        didSet{
            performFontSizeUpdates()
            performFontCapitalizationUpdates()
            UserDefaults.standard.set(fontSize, forKey: fontSizeKey)
        }
    }
    
    var userName: String = "" {
        didSet {
            performLabelTextUpdates()
            UserDefaults.standard.set(userName, forKey: userNameKey)
        }
    }
    
    var isUpperCased: Bool = true {
        didSet {
            performFontCapitalizationUpdates()
            UserDefaults.standard.set(isUpperCased, forKey: isUpperCasedKey)
        }
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var stepperOutlet: UIStepper!

    @IBAction func stepper(_ sender: UIStepper) {
        fontSize = sender.value
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        isUpperCased = sender.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaultSettings()
        nameTextField.delegate = self
    }
    
    //    MARK: - Private Functions
    
    private func loadDefaultSettings() {
        if let isUpper = UserDefaultsWrapper.wrapper.getUppercaseText() {
            isUpperCased = isUpper
        }
        
        if let name = UserDefaultsWrapper.wrapper.getUserName() {
            userName = name
        }
        
        if let size = UserDefaultsWrapper.wrapper.getFontSize() {
            fontSize = size
        }
    }
    
    private func performFontSizeUpdates() {
        welcomeLabel.font = welcomeLabel.font.withSize(CGFloat(self.fontSize))
        stepperOutlet.value = Double(self.fontSize)
    }
    
    private func performFontCapitalizationUpdates() {
        welcomeLabel.text = isUpperCased ? welcomeLabel.text?.uppercased() : welcomeLabel.text?.lowercased() //bool ? true : false
    }
    
    private func performLabelTextUpdates() {
        guard userName != "" else {
            welcomeLabel.text = "Welcome"
            return
        }
        welcomeLabel.text = "Welcome" + userName
        performFontCapitalizationUpdates()
    }
    
    private func letsLookThroughUserDefaults() {
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //this pattern of using range allows us to get the textfield's entire text at the time that it changes. how does it work? https://stackoverflow.com/questions/25621496/how-shouldchangecharactersinrange-works-in-swift

        guard let text = textField.text else {
            return false
        }
        let range = Range(range, in: text)!
        let newText = text.replacingCharacters(in: range, with: string)
        userName = newText
        return true
    }
}
