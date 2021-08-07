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
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State var showingFilterSheet = false
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double> (
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
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
                Slider(value: intensity)
            }
            .padding(.vertical)
            HStack {
                Button("Change Filter") {
                    self.showingFilterSheet = true
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
        .actionSheet(isPresented: $showingFilterSheet) {
           
            return ActionSheet(title: Text("Select a filter"), buttons: [
                            .default(Text("Crystallize")) {
                                self.setFilter(CIFilter.crystallize())
                            },
                            .default(Text("Edges")) {
                                self.setFilter(CIFilter.edges())
                            },
                            .default(Text("Gaussian Blur")) {
                                self.setFilter(CIFilter.gaussianBlur())
                            },
                            .default(Text("Pixellate")) {
                                self.setFilter(CIFilter.pixellate())
                            },
                            .default(Text("Sepia Tone")) {
                                self.setFilter(CIFilter.sepiaTone())
                            },
                            .default(Text("Unsharp Mask")) {
                                self.setFilter(CIFilter.unsharpMask())
                            },
                            .default(Text("Vignette")) {
                                self.setFilter(CIFilter.vignette())
                            },
                            .cancel()
                            
            ])
        }
       
    }
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
