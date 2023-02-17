import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }

  func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
    guard let url = URL(string:"https://api.github.com/users/\(user)/repos") else {
      return
    }

    network.performGet(url: url) { data in
      guard let data = data else {
        return completion(nil)
      }
      do {
        let repositories = try JSONDecoder().decode([Repository].self, from: data)
        completion(repositories)
      } catch {
        print(error.localizedDescription)
        completion(nil)
      }
    }
  }
}
