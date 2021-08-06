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
    @State var filterIntensity = 0.5
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                }
                else {
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .onTapGesture {
                self.showingImagePicker = true
            }
            HStack {
                Text("Intensity")
                Slider(value: self.$filterIntensity)
            }
            .padding(.vertical)
            HStack {
                Button("Change Filter") {
                    //change filter
                }
                Spacer()
                Button("Save") {
                    // save the picture
                }
            }
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitle("Instafilter")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
            ImagePicker(image: self.$inputImage)
        })
       
    }
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
