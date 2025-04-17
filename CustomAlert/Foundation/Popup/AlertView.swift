//
//  AlertView.swift
//  CustomAlert
//
//  Created by 허광호 on 4/17/25.
//

import SwiftUI

struct AlertView: View {
    let alert: Alert<AnyView>
    let dismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .onTapGesture {
                    if alert.isTapDismiss {
                        dismiss()
                    }
                }
            
            VStack(spacing: 0) {
                if !alert.title.isEmpty {
                    Text(alert.title)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 46)
                }
                
                // Custom View
                alert.content
                
                // Bottom Buttons
                HStack(spacing: 0) {
                    ForEach(alert.buttons.indices, id: \.self) { index in
                        let button = alert.buttons[index]
                        
                        Button(button.title) {
                            alert.completion?(button)
                            dismiss()
                        }
                    }
                }
                .padding([.leading, .trailing, .bottom], 20)
                .animation(nil, value: alert.buttons)
            }
            .background(.white)
            .cornerRadius(10)
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}


// MARK: Bottom Button Style

struct AlertButtonStyle: ButtonStyle {
    let type: AlertButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(type.textColor)
            .background(
                configuration.isPressed
                ? type.backgroundColorPre
                : type.backgroundColorNor
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(type.borderColor, lineWidth: 1)
            )
    }
}

// MARK: Alert Modifier

struct AlertModifier: ViewModifier {
    @ObservedObject var queue = AlertService.shared
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if let alert = queue.currentAlert {
                AlertView(alert: alert) {
                    queue.dismiss()
                }
            }
        }
    }
}

extension View {
    func alertModifier() -> some View {
        return modifier(AlertModifier())
    }
}
