//
//  ContentView.swift
//  Test
//
//  Created by insub on 2023/05/31.
//

import SwiftUI

struct ContentView: View {
    
    let items = Array(repeating: "", count: 100)
    
    var body: some View {
        ObservableScrollView(
            offsetChanged: didScroll(_:),
            hasRefresh: true,
            refresh: refresh
        ) {
            ForEach(Array(items.enumerated()), id: \.offset) { offset, item in
                Text(String(offset))
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(Color.white)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
            }
        }
    }
}

extension ContentView {
    
    func refresh() {
        print("didPull")
    }
    
    func didScroll(_ offset: CGPoint) {
        print(offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
        }
    }
}
