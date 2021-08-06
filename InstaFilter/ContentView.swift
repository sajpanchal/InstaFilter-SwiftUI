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
                // select an image
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
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
