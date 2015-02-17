//
//  ViewController.swift
//  bettercalculator
//
//  Created by coolboykl on 2/6/15.
//  Copyright (c) 2015 coolboykl. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
 
    var userISInTheMiddleOFTypingNumber = false;
    var calculatorEngine = CalculatorModel()
    var dotPressed = false;
    @IBOutlet weak var mainDigitLabel: UILabel!
    @IBOutlet weak var computeLogLabel: UILabel!
    
    var displayValue: Double {
        get{
          return NSNumberFormatter().numberFromString(mainDigitLabel.text!)!.doubleValue
            
        }
        set {
            mainDigitLabel.text = "\(newValue)"
            userISInTheMiddleOFTypingNumber = false
        }
    }
    
    @IBAction func performOperation(sender: UIButton) {
        // Only allows to push the operator if the last 
        if ( mainDigitLabel.text! != " ") {
        let operation = sender.currentTitle!
            calculatorEngine.pushOperateType(operation)
            computeLogLabel.text = computeLogLabel.text! + operation
            calculatorEngine.pushOperand(displayValue)
            mainDigitLabel.text = " "
            userISInTheMiddleOFTypingNumber = false
            dotPressed = false
        }
        
    }
    
    @IBAction func appendNumber(sender: UIButton) {
        let buttonTitle = sender.currentTitle!
        var textAppend = false
        
        if userISInTheMiddleOFTypingNumber {
            if (buttonTitle == "." && !dotPressed) || buttonTitle != "." {
                mainDigitLabel.text = mainDigitLabel.text! + buttonTitle
                textAppend = true
                if(buttonTitle == ".") {
                    dotPressed = true
                }
            }
        } else {
            textAppend = true
            if buttonTitle != "." {
                mainDigitLabel.text  = buttonTitle
            } else {
                mainDigitLabel.text = mainDigitLabel.text! + buttonTitle
            }
            userISInTheMiddleOFTypingNumber = true
            dotPressed  = false
        }
        
//        Check if require to append the dot
        if textAppend {
            computeLogLabel.text = computeLogLabel.text! + buttonTitle
        }
    }

    @IBAction func performClearOrReset() {
        mainDigitLabel.text = "0"
        reset()
    }
    
    func reset() {
        computeLogLabel.text = " "
        userISInTheMiddleOFTypingNumber = false
        calculatorEngine.performReset()
        dotPressed  = false
    }
    
    @IBAction func computeAnswer() {
        if mainDigitLabel.text != " " {
//            operandStack.append(displayValue)
            calculatorEngine.pushOperand(displayValue)
        } else {
            // remove the last operator from the stack
            // and the computeLog
//            operateStack.removeLast()
//            computeLogLabel.text.
            computeLogLabel.text = computeLogLabel.text!.substringToIndex(computeLogLabel.text!.endIndex.predecessor())
        }
//        println("operandStack = \(operandStack), operateStack = \(operateStack)")
        computeLogLabel.text = computeLogLabel.text! + " = "
        displayValue = calculatorEngine.performEvaluation()
//        reset()

    }
    
    
 
}

