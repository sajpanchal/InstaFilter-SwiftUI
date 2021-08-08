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
    @State var filterRadius = 0.5
    @State var filterScale = 0.5
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var processedImage:UIImage?
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State var showingFilterSheet = false
    @State var showErrorAlert = false
    @State var filterBtnTitle: String = "Change Filter"
    let imageSaver = ImageSaver()
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
        let radius = Binding<Double> (
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        let scale = Binding<Double> (
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
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
                Text("Radius")
                Slider(value: radius)
            }
            .padding(.vertical)
            HStack {
                Text("Scale")
                Slider(value: scale)
            }
            .padding(.vertical)
            HStack {
                Button(filterBtnTitle) {
                    self.showingFilterSheet = true
                }
                Spacer()
                Button("Save") {
                    // save the picture
                    guard let processedImage = self.processedImage else {
                        return
                    }
                    
                    imageSaver.successHandler = {
                        print("Success!")
                    }
                    imageSaver.errorHandler = {
                        
                        showErrorAlert = true
                        print("Oops: \($0.localizedDescription)")
                    }
                    imageSaver.writeToPhotoAlbum(image: processedImage)
                }
            }
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitle("Instafilter")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
            ImagePicker(image: self.$inputImage)
        })
        .alert(isPresented: $showErrorAlert, content: {
            Alert(title: Text("Error"), message: Text("Something went wrong"), dismissButton:.default(Text("OK")))
        })
        .actionSheet(isPresented: $showingFilterSheet) {
           
            return ActionSheet(title: Text("Select a filter"), buttons: [
                            .default(Text("Crystallize")) {
                                self.setFilter(CIFilter.crystallize())
                                filterBtnTitle = "Crystallize"
                            },
                            .default(Text("Edges")) {
                                self.setFilter(CIFilter.edges())
                                filterBtnTitle = "Edges"
                            },
                            .default(Text("Gaussian Blur")) {
                                self.setFilter(CIFilter.gaussianBlur())
                                filterBtnTitle = "Gaussian Blur"
                            },
                            .default(Text("Pixellate")) {
                                self.setFilter(CIFilter.pixellate())
                                filterBtnTitle = "Pixellate"
                            },
                            .default(Text("Sepia Tone")) {
                                self.setFilter(CIFilter.sepiaTone())
                                filterBtnTitle = "Sepia Tone"
                            },
                            .default(Text("Unsharp Mask")) {
                                self.setFilter(CIFilter.unsharpMask())
                                filterBtnTitle = "Unsharp Mask"
                            },
                            .default(Text("Vignette")) {
                                self.setFilter(CIFilter.vignette())
                                filterBtnTitle = "Vignette"
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
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
