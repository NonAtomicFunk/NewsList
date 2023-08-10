//
//  ContentViewViewModel.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 08.08.2023.
//

import SwiftUI
//import Combine

class ContentViewViewModel: ObservableObject {
    @Published var newsItems = [NewsItem]()
    @Published var filteredNewsItems = [NewsItem]()
//    @Published var searchText = "9 Ways"
    
//    var filteredNewsItems: [NewsItem] {
//        let filteredItems = newsItems.filter { searchTextAppears(in: $0.title!
//            )
//        }
//    }
    
//    var filteredNewsItems: [NewsItem] {
//        guard !newsItems.isEmpty else {return []}
//        let filteredList = newsItems.filter {
//            self.searchTextAppears(in: $0.title!)
//        }
////        let sections = Set<Int>(filteredList.map { $0.sectionIndex }).sorted()
//        print("filteredList COUNT: ", filteredList.count)
//        print(filteredNewsItems.first!)
//        return filteredNewsItems
//    }
                                                                 
                                                                 
//    @Published var filteredNewsItem = [NewsItem]()
    
//    init() {
//        Publishers.CombineLatest($newsItems, $searchText)
//            .map {filterKeyWords, items in
//                items.filter(<#T##isIncluded: (Character) throws -> Bool##(Character) throws -> Bool#>)
//            }
////      Publishers.CombineLatest($searchText, $newsItems)
////        .map { filter, items in
////          items.filter { item in
////            filter.isEmpty ? true : item(filter)
////          }
////        }
////        .assign(to: &filteredNewsItem)
//    }
    
    func getRest() { //-> [NewsItem] {//        var modelsArray: [NewsItem] = []
        let urlRequest = URLRequest(url: URL(string: Constants.baseURLString)!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                let models = try JSONDecoder().decode(NewsItemArray.self, from: data)
                self.newsItems = models.newsItems
                self.filteredNewsItems = models.newsItems
            } catch {
                print("!!!! Error decoding", error)
            }
        }

        dataTask.resume()
    }
    
//    private func searchTextAppears(in name: String) -> Bool {
//        guard searchText != "" else {
//            return true
//        }
//        let cleanedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
//        if cleanedSearchText.isEmpty {
//            return true
//        }
//        return name.localizedCaseInsensitiveContains(cleanedSearchText.lowercased())
//    }

//    func getRest() async throws {
//        let urlRequest = URLRequest(url: URL(string: Constants.baseURLString)!)
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
//            guard let data = data else { return }
//            do {
//                let decodedFood = try JSONDecoder().decode(NewsItem.self, from: data)
//                print("Completion handler decodedFood", decodedFood)
//            } catch {
//                print("Error decoding", error)
//            }
//        }
//
//        dataTask.resume()
//    }
}
