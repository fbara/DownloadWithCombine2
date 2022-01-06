//
//  PhotoModelDataService.swift
//  DownloadWithCombine2
//
//  Created by Frank Bara on 1/3/22.
//

import Foundation
import Combine

class PhotoModelDataService {
    static let instance = PhotoModelDataService() // singleton
    
    @Published var photoModels: [PhotoModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        // downloads the data but doesn't display to the screen
        // result of the download is stored in [photoModels]
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print("ERROR DOWNLOADING DATA: \(err.localizedDescription)")
                }
            } receiveValue: { [weak self] (returnedPhotoModels) in
                self?.photoModels = returnedPhotoModels
            }
            .store(in: &cancellables)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw URLError(.badServerResponse)
              }
        return output.data
    }
}
