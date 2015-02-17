//
//  CalculatorModel.swift
//  bettercalculator
//
//  Created by coolboykl on 2/13/15.
//  Copyright (c) 2015 coolboykl. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    private enum OperationType: Printable {
        case BinaryOperation(String, (Double, Double) -> Double)
        case UnaryOperation(String, Double -> Double)
     
        var description: String {
            get {
                switch self {
                case .BinaryOperation(let symbol,_):
                    return symbol
                case .UnaryOperation(let symbol,_):
                    return symbol
                }
            }
        }
    }
    
    private var operandStack = [Double]()
    private var operateStack = [OperationType]()
    // Add the supported operation here
    private var supportedOperateStack = [String:OperationType]()
    
    init() {
        func initOperation(OpType: OperationType) {
            supportedOperateStack[OpType.description] = OpType
        }
        initOperation(OperationType.BinaryOperation("×", { $0 * $1 } ))
        initOperation(OperationType.BinaryOperation("÷", { $0 / $1 } ))
        initOperation(OperationType.BinaryOperation("+", { $0 + $1 } ))
        initOperation(OperationType.BinaryOperation("-", { $0 - $1 } ))
    }
    
    
    func pushOperand(operand: Double) {
        operandStack.append(operand)
    }
    
    func pushOperateType(symbol: String) {
        if let oprType = supportedOperateStack[symbol] {
            operateStack.append(oprType)
        }
    }
    
    
    func performEvaluation() -> Double {
        performCalculation("×")
        performCalculation("÷")
        performCalculation("+")
        performCalculation("-")
        return operandStack[0]
    }
    
    func performReset() {
        operandStack.removeAll(keepCapacity: false)
        operandStack.removeAll(keepCapacity: false)
    }
    
    private func performCalculation(oprSymbol: String) {
        var index:Int = 0
        
        for oprType in operateStack {
            if oprType.description == oprSymbol {
                var newTotal:Double = 0.0
            
                switch oprType {
                case .BinaryOperation(_, let operation):
                    newTotal = operation(operandStack[index], operandStack[index+1])
                case .UnaryOperation(_, let operation):
                    newTotal = operation(operandStack[index])
                
                }
                operandStack[index] = newTotal
                operandStack.removeAtIndex(index + 1)
                operateStack.removeAtIndex(index)
                index--
            }
            index++
        }
        
    }
    
}
