//
//  ContentView.swift
//  Final Grade Calculator
//
//  Created by Samuel Amante on 9/23/24.
//

import SwiftUI
struct ContentView: View {
    @State private var currentGradeTextField = ""
    @State private var finalWeightTextField = ""
    @State private var desiredGrade = 0.0
    @State private var requiredGrade = 0.0
    
    var body: some View {
        VStack {
            CustomText(text: "Final Grade Calculator")
            Spacer()
            
            CustomTextField(placeholder: "Current Semester Grade", variable: $currentGradeTextField)
            CustomTextField(placeholder: "Final Weight (%)", variable: $finalWeightTextField)
            Picker("Desired Semester Grade", selection: $desiredGrade){
                Text("A").tag(90.0)
                Text("B").tag(80.0)
                Text("C").tag(70.0)
                Text("D").tag(60.0)
            }
            .pickerStyle(.segmented)
            .padding()
            
            CustomText(text: "Required Grade on Final")
            CustomText(text: "\(String( format: "%.1f", requiredGrade))")
            Spacer()
                .padding()
        }
        .onChange(of: desiredGrade) { oldValue, newValue in
            calculateGrade()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
    }
    
    func calculateGrade() {
        if let currentGrade = Double(currentGradeTextField){
            if let finalWeight = Double(finalWeightTextField) {
                if finalWeight < 100 && finalWeight > 0 {
                    let finalPercentage = finalWeight / 100
                    requiredGrade = max (0.0,(desiredGrade - (currentGrade * (1.0 - finalPercentage)))) / finalPercentage
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct CustomTextField: View {
    let placeholder : String
    let variable : Binding<String>
    var body: some View {
        TextField(placeholder, text: variable)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
            .frame(width:200, height: 30)
            .font(.body)
            .padding()
    }
}

struct CustomText: View {
    let text : String
    var body: some View {
        Text(text)
            .font(.largeTitle).bold()
    }
}

