//
//  Chapter3View.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/11/21.
//

import SwiftUI

struct Chapter3View: View {
    var viewModel: Chapter3ViewModel = .init()
    
    var body: some View {
        List {
            ForEach(viewModel.actions, id: \.title) { chapterAction in
                Button(chapterAction.title, action: chapterAction.action)
            }
        }
        .navigationTitle(Text("Chapter 3"))
        .onAppear(perform: {
            print("***** Chapter 3 *****")
            if viewModel.loadLastAction {
                viewModel.getLastAction()()
            }
        })
    }
}
