//
//  FileManagerBootcamp.swift
//  DownloadWithCombine2
//
//  Created by Frank Bara on 12/29/21.
//

import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        
        guard let data = image.jpegData(compressionQuality: 1.0) else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
//        data.write(to: <#T##URL#>)
        
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    let imageName: String = "BehindLaptop"
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                    .cornerRadius(10)
                }
                
                Button(action: {
                    
                }, label: {
                    Text("Save to FM")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                
                Spacer()
                
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
