//
//  RecordRow.swift
//  Pocket Tracker
//
//  Created by Yinan An on 1/4/22.
//

import SwiftUI

 struct RecordRow: View {
    let record: Record
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    } ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                record.title.map(Text.init).font(.title)
                Spacer()
                let amount = record.amount
                Text("\(String(amount))").font(.title)
            }
            
            HStack {
                record.category.map(Text.init).font(.caption)
                Spacer()
                record.date.map{Text(Self.dateFormatter.string(from: $0))}.font(.caption)
            }
            
            HStack {
                Text("Note:").font(.caption)
                record.note.map(Text.init).font(.caption)
            }
        }
    }
}
