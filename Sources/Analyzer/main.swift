import Foundation
import SwiftFormat

struct Main {
  static func main(solutionFile: String, slug: String, analysisFile: String) {
    let config = Configuration()
    let analyzer = Analyzer()
    let clousure = { (finding: Finding) in
      analyzer.parser(finding: finding)
    }

    let Linter = SwiftLinter(configuration: config, findingConsumer: clousure)
    let fileUrl = URL(fileURLWithPath: solutionFile)
    try! Linter.lint(contentsOf: fileUrl)

    let analysis = Analysis(comments: analyzer.comments)
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    encoder.outputFormatting.update(with: .sortedKeys)
    do {
      let jsonData = try encoder.encode(analysis)
      let fileURL = URL(fileURLWithPath: analysisFile)
      try jsonData.write(to: fileURL)
    } catch {
      print("Failed to encode User: \(error)")
    }
  }
}



Main.main(solutionFile: CommandLine.arguments[1], slug: CommandLine.arguments[2], analysisFile: CommandLine.arguments[3])