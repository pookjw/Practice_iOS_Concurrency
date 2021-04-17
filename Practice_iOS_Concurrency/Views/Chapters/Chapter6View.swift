//
//  Chapter6View.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/17/21.
//

import SwiftUI

struct Chapter6View: View {
    var viewModel: Chapter6ViewModel = .init()
    
    var body: some View {
        List {
            ForEach(viewModel.actions, id: \.title) { chapterAction in
                Button(chapterAction.title, action: chapterAction.action)
            }
        }
        .navigationTitle(Text("Chapter 6"))
        .onAppear(perform: {
            print("***** Chapter 6 *****")
            if viewModel.loadLastAction {
                viewModel.getLastAction()()
            }
        })
    }
}

