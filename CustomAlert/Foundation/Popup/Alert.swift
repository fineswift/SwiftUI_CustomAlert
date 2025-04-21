//
//  Alert.swift
//  CustomAlert
//
//  Created by 허광호 on 4/17/25.
//

import SwiftUI

enum AlertButtonType: Equatable {
    case confirm
    case cancel
    case custom(String)
    
    var title: String {
        switch self {
        case .confirm:
            return "확인"
        case .cancel:
            return "취소"
        case .custom(let string):
            return string
        }
    }
    
    enum ButtonType {
        case primary
        case secondary
        
        var isPrimary: Bool {
            return self == .primary
        }
    }
    
    var type: ButtonType {
        switch self {
        case .confirm:
            return .primary
        case .cancel:
            return .secondary
        default:
            return .primary
        }
    }
    
    var textColor: Color {
        return type.isPrimary ? .white : .black
    }
    
    var backgroundColorNor: Color {
        return type.isPrimary ? .black : .white
    }
    
    var backgroundColorPre: Color {
        return type.isPrimary ? .black.opacity(0.7) : Color(226, 226, 226)
    }
    
    var backgroundColorDis: Color {
        return type.isPrimary ? Color(214, 214, 214) : .white
    }
    
    var borderColor: Color {
        return type.isPrimary ? .clear : Color(226, 226, 226, 0.8)
    }
}

/// Custom Alert
///
/// 1.Add .alertModifier() to the view where you want to use the alert.
///
///     var body: some View {
///         VStack {
///             ...
///         }
///         .alertModifier()
///     }
///
/// 2.Use Alert.show to display the alert at the desired timing.
///
///     Button("Alert") {
///         Alert.show(
///             title: "Alert",
///             isTapDismiss: true,
///             buttons: [.confirm],
///             content: {
///                 // Custom View
///                 Content_Text(text: "The first alert")
///             },
///             completion: { action in
///                 if action == .confirm {
///                     print("first alert")
///                 }
///             }
///         )
///     }
///
///     OR
///
///     Alert<Content_Text>.show(
///         title: "Alert",
///         isTapDismiss: true,
///         buttons: [.confirm],
///         content: {
///             // Custom View
///             Content_Text(text: "The first alert")
///         },
///         completion: { action in
///             if action == .confirm {
///                 print("first alert")
///             }
///         }
///     )
/// 3.Add your custom alert view to the AlertViews folder and use it as needed.
struct Alert<Content: View> {
    typealias Action = ((AlertButtonType) -> Void)
    
    let title: String
    let isTapDismiss: Bool
    let buttons: [AlertButtonType]
    let content: Content
    let completion: Action?
    
    init(
        title: String,
        isTapDismiss: Bool,
        buttons: [AlertButtonType],
        @ViewBuilder content: () -> Content,
        completion: Action?
    ) {
        self.title = title
        self.isTapDismiss = isTapDismiss
        self.buttons = buttons
        self.content = content()
        self.completion = completion
    }
    
    private func show() {
        AlertService.shared.enqueue(self)
    }
}

extension Alert {
    static func show(
        title: String = "",
        isTapDismiss: Bool = false,
        buttons: [AlertButtonType] = [],
        @ViewBuilder content: () -> Content,
        completion: Action? = nil
    ) {
        Alert(
            title: title,
            isTapDismiss: isTapDismiss,
            buttons: buttons,
            content: content,
            completion: completion
        )
        .show()
    }
}
