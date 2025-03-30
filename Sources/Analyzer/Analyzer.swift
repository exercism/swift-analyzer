import Foundation
import SwiftFormat

class Analyzer {
    public var comments: [Comment]

    init(comments: [Comment] = []) {
        self.comments = comments
    }

    func parser(finding: Finding) {
    var type : Something
    switch finding.severity {
    case .error:
      type = .essential
    case .warning:
      type = .actionable
    default:
      type = .informative
    }
    print(finding.message)

    var comment: Comment

    if let location = finding.location {
      print(location)
      print(location.line)
      print(location.column)
      comment = Comment(comment: "swift-linter", params: ["message": finding.message.text, "line": String(location.line), "column": String(location.column)], type: type)
    }
    else {
      comment = Comment(comment: "swift-linter", params: ["message": finding.message.text, ], type: type)
    }
    comments.append(comment)
  }
}
