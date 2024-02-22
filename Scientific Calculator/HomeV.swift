//
//  ContentView.swift
//  Scientific Calculator
//
//  Created by dgsw8th71 on 2/21/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HomeV: View {
    
    @State var Value: Double = 0.0
    @State var Operator = ""
    @State var Operand: Double = 0.0
    @State var isOperandInput: Bool = false
    @State var result = "0"
    
    private let uiData = [
        ["AC", "+/-", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(result)
                    .font(.custom("", size: 60))
                    .frame(minHeight: 150)
                    .multilineTextAlignment(.trailing)
            }
            Grid {
                ForEach(uiData, id: \.self) { i in
                    GridRow {
                        ForEach(i, id: \.self) { j in
                            Button {
                                if j == "=" {
                                    getResult()
                                    return
                                }
                                for k in OperatorGroup.allCases {
                                    if k.rawValue == j {
                                        processOperator(text: j)
                                        return
                                    }
                                }
                                proccessNumber(text: j)
                            } label: {
                                Text(j)
                                    .font(.title)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .frame(width: j == "0" ? 200 : 100, height: 100)
                            .gridCellColumns(j == "0" ? 2 : 1)
                        }
                    }
                }
            }
        }
        .padding()
        .padding()
    }
    
    func proccessNumber(text: String?) {
        
        var currentString = result
        
        if isOperandInput {
            currentString = "0"
            isOperandInput = false
        }
        
        if let input = text {
            if input == NumberGroup.ac.rawValue {
                currentString = NumberGroup.zero.rawValue
                Operator = ""
                
            } else if input == NumberGroup.sign.rawValue{
                if currentString[currentString.startIndex] == Character(NumberGroup.negative.rawValue) {
                    currentString.remove(at: currentString.startIndex)
                }else {
                    currentString = NumberGroup.negative.rawValue + currentString
                }
                
            } else if input != NumberGroup.dot.rawValue && currentString == NumberGroup.zero.rawValue{
                        currentString = input
            } else if input != NumberGroup.dot.rawValue && currentString == NumberGroup.negative.rawValue+NumberGroup.zero.rawValue{
                currentString = NumberGroup.negative.rawValue+input
                
            } else if input == NumberGroup.percent.rawValue {
                let decimal = (currentString as NSString).doubleValue
                currentString = String(decimal/100)
                
            } else if input == NumberGroup.dot.rawValue && currentString.contains(NumberGroup.dot.rawValue) {
                return
                
            } else {
                currentString += input
            }
        }
        
        if Operator == "" {
            Value = (currentString as NSString).doubleValue
            print("Value: \(Value)")
        } else {
            Operand = (currentString as NSString).doubleValue
            print("Operand: \(Operand)")
        }
        
        result = currentString
        
    }
    
    func processOperator(text: String) {
        Operator = text
        isOperandInput = true
        print("Operator: \(Operator)")
    }
    
    func getResult() {
        var result: Double
        
        switch Operator {
        case OperatorGroup.divide.rawValue:
            result = Value/Operand
            break
            
        case OperatorGroup.multiply.rawValue:
            result = Value*Operand
            break
            
        case OperatorGroup.sub.rawValue:
            result = Value-Operand
            break
            
        case OperatorGroup.add.rawValue:
            result = Value+Operand
            break
            
        default:
            return
        }
        
        Value = result
        if result.truncatingRemainder(dividingBy: 1) == 0.0 {
            self.result = String(Int(result))
        } else {
            self.result = String(result)
        }
        
    }
    
}

