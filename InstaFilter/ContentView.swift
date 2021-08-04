//
//  ContentView.swift
//  InstaFilter
//
//  Created by saj panchal on 2021-08-03.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State var image: Image?
    @State var showingImagePicker = false
    
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
        .sheet(isPresented: $showingImagePicker, content: {
            ImagePicker()
        })
    }
    func loadImage() {
        guard let inputImage = UIImage(named: "image") else {
            return
        }
        let beginImage = CIImage(image: inputImage)
        let context = CIContext()
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else {
            return
        }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        //currentFilter.inputImage = beginImage
        
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        //currentFilter.radius = 200
        
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
        //get CIImage from currentFilter.
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        // get CGImage from CIImage.
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            // convert UIImage to Image
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
