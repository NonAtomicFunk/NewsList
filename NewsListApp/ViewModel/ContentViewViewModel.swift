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
            } catch {
                print("!!!! Error decoding", error)
            }
        }

        dataTask.resume()
    }

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