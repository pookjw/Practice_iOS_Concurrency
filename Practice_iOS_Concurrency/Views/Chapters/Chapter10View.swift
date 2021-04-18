//
//  Chapter10View.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

import SwiftUI

struct Chapter10View: View {
    var viewModel: Chapter10ViewModel = .init()
    
    var body: some View {
        List {
            ForEach(viewModel.actions, id: \.title) { chapterAction in
                Button(chapterAction.title, action: chapterAction.action)
            }
        }
        .navigationTitle(Text("Chapter 10"))
        .onAppear(perform: {
            print("***** Chapter 10 *****")
            if viewModel.loadLastAction {
                viewModel.getLastAction()()
            }
        })
    }
}

