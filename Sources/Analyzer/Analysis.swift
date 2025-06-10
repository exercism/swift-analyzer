import Foundation

typealias Param = Dictionary<String, String>

struct Analysis : Codable {
    var comments: [Comment] = []
}

enum Kind : String, Codable {
    case informative
    case actionable
    case essential
    case celebratory
}

struct Comment : Codable {
    var comment: String
    var params: Param
    var type : Kind 
}
