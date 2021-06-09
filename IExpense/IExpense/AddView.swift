//
//  AddView.swift
//  IExpense
//
//  Created by Dmitry on 09.06.2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showAlert = false
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                                    Button("Save") {
                                        if let actualAmount = Int(amount) {
                                            let item = ExpenseItem(name: name,
                                                                   type: type,
                                                                   amount: actualAmount)
                                            expenses.items.append(item)
                                            presentationMode.wrappedValue.dismiss()
                                        } else {
                                            showAlert = true
                                            amount = ""
                                        }
                                    }
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error!"),
                      message: Text("You can enter only integer type"))
        }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
