//
//  RecordList.swift
//  Pocket Tracker
//
//  Created by Yinan An on 1/4/22.
//

import SwiftUI
import CoreData

struct RecordList: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(
        entity: Record.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Record.date, ascending: false)
        ],
        animation: .default
    ) private var records : FetchedResults<Record>
    
    @State var isPresented = false
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(records, id: \.title) {
                    RecordRow(record: $0)
                }
                .onDelete(perform: deleteRecord)
                // todo: tap event
                // skip to another page show the record detail and the user could modify it
//                .onTapGesture {
//                    self.showAlert = true
//
//                }.alert(isPresented: $showAlert,
//                        content: {
//                    Alert(title: Text("alert"))
//                })
            }
            .sheet(isPresented: $isPresented) {
                AddRecord {title, category, amount, date, note in
                    self.addRecord(title: title, category: category, amount: amount, date: date, note: note)
                    self.isPresented = false
                }
            }
            .navigationBarTitle(Text("History Records"))
            .navigationBarItems(trailing:
                                    Button(action: {self.isPresented.toggle()}) {
                                        Image(systemName: "plus")
                                    }
                                )
        }
    }
    
    
    private func deleteRecord(at offsets: IndexSet) {
        offsets.forEach { index in
          let record = self.records[index]
          self.managedObjectContext.delete(record)
        }
        saveContext()
    }
    
    private func addRecord(title: String, category: String, amount: Double, date: Date, note: String) {
        let newRecord = Record(context: managedObjectContext)
        
        newRecord.title = title
        newRecord.category = category
        newRecord.amount = amount
        newRecord.date = date
        newRecord.note = note
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error happened when saving managed object context")
        }
    }
}

struct RecordList_Previews: PreviewProvider {
    static var previews: some View {
        RecordList().environment(
            \.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
