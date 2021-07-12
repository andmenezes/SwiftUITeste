//
//  ImagePickerUISwiftHelper.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 07/07/2021.
//

import SwiftUI
import UIKit

struct ImagePickerUISwiftHelper: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageDate: Data?
        
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerUISwiftHelper
        
        init(_ parent: ImagePickerUISwiftHelper) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                parent.imageDate = image.pngData()
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
