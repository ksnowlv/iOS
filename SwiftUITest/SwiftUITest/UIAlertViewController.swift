//
//  UIAlertViewController.swift
//  SwiftUITest
//
//  Created by ksnowlv on 2024/9/21.
//

import SwiftUI

struct UIAlertViewController: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var title: String
    var message: String

    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // 当 isPresented 为 true 时显示警报
        if isPresented, uiViewController.presentedViewController == nil {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                isPresented = false
            }
            alertController.addAction(okAction)
            uiViewController.present(alertController, animated: true)
        }
        // 当 isPresented 为 false 且当前有警报显示时关闭警报
        else if !isPresented, let alertController = uiViewController.presentedViewController as? UIAlertController {
            alertController.dismiss(animated: true)
        }
    }
}
