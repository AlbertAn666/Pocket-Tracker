//
//  AddRecord.swift
//  Pocket Tracker
//
//  Created by Yinan An on 1/3/22.
//

import SwiftUI

struct AddRecord: View {
//    public var categories = ["Online Shopping", "Groceries", "Food & Drink", "Transportation", "Entertainment", "Other"]
    
    @StateObject var globalVariables = GlobalVariables()
    
    @State var title = ""
    @State var category = ""
    @State var amount = Double()
    @State var date = Date()
    @State var note = ""
    @State var amount_str = ""
    public let onComplete: (String, String, Double, Date, String) -> Void
    
    var body: some View {
        NavigationView {
            let categories = globalVariables.categories
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $title)
                }
                Section(header: Text("Category")) {
                    Picker("Please select", selection: $category, content: {
                        ForEach(categories, id: \.self, content: {category in Text(category)})
                    })
                }
                Section(header: Text("Expenses")) {
                    TextField("Expenses", text: $amount_str)
                }
                Section {
                    DatePicker(
                        selection: $date,
                        displayedComponents: .date
                    ) {
                            Text("Date").foregroundColor(Color(.gray))
                    }
                }
                Section(header: Text("Note")) {
                    TextField("Note", text: $note)
                }
                Section {
                    Button(action: addRecordAction) {
                        Text("Add record")
                    }
                }
            }
            .navigationBarTitle(Text("Add Record"), displayMode: .inline)
        }
    }
    
    private func addRecordAction() {
        amount = Double(amount_str) ?? 0.0
        onComplete(title, category.isEmpty ? "Other" : category,
                   amount, date, note)
    }
}

