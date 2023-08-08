//
//  DynamicFilteredView.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 08.08.2023.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View,T>: View where T: NSManagedObject {
    // MARK: Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (FetchedResults<T>)->Content
    
    // MARK: Building Custom ForEach which will give Coredata object to build View
    init(startDate: Date,endDate: Date,type: String,@ViewBuilder content: @escaping (FetchedResults<T>) -> Content) {
        let filterKey = "date"
        var predicate: NSPredicate!
        if type == "ALL" {
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [startDate,endDate])
        } else {
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND type == %@", argumentArray: [startDate,endDate,type])
        }
        // Adding Sort
        _request = FetchRequest(entity: T.entity(),
                                sortDescriptors: [.init(keyPath: \NewsItem.publishedAt,
                                                        ascending: false)],
                                predicate: type == "NONE" ? nil : predicate,animation: .easeInOut)
        self.content = content
    }
    
    var body: some View {
        content(request)
    }
}


struct DynamicFilteredSearchView<Content: View,T>: View where T: NSManagedObject {
    // MARK: Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (FetchedResults<T>) -> Content
    
    // MARK: Building Custom ForEach which will give Coredata object to build View
    init(value: String,@ViewBuilder content: @escaping (FetchedResults<T>) -> Content) {
        var predicate: NSPredicate!
        predicate = NSPredicate(format: "remark CONTAINS %@", value)
        // Adding Sort
        _request = FetchRequest(entity: T.entity(),
                                sortDescriptors: [.init(keyPath: \NewsItem.publishedAt,
                                                        ascending: false)],
                                predicate: predicate,animation: .easeInOut)
        self.content = content
    }
    
    var body: some View {
        content(request)
    }
}
