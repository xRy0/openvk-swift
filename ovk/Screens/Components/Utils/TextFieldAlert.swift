//
//  TextFieldAlert.swift
//  OpenVK Swift
//
//  Created by Ry0 on 15.06.2025.
//
import SwiftUI
import UIKit

struct TextFieldAlert {
    var title: String
    var message: String?
    var placeholder: String = ""
    var accept: String = "OK"
    var cancel: String = "Cancel"
    var action: (String?) -> Void
}

struct TextFieldWrapper: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let alert: TextFieldAlert

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard context.coordinator.alert == nil, isPresented else { return }

        let alertController = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: .alert
        )
        
        alertController.addTextField { textField in
            textField.placeholder = alert.placeholder
        }

        alertController.addAction(UIAlertAction(title: alert.cancel, style: .cancel) { _ in
            alert.action(nil)
            isPresented = false
        })

        alertController.addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
            let text = alertController.textFields?.first?.text
            alert.action(text)
            isPresented = false
        })

        context.coordinator.alert = alertController
        DispatchQueue.main.async {
            uiViewController.present(alertController, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var alert: UIAlertController?
    }
}
