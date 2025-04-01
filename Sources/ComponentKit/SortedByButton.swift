//
//  SortedByButton.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 25/3/25.
//

import SwiftUI

public enum SortedBy: String, CaseIterable, Identifiable {
    case byID = "Order by Default"
    case ascending = "Order by Title ascending"
    case descending = "Order by Title descending"
    
    public var id: Self { self }
}


fileprivate struct SortedByButton: ViewModifier {
    @Binding var orderBy: SortedBy
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                #if os(macOS)
                ToolbarItem(placement: .secondaryAction) {
                    menu
                }
                #else
                ToolbarItem(placement: .topBarLeading) {
                    menu
                }
                #endif
            }
    }
    
    var menu: some View {
        Menu {
            ForEach(SortedBy.allCases) { option in
                Button {
                    orderBy = option
                } label: {
                    Text(option.rawValue)
                }

            }
            
        } label: {
            Text("Order By")
        }
    }
}

extension View {
    public func sortedByButton(orderBy: Binding<SortedBy>) -> some View {
        modifier(SortedByButton(orderBy: orderBy))
    }
}
