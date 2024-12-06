//
//  HoomeViewModel.swift
//  Practiceinterview
//
//  Created by Farah Metoui on 6/12/2024.
//

import Foundation

class HomeViewModel : ObservableObject{
    
    @Published var products :[Product] = []
    @Published var errorMessage: String?
    func fetchProducts() async {
        do {
            print("Fetching products...")  // Debug statement
            let fetchedProducts : [Product] = try await NetworkManager.shared.read(endpoint: "products")
            print("Fetched products: \(fetchedProducts)")  // Debug statement
            
            // Make sure to update the published property on the main thread
            DispatchQueue.main.async {
                self.products = fetchedProducts
            }
 // Debug statement
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching products: \(error.localizedDescription)")  // Debug statement
        }
    }
    

    
    
    
}
