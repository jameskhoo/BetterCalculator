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
    var dotPressed = false;
    var operandStack = Array<Double>()
    var operateStack = Array<String>()
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
        let operation = sender.currentTitle!
        operateStack.append(operation)
        computeLogLabel.text = computeLogLabel.text! + operation
        operandStack.append(displayValue)
        mainDigitLabel.text = " "
        userISInTheMiddleOFTypingNumber = false
        dotPressed = false
//        println("operandStack = \(operandStack), operateStack = \(operateStack)")
        
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
        computeLogLabel.text = " "
        operateStack.removeAll(keepCapacity: false)
        operandStack.removeAll(keepCapacity: false)
        userISInTheMiddleOFTypingNumber = false
        dotPressed  = false
    }
    
    @IBAction func computeAnswer() {
        if mainDigitLabel.text != " " {
            operandStack.append(displayValue)
        } else {
            // remove the last operator from the stack
            // and the computeLog
            operateStack.removeLast()
            computeLogLabel.text = computeLogLabel.text!.substringToIndex(computeLogLabel.text!.endIndex.predecessor())
        }
        println("operandStack = \(operandStack), operateStack = \(operateStack)")
        computeLogLabel.text = computeLogLabel.text! + " = "
        
        // 2 * 3 + 6 * 4
        
        //   2 + 3 * 5 + 6 * 10 - 2
        // -> 2 + 15 + 60 -2
        // -> 17 + 60 -2
        // -> 77 - 2 
        // -> 75
        
        // 4 - 2 + 2 * 10
        performCalculation("×")
        performCalculation("÷")
        performCalculation("+")
        performCalculation("-")
        
        displayValue = operandStack[0]
        
        

    }
    
    func performCalculation(oprSymbol: String) {
//        println("-> \(oprSymbol)")
        var index:Int = 0
        for sym in operateStack {
            if oprSymbol == sym {
                var newTotal:Double = 0.0
                switch sym {
                case "×" :
                    newTotal  = operandStack[index] * operandStack[index + 1]
                case "÷" :
                    newTotal = operandStack[index] / operandStack[index + 1]
                case "+" :
                    newTotal = operandStack[index] + operandStack[index + 1]
                case "-" :
                    newTotal = operandStack[index] - operandStack[index + 1]
                default : break
                }
                println("\(operandStack[index]) \(oprSymbol) \(operandStack[index + 1]) = \(newTotal)")
                operandStack[index] = newTotal
                operandStack.removeAtIndex(index + 1)
                operateStack.removeAtIndex(index)
                println("At Calculation operandStack = \(operandStack), operateStack = \(operateStack)")
                index--
             }
            index++
        }
        
    }
    
 
}

