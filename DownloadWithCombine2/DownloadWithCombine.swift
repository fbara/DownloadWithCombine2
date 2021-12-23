//
//  DownloadWithCombine.swift
//  DownloadWithCombine2
//
//  Created by Frank Bara on 12/18/21.
//

import SwiftUI
import Combine

// MARK: - PostModel
struct PostModel: Codable, Identifiable {
    let userId, id: Int
    let title, body: String
    
    //    enum CodingKeys: String, CodingKey {
    //        case userID = "userId"
    //        case id, title, body
    //    }
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // 1. create the publisher
        URLSession.shared.dataTaskPublisher(for: url)
        // 2. subscribe publisher on background thread
            .subscribe(on: DispatchQueue.global(qos: .background))
        // 3. receive on main thread
            .receive(on: DispatchQueue.main)
        // 4. tryMap to check that the data is good
            .tryMap(handleOutput)
        // 5. decode the data into PostModels to ensure the data is correct
            .decode(type: [PostModel].self, decoder: JSONDecoder())
        // if there was an error, there will be a blank arry
            .replaceError(with: [])
        // 6. put the item into the app
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
        // 7. store the results (to cancel subscription later, if needed)
            .store(in: &cancellables)
        
            
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw URLError(.badServerResponse)
              }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
