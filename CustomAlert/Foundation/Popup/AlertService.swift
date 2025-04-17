//
//  AlertService.swift
//  CustomAlert
//
//  Created by 허광호 on 4/17/25.
//

import SwiftUI

final class AlertService: ObservableObject {
    typealias AnyAlert = Alert<AnyView>
    
    static let shared = AlertService()
    
    private init() {}
    
    @Published private(set) var currentAlert: AnyAlert?
    
    private var queue: [AnyAlert] = []
    private var isPresenting = false
    
    func enqueue<Content: View>(_ alert: Alert<Content>) {
        let anyAlert = Alert<AnyView>(
            title: alert.title,
            isTapDismiss: alert.isTapDismiss,
            buttons: alert.buttons,
            content: { AnyView(alert.content) },
            completion: alert.completion
        )
        queue.append(anyAlert)
        presentNext()
    }
    
    private func presentNext() {
        guard !isPresenting, let alert = queue.first else { return }
        isPresenting = true
        currentAlert = alert
    }
    
    func dismiss() {
        guard !queue.isEmpty else { return }
        queue.removeFirst()
        isPresenting = false
        currentAlert = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.presentNext()
        }
    }
}
