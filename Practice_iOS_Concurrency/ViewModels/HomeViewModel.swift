//
//  HomeViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/11/21.
//

import SwiftUI

class HomeViewModel {
    let pushToLastChapter: Bool = true
    let listOfChapters: [Int] = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    func getView(at index: Int) -> some View {
        switch index {
        case 2:
            return AnyView(Chapter2View())
        case 3:
            return AnyView(Chapter3View())
        case 4:
            return AnyView(Chapter4View())
        case 5:
            return AnyView(Chapter5View())
        case 6:
            return AnyView(Chapter6View())
        case 7:
            return AnyView(Chapter7View())
        case 8:
            return AnyView(Chapter8View())
        case 9:
            return AnyView(Chapter9View())
        case 10:
            return AnyView(Chapter10View())
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
