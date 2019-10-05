//
//  ViewController.swift
//  Tipper
//
//  Created by Carlos Mendoza on 10/4/19.
//  Copyright © 2019 Carlos Mendoza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tipField: UITextField!
    @IBOutlet weak var percentSegment: UISegmentedControl!
    @IBAction func changedValue(_ sender: Any) {
        updateLabel()
    }
    
    var percentage:Float = 0.15
    
    let finalBillLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 90, weight: .thin)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.minimumScaleFactor = 20/90
        return label
    }()
    
    let finalBillBackground : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 114/255, green: 112/255, blue: 189/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipField.delegate = self
        
        tipField.becomeFirstResponder()
        
        percentSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        percentSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemIndigo], for: .selected)
        
        tipField.tintColor = .white
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: Selector("keyboardWillHide:"), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//            tap.cancelsTouchesInView = false
//            view.addGestureRecognizer(tap)
        
        
        view.addSubview(finalBillBackground)
        
        finalBillBackground.topAnchor.constraint(equalTo: percentSegment.bottomAnchor, constant: 24).isActive = true
        finalBillBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        finalBillBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        finalBillBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        finalBillBackground.addSubview(finalBillLabel)
        
        finalBillLabel.topAnchor.constraint(equalTo: finalBillBackground.topAnchor, constant: 24).isActive = true
        finalBillLabel.leadingAnchor.constraint(equalTo: finalBillBackground.leadingAnchor, constant: 36).isActive = true
        finalBillLabel.trailingAnchor.constraint(equalTo: finalBillBackground.trailingAnchor, constant: -36).isActive = true
        
        
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize.height)
            
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func calculateTip(cost: Float, percent: Float) -> Float{
        return (cost*percent)
    }
    
    @IBAction func percentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            percentage = 0.15
        case 1:
            percentage = 0.18
        case 2:
            percentage = 0.2
        default:
            break
        }
        
        updateLabel()
    }
    func updateLabel() {
        if let bill = Float(tipField.text!) {
            let tip = calculateTip(cost: bill, percent: percentage)
            
            let formatted = String(format: "$%.2f", tip+bill)
            finalBillLabel.text = formatted
            
            
        }
    }
    
    

}

