//
//  Chapter2View.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/11/21.
//

import SwiftUI

struct Chapter2View: View {
    var viewModel: Chapter2ViewModel = .init()
    
    var body: some View {
        List {
            ForEach(viewModel.actions, id: \.title) { chapterAction in
                Button(chapterAction.title, action: chapterAction.action)
            }
        }
        .navigationTitle(Text("Chapter 2"))
        .onAppear(perform: {
            print("***** Chapter 2 *****")
            if viewModel.loadLastAction {
                viewModel.getLastAction()()
            }
        })
    }
}
