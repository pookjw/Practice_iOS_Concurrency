//
//  HomeViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/11/21.
//

import SwiftUI

class HomeViewModel {
    let pushToLastChapter: Bool = true
    let listOfChapters: [Int] = [2, 3, 4, 6]
    
    func getView(at index: Int) -> some View {
        switch index {
        case 2:
            return AnyView(Chapter2View())
        case 3:
            return AnyView(Chapter3View())
        case 4:
            return AnyView(Chapter4View())
        case 6:
            return AnyView(Chapter6View())
        default:
            return AnyView(EmptyView())
        }
    }
    
    func getLastView() -> some View {
        guard let lastIndex: Int = listOfChapters.last else {
            return AnyView(EmptyView())
        }
        return AnyView(getView(at: lastIndex))
    }
}
