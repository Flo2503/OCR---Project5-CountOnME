//
//  Calculation.swift
//  CountOnMe
//
//  Created by Flo on 24/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class SimpleCalc {
    // MARK: - // Error check computed methods
    func expressionIsCorrect(_ elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    func expressionHaveEnoughElement(_ elements: [String]) -> Bool {
        return elements.count >= 3
    }
    func canAddPoint(_ elements: [String]) -> Bool {
        if let lastElement = elements.last { return Int(lastElement) != nil }
        return false
    }
    // Method called when tapped equal button
    func didTappedEqualButton(_ elements: [String]) -> String? {
        // MARK: - Property
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            // MARK: - Property
            let operand = operationsToReduce[1]
            guard expressionHaveEnoughElement(elements) && expressionIsCorrect(elements) else {
                return nil
            }
            if let left = Float(operationsToReduce[0]), let right = Float(operationsToReduce[2]) {
                var result: Float
                // Check that the decimal is necessary
                var isInteger: Bool {
                    return floorf(result) == result
                }
                // Check that the number is not divided by zero
                var isDevidedByZero: Bool {
                    return operationsToReduce[1] == "/" && operationsToReduce[2] == "0"
                }
                // Read the operator to choose the right calculation
                switch operand {
                case "x": result = Float(left * right)
                case "/": result = Float(left / right)
                case "+": result = Float(left + right)
                case "-": result = Float(left - right)
                default: return nil
                }
                if isDevidedByZero {
                    return nil
                }
                // Reduce each operations
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                if isInteger {
                    operationsToReduce.insert("\(Int(result))", at: 0)
                } else {
                    operationsToReduce.insert("\(result)", at: 0)
                }
            }
        }
        return operationsToReduce.first
    }
    func test(_ elements: [String]) -> String? {
        var operationsToReduce = elements
        while elements.contains("x") || elements.contains("/") {
            if let index = elements.firstIndex(where: {$0 == "x" || $0 == "/"}), let left = Float(operationsToReduce[index - 1]), let right = Float(operationsToReduce[index + 1]) {
                var result: Float
                let operand = operationsToReduce[index]
                switch operand {
                case "x": result = Float(left * right)
                case "/": result = Float(left / right)
                default: return nil
                }
                operationsToReduce[index - 1] = "\(result)"
                operationsToReduce.remove(at: index + 1)
                operationsToReduce.remove(at: index)
            }
            
        }
        return nil
    }
}

