//
//  DayView().swift
//  Pocket Tracker
//
//  Created by Yinan An on 1/9/22.
//

import SwiftUI
import CoreData

struct DayView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(entity: Record.entity(),
                  sortDescriptors: [
                    NSSortDescriptor(keyPath: \Record.date, ascending: false)
                ],
                  predicate: NSPredicate(format: "date >= %@ AND date <= %@",
                                         Calendar.current.startOfDay(for: Date()) as CVarArg,
                                         Calendar.current.date(byAdding: .day, value: 1,
                                                               to: Calendar.current.startOfDay(for: Date()))! as CVarArg
                                        ),
                  animation: .default
    ) private var records: FetchedResults<Record>
    
    let categories = GlobalVariables().categories
    let calculte = Calculate()
//    init() {
//        returnRes = calculte.GetSeperateSum(records: records)
//    }
    
    var body: some View {
        let returnRes = calculte.GetSeperateSum(records: records)
        VStack {
            Section {
                Text("Graph here")
            }
            List {
                Section(header: Text("Summary")) {
                    
                    ForEach(returnRes, id:\.self) { name in
                        NavigationLink(destination: CategoryView()) {
                            Text(name)
                        }
                    }

                }
                
                Section(header: Text("All Records")) {
                    ForEach(records, id: \.title) {
                        RecordRow(record: $0)
                    }
                }.listStyle(InsetGroupedListStyle())
            }
            
        }
        .navigationBarTitle(Text("Today"))
        
    }
    
}
