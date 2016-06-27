//
//  ViewController.swift
//  Calculator
//
//  Created by Boguslaw Dawidow on 19.06.2016.
//  Copyright © 2016 Szymon Dawidow. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    var displayValue: String?
    
    var operand: Double?
    var operation: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        operationLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Operation IBActions
    
    @IBAction func decimalTapped(sender: UIButton) {
        
        if let currentValue = displayValue {
            displayValue = currentValue + "."
        }
        else{
            displayValue = "."
        }
        displayLabel.text = displayValue!
    }
    
    @IBAction func numberOperation(sender: UIButton) {
        
        var operationSymbol: (symbol:String,display:String)
        
        switch sender.tag {
        case 10:
            operationSymbol = ("*", "x")
        case 11:
            operationSymbol = ("/", "/")
        case 12:
            operationSymbol = ("-", "-")
        case 13:
            operationSymbol = ("+", "+")
            
        default:
            operationSymbol = ("","")
        }
        
        var doubleValueFromDisplayValue: Double?
        
        if let currentValue = displayValue, doubleFromCurrentValue = Double(currentValue) {
            
            doubleValueFromDisplayValue = doubleFromCurrentValue
        }
        
        if doubleValueFromDisplayValue == nil {
            print("Reset rhe number, we could not convert the current value into a Double.")
            displayValue = nil
            displayLabel.text = "0"
        }
        else if operand == nil {
            operand = doubleValueFromDisplayValue
            operation = operationSymbol.symbol
            displayValue = nil
            operationLabel.text = operationSymbol.display
        }
        else if operand != nil {
            if operation == "+" {
                operand = operand! + doubleValueFromDisplayValue!
            }
            else if operation == "-" {
                operand = operand! - doubleValueFromDisplayValue!
            }
            else if operation == "*" {
                operand = operand! * doubleValueFromDisplayValue!
            }
            else if operation == "/" {
                operand = operand! / doubleValueFromDisplayValue!
            }
            
            operation = operationSymbol.symbol
            displayValue = nil
            displayLabel.text = validateDisplayFormat(operand)
            operationLabel.text = operationSymbol.display
        }
    }
    
    @IBAction func equalsTapped(sender: UIButton) {
        
        
        if let currentValue = displayValue, doubleFromCurrentValue = Double(currentValue) {
            
            if operation == "+" {
                operand = operand! + doubleFromCurrentValue
            }
            else if operation == "-" {
                operand = operand! - doubleFromCurrentValue
            }
            else if operation == "*" {
                operand = operand! * doubleFromCurrentValue
            }
            else if operation == "/" {
                operand = operand! / doubleFromCurrentValue
            }
            displayLabel.text = validateDisplayFormat(operand)
            operation = nil
        }
        else {
            displayLabel.text = validateDisplayFormat(operand)
            operation = nil
        }
        operationLabel.text = "="
    }
    
    @IBAction func plusMinusTapped(sender: UIButton) {
        
        if let currentValue = displayValue, doubleFromCurrentValue = Double(currentValue){
            displayValue = "\(-1.0 * doubleFromCurrentValue)"
            displayLabel.text = validateDisplayFormat(-1.0 * doubleFromCurrentValue)
        }
        else {
            displayValue = nil
            displayLabel.text = "0"
        }
    }
    
    @IBAction func backspaceTapped(sender: UIButton) {
        
        if let currentValue = displayValue{
            displayValue = currentValue.substringToIndex(currentValue.endIndex.advancedBy(-1))
            if displayValue == ""{
                displayValue = "0"
            }
            displayLabel.text = validateDisplayFormat(Double(displayValue!))        }
    }
 
    @IBAction func clearTapped(sender: UIButton) {
        displayValue = nil
        displayLabel.text = "0"
        operationLabel.text = ""
        operand = nil
    }
    
    // MARK: - Symbol IBActions
    
    @IBAction func numberPadTapped(sender: UIButton) {
        
        if let currentValue = displayValue {
            displayValue = currentValue + String(sender.tag)
        }
        else {
            displayValue = String(sender.tag)
        }
        displayLabel.text = validateDisplayFormat(Double(displayValue!))
    }
    
    //MARK: - Helper Methods
    
    // Method change display string to Int look when numbers are not Double
    func validateDisplayFormat(value: Double?) -> String {
        
        if let currentValue = value {
            if Double(Int(currentValue)) == value {
                
                return String(Int(currentValue))
            }
            else {
                return String(currentValue)
            }
        }
        return ""
    }
}

