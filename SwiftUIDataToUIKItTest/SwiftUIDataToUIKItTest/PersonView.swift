//
//  PersonView.swift
//  SwiftUIDataToUIKItTest
//
//  Created by ksnowlv on 2024/10/7.
//

import SwiftUI

struct PersonView: UIViewControllerRepresentable {
    @ObservedObject var person: Person
    @Binding var year:Int

     func makeUIViewController(context: Context) -> PersonViewController {
         let viewController = PersonViewController()
         viewController.person = person
         return viewController
     }

     func updateUIViewController(_ uiViewController: PersonViewController, context: Context) {
         uiViewController.person = person
         uiViewController.year = year
         uiViewController.updateUI() // 调用updateUI来更新视图
     }
}


