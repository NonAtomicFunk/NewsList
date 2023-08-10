//
//  ContentView.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 08.08.2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewViewModel()
    @State private var searchedText: String = ""
    @State private var selectedDate = Date()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {

        NavigationView {
            VStack {
            DatePicker("Sort up to this date:", selection: $selectedDate, displayedComponents: .date)
                .padding(EdgeInsets(top: 16,
                                    leading: 20,
                                    bottom: 0,
                                    trailing: 20))
                .onChange(of: selectedDate) { newValue in
                    self.viewModel.filteredNewsItems = self.viewModel.newsItems
                        .filter({ $0.publishedAt! <= selectedDate
                        })
                    if !(self.searchedText.isEmpty) {
                        self.viewModel.filteredNewsItems = self.viewModel.filteredNewsItems.filter({ $0.title!.lowercased()
                            .contains(searchedText.lowercased())})
                    }
                }
            List(viewModel.filteredNewsItems) { item in
                
                NavigationLink {
                    VStack{

                        Text(item.title!)
                        AsyncImage(
                            url: URL(string: item.urlToImage ?? ""),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 300, maxHeight: 300)
                                    .cornerRadius(10)
                            },
                            placeholder: {
                                ProgressView()}
                        )
                        Text(item.description)
                            .padding(16)
                        Spacer()
                        Text("Source: \(item.sourceName!)")
                        Text("written by: \(item.author ?? "")")
                        Text(self.viewModel.readDate(from: item.publishedAt))
                    }
                    
                } label: {
                        Text(item.title ?? "")
                }.searchable(text: $searchedText, placement: .navigationBarDrawer(displayMode: .automatic))
                    .onChange(of: searchedText.lowercased()) { newValue in
                        
                        self.viewModel.filteredNewsItems = self.viewModel.newsItems.filter({ $0.title!.lowercased()
                            .contains(newValue.lowercased())})
                        
                        self.viewModel.filteredNewsItems = self.viewModel.filteredNewsItems
                            .filter({
                                $0.publishedAt! <= selectedDate
                                
                            })
                    }
            }.onAppear {
                    viewModel.getRest()
            }
            .toolbar {
            }
            } // << VStack
        } //<< NavigationView
    }
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
