import XCTest
@testable import snappy

final class snappy_swiftTests: XCTestCase {
    func testExample() throws {
        let exampleString = "He felt no need to assign a spot to an alternative faction, which shows his priority is projecting dominance over magnanimity, when he is facing international pushback,\" said Wen-ti Sung, a lecturer at the Australian National University."
        let exampleData = exampleString.data(using: .utf8)!
        let compressedData = try snappy.compress(exampleData)
        assert(compressedData.count > 0)
        assert(snappy.isSnappy(compressedData))
        let decompressedData = try snappy.decompress(compressedData)
        let decompressedString = String(data: decompressedData, encoding: .utf8)!
        assert(decompressedString == exampleString)
    }
}
