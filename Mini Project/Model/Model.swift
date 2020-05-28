import Foundation

class Model: Decodable, CustomStringConvertible {
    
    var title: String
    var data: [String: Int] = [:]
    var subItems: [Model]?
    var type: Typee?
    
    required init(title: String) {
        self.title = title
    }
    
    var description: String {
        return "{title: \(self.title), data: \(data), type: \(type)}"
    }

}

enum Typee: String, Decodable {
    case totalCases
    case totalDeaths
    case totalRecoveries
    case activeCases
    case totalTests
}
