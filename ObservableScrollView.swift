//
//  ObservableScrollView.swift
//  Test
//
//  Created by insub on 2023/06/03.
//

import SwiftUI

struct ObservableScrollView<Content: View>: View {
    
    let showsIndicators: Bool
    let offsetChanged: (CGPoint) -> Void
    let hasRefresh: Bool
    let refresh: () -> Void
    let content: Content
    
    init(
        showsIndicators: Bool = false,
        offsetChanged: @escaping (CGPoint) -> Void = { _ in },
        hasRefresh: Bool = true,
        refresh: @escaping () -> Void = { },
        @ViewBuilder content: () -> Content
    ) {
        self.showsIndicators = showsIndicators
        self.hasRefresh = hasRefresh
        self.offsetChanged = offsetChanged
        self.refresh = refresh
        self.content = content()
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: showsIndicators) {
            GeometryReader { proxy in
                Color.clear.preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: proxy.frame(in: .named("scrollView")).origin
                )
            }
            .frame(width: 0, height: 0)
            content
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
        .hasRefresh(hasRefresh, refresh)
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

extension View {
    
    @ViewBuilder
    func hasRefresh(
        _ state: Bool,
        _ action: @escaping () -> Void
    ) -> some View {
        
        switch state {
        case true:
            self
                .refreshable {
                    action()
                }
        case false:
            self
        }
    }
}
