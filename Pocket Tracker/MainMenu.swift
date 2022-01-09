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
                HStack {
    //                Text("This is main menu")
                    NavigationLink(destination: DayView()) {
                        VStack {
                            Image(systemName: "doc.text")
                                .foregroundColor(.blue)
                                .font(.title)
                            Text("\n").font(.caption2)
                            Text("Today")
                                .foregroundColor(.gray)
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor(displayP3Red: 0.0, green: 0.1, blue: 0.3, alpha: 0.05)))
                        .cornerRadius(20)
                    }
                    .padding([.trailing, .leading], 5)

                    
                    NavigationLink(destination: DayView()) {
                        VStack {
                            Image(systemName: "list.bullet.circle")
                                .foregroundColor(.red)
                                .font(.title)
                            Text("\n").font(.caption2)
                            Text("Week")
                                .foregroundColor(.gray)
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor(displayP3Red: 0.0, green: 0.1, blue: 0.3, alpha: 0.05)))
                        .cornerRadius(20)
                    }
                    .padding([.trailing, .leading], 5)
                    
                    NavigationLink(destination: DayView()) {
                        VStack {
                            Image(systemName: "calendar.circle")
                                .foregroundColor(.purple)
                                .font(.title)
                            Text("\n").font(.caption2)
                            Text("Month")
                                .foregroundColor(.gray)
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor(displayP3Red: 0.0, green: 0.1, blue: 0.3, alpha: 0.05)))
                        .cornerRadius(20)
                    }
                    .padding([.trailing, .leading], 5)
                    
                }
                .padding([.trailing, .leading], 15)
                .padding([.top, .bottom], 20)
                List {
                    NavigationLink(destination: RecordList()) {
                        Image(systemName: "highlighter")
                        Text("History records")
                    }
                    .sheet(isPresented: $addRecordView) {
                        AddRecord {title, category, amount, date, note in
                            addRecord(title: title, category: category, amount: amount, date: date, note: note)
                            self.addRecordView = false
                        }
                    }
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
