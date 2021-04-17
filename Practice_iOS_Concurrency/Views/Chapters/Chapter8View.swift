//
//  Chapter8View.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

import SwiftUI

struct Chapter8View: View {
    var viewModel: Chapter8ViewModel = .init()
    
    var body: some View {
        List {
            ForEach(viewModel.actions, id: \.title) { chapterAction in
                Button(chapterAction.title, action: chapterAction.action)
            }
        }
        .navigationTitle(Text("Chapter 8"))
        .onAppear(perform: {
            print("***** Chapter 8 *****")
            if viewModel.loadLastAction {
                viewModel.getLastAction()()
            }
        })
    }
}

