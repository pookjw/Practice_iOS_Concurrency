//
//  Chapter9View.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

import SwiftUI

struct Chapter9View: View {
    var viewModel: Chapter9ViewModel = .init()
    
    var body: some View {
        List {
            ForEach(viewModel.actions, id: \.title) { chapterAction in
                Button(chapterAction.title, action: chapterAction.action)
            }
        }
        .navigationTitle(Text("Chapter 9"))
        .onAppear(perform: {
            print("***** Chapter 9 *****")
            if viewModel.loadLastAction {
                viewModel.getLastAction()()
            }
        })
    }
}
