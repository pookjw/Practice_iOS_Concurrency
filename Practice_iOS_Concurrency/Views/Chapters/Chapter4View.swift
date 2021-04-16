//
//  Chapter4View.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/16/21.
//

import SwiftUI

import SwiftUI

struct Chapter4View: View {
    var viewModel: Chapter4ViewModel = .init()
    
    var body: some View {
        List {
            ForEach(viewModel.actions, id: \.title) { chapterAction in
                Button(chapterAction.title, action: chapterAction.action)
            }
        }
        .navigationTitle(Text("Chapter 4"))
        .onAppear(perform: {
            print("***** Chapter 4 *****")
            if viewModel.loadLastAction {
                viewModel.getLastAction()()
            }
        })
    }
}
