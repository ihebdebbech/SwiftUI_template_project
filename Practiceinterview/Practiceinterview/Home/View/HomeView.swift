//
//  ContentView.swift
//  Practiceinterview
//
//  Created by Farah Metoui on 5/12/2024.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @StateObject var  homeviewmodel  = HomeViewModel()
    

    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                if homeviewmodel.products.isEmpty {
                    Text("Loading...") // Show loading text or indicator
                } else {
                    ForEach(homeviewmodel.products) { product in
                        Text(product.title)
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
            }.task {
                print("hello")
                await homeviewmodel.fetchProducts()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView() // Your main view
            // Optional: Specify the device for preview
    }
}




