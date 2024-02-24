//
//  AddView.swift
//  iExpense
//
//  Created by Юрий on 24.02.2024.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Binding var currencyCode: String
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount,format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
                
                Picker("Select Currency", selection: $currencyCode) {
                    Text("USD").tag("USD")
                    Text("EUR").tag("EUR")
                    Text("RUB").tag("RUB")
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(currencyCode: .constant("RUB"), expenses: Expenses())
}
