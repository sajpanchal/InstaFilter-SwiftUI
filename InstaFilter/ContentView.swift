//
//  ContentView.swift
//  InstaFilter
//
//  Created by saj panchal on 2021-08-03.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save Finished")
    }
}
struct ContentView: View {
    @State var image: Image?
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button(action: {
                self.showingImagePicker = true
            }, label: {
                Text("Select Image")
            })
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
            ImagePicker(image: self.$inputImage)
        })
    }
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
