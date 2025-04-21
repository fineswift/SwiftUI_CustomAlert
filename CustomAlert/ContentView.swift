//
//  ContentView.swift
//  CustomAlert
//
//  Created by 허광호 on 4/16/25.
//

import SwiftUI

protocol BaseView: View {
    associatedtype Content: View
    
    @ViewBuilder var content: Content { get }
}

extension BaseView {
    var body: some View {
        content
            .alertModifier()
    }
}

struct ContentView: BaseView {
    var content: some View {
        VStack(spacing: 20) {
            Button("First Alert") {
                Alert<Content_Text>.show(
                    title: "First",
                    isTapDismiss: true,
                    buttons: [.confirm]) {
                        Content_Text(text: "First Message")
                    }
            }
            
            Button("Second Alert") {
                Alert.show(
                    title: "Second",
                    buttons: [.custom("수락"), .cancel]
                ) {
                    VStack {
                        Image(systemName: "bell")
                        Text("Second Message")
                    }
                    .padding()
                } completion: { action in
                    print(action.title)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
