//
//  MainMenu.swift
//  Pocket Tracker
//
//  Created by Yinan An on 1/6/22.
//

import SwiftUI
import CoreData

struct MainMenu: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @State var addRecordView = false
    @State var showHistoryView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("This is main menu")
                
                .sheet(isPresented: $addRecordView) {
                    AddRecord {title, category, amount, date, note in
                        addRecord(title: title, category: category, amount: amount, date: date, note: note)
                        self.addRecordView = false
                    }
                }
                NavigationLink(destination: RecordList()) {
                    Text("History records")
                }
            }
            .navigationTitle(Text("Pocket Tracker"))
            .navigationBarItems(trailing: Button("Add", action: {self.addRecordView.toggle()}))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
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
    
struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
                .environment(
                \.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
