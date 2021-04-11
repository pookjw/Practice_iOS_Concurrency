//
//  HomeView.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/11/21.
//

import SwiftUI

struct HomeView: View {
    var viewModel: HomeViewModel = .init()
    
    var body: some View {
        NavigationView {
            List {
                // List
                ForEach(viewModel.listOfChapters, id: \.self) { index in
                    NavigationLink(destination: viewModel.getView(at: index)) {
                        Text("Chapter \(index)")
                    }
                }
                
                // Push to Last Chapter when app is loaded
                NavigationLink(
                    "Last Chapter",
                    destination: viewModel.getLastView(),
                    isActive: .constant(viewModel.pushToLastChapter)
                )
                .hidden()
            }
            .navigationTitle(Text("Concurrency"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
