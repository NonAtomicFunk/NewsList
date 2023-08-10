//
//  ContentView.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 08.08.2023.
//

import SwiftUI
//import CoreData
import Combine

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = ContentViewViewModel()
    @State private var searchedText: String = ""
    @State private var selectedDate = Date()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(self.viewModel.data) { item in
//                    Text(item.name!, formatter: itemFormatter)
//                }
//            }
//        }
//    }
    
    var body: some View {

        DatePicker("", selection: $selectedDate, displayedComponents: .date)
            .padding(EdgeInsets(top: 16,
                                leading: 8,
                                bottom: 0,
                                trailing: 20))
        NavigationView {
            List(viewModel.filteredNewsItems/*newsItems*/) { item in
                
                NavigationLink {
//                        Text("Items")
                } label: {
                    Text(item.title ?? "")
                }.searchable(text: $searchedText, placement: .navigationBarDrawer(displayMode: .always))
                    .onChange(of: searchedText.lowercased()) { newValue in
                        self.viewModel.filteredNewsItems = self.viewModel.newsItems.filter({ $0.title!.lowercased()
                            
                            .contains(newValue.lowercased())})
//                            starts(with: newValue)})
                    }
//                    .onChange(of: searchedText) X { search Ways in
//                        self.viewModel.filteredNewsItems = self.viewModel.newsItems.filter({ $0.name.starts(with: search)})
//                    }
//                }
//                .onDelete(perform: deleteItems)
            }.onAppear {
//                Task {
                    viewModel.getRest()
//                }
            }
            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button {
//                        print("PIU")
//                    } label: {
//                        Text("Search Filters")
//                            .padding()
//                            .foregroundColor(.white)
////                            .background(.red)
//                    }
//                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
