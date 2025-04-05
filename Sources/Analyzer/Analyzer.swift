import Foundation
import SwiftFormat

class Analyzer {
    public var comments: [Comment]

    init(comments: [Comment] = []) {
        self.comments = comments
    }

    func parser(finding: Finding) {
    var type : Kind
    switch finding.severity {
    case .error:
      type = .essential
    case .warning:
      type = .actionable
    default:
      type = .informative
    }

    var comment: Comment

    if let location = finding.location {
      comment = Comment(comment: "swift.swift-linter.\(finding.severity)", params: ["message": finding.message.text, "line_number": String(location.line), "column_number":  String(location.column)], type: type)
    }
    else {
      comment = Comment(comment: "swift.swift-linter.\(finding.severity)", params: ["message": finding.message.text, ], type: type)
    }
    comments.append(comment)
  }
}
