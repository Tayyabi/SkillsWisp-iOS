//
//  OTPTextField.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

@available(iOS 15.0, *)
struct OTPTextField: View {
    
    let numberOfField: Int
    
    @State var enterValue: [String]
    @FocusState private var fieldFocus: Int?
    
    
    init(numberOfField: Int) {
        self.numberOfField = numberOfField
        self.enterValue = Array(repeating: "", count: numberOfField)
    }
    
    var body: some View {
        HStack {
            
            ForEach(0..<numberOfField, id:\.self) { index in
                
                TextField("", text: $enterValue[index])
                    .keyboardType(.numberPad)
                    .frame(width: 48, height: 48)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
                    .focused($fieldFocus, equals: index)
                    .tag(index)
                    .onChange(of: enterValue[index]) { newValue in
                        
                        if enterValue[index].count > 1 {
                            enterValue[index] = String(enterValue[index].suffix(1))
                        }
                        
                        if !newValue.isEmpty {
                            if index == numberOfField - 1 {
                                fieldFocus = nil
                            }
                            else {
                                fieldFocus = (fieldFocus ?? 0) + 1
                            }
                        }
                        else {
                            fieldFocus = (fieldFocus ?? 0) - 1
                        }
                    }
            }
        }
    }
}

@available(iOS 15.0, *)
struct OTPTextField_Previews: PreviewProvider {
    static var previews: some View {
        OTPTextField(numberOfField: 4)
    }
}
