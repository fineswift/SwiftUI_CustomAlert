//
//  Content_Text.swift
//  CustomAlert
//
//  Created by 허광호 on 4/21/25.
//

import SwiftUI

struct Content_Text: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 16))
            .padding([.top, .horizontal], 20)
            .padding(.bottom, 36)
    }
}

#Preview {
    Content_Text(text: "Test Message")
}
