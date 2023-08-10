//
//  ContentViewViewModel.swift
//  NewsListApp
//
//  Created by Alexander Berezovsky on 08.08.2023.
//

import SwiftUI

class ContentViewViewModel: ObservableObject {
    @Published var newsItems = [NewsItem]()
    @Published var filteredNewsItems = [NewsItem]()
    
    func getRest() {
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
    
    func readDate(from itemDate: Date?) -> String {
        guard itemDate != nil else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.string(from: itemDate!)
    }
}
