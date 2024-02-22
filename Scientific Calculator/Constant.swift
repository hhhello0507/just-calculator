//
//  Constant.swift
//  Scientific Calculator
//
//  Created by dgsw8th71 on 2/21/24.
//

import Foundation

enum NumberGroup: String, CaseIterable {
    case ac = "AC"
    case sign = "+/-"
    case percent = "%"
    case positive = "+"
    case negative = "-"
    case dot = "."
    
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
}

enum OperatorGroup: String, CaseIterable {
    case add = "+"
    case sub = "-"
    case multiply = "×"
    case divide = "÷"
    case result = "="
    
}
