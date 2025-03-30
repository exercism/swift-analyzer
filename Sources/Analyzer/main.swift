import Foundation
import SwiftFormat

struct Main {
  static func main(solutionFile: String, slug: String, analysisFile: String) {
    print("hi")
    let config = Configuration()
    let analyzer = Analyzer()
    let clousure = { (finding: Finding) in
      analyzer.parser(finding: finding)
    }

    let numbers = [1, 2, 3, 4, 5]

    let doubled = numbers.forEach { $0 * 2 }
    let somethingWhichCanBeNil: Int? = 3
    var unwrapped = somethingWhichCanBeNil!

    let Linter = SwiftLinter(configuration: config, findingConsumer: clousure)
    let fileUrl = URL(fileURLWithPath: solutionFile)
    print(fileUrl)
    try! Linter.lint(contentsOf: fileUrl)

    let analysis = Analysis(comments: analyzer.comments)
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    encoder.outputFormatting.update(with: .sortedKeys)
    do {
      let jsonData = try encoder.encode(analysis)
      // Optional: Convert JSON data to string for debugging purposes
      if let jsonString = String(data: jsonData, encoding: .utf8) {
        let fileURL = URL(fileURLWithPath: analysisFile)
        try jsonData.write(to: fileURL)
      }
    } catch {
      print("Failed to encode User: \(error)")
    }
  }
}



Main.main(solutionFile: CommandLine.arguments[1], slug: CommandLine.arguments[2], analysisFile: CommandLine.arguments[3])