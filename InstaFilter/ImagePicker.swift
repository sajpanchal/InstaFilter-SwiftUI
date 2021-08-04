//
//  ImagePicker.swift
//  InstaFilter
//
//  Created by saj panchal on 2021-08-04.
//

import Foundation
import SwiftUI
struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIImagePickerController
    

}
