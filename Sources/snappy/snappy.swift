//
//  snappy.swift
//
//
//  Created by Radzivon Bartoshyk on 23/10/2022.
//

import Foundation
import snappyc

public struct snappy {

    public static func compress(_ data: Data) throws -> Data {
        let maxDstLength = snappy_max_compressed_length(data.count)
        guard maxDstLength > 0, let dstBuffer = malloc(maxDstLength) else {
            throw SnappyInvalidMemorySizeError(size: maxDstLength)
        }
        let compressedSize = UnsafeMutablePointer<Int>.allocate(capacity: MemoryLayout<Int>.size)
        compressedSize.initialize(to: maxDstLength)
        defer { compressedSize.deallocate() }
        let status = data.withUnsafeBytes { rawPointer in
            snappy_compress(rawPointer.bindMemory(to: CChar.self).baseAddress!, data.count, dstBuffer.assumingMemoryBound(to: CChar.self), compressedSize)
        }
        if status != SNAPPY_OK {
            free(dstBuffer)
            throw SnappyCompressionFailureError()
        }
        let compressedData = Data(bytes: dstBuffer, count: compressedSize.pointee)
        free(dstBuffer)
        return compressedData
    }

    public static func decompress(_ data: Data) throws -> Data {
        guard isSnappy(data) else {
            throw SnappyBufferRecognitionError()
        }
        let uncompressedSize = UnsafeMutablePointer<Int>.allocate(capacity: MemoryLayout<Int>.size)
        defer { uncompressedSize.deallocate() }
        var status = data.withUnsafeBytes { rawPointer in
            snappy_uncompressed_length(rawPointer.bindMemory(to: CChar.self).baseAddress!, data.count, uncompressedSize)
        }
        guard status == SNAPPY_OK else {
            throw SnappyBufferRecognitionError()
        }
        guard let dstBuffer = malloc(uncompressedSize.pointee) else {
            throw SnappyInvalidMemorySizeError(size: uncompressedSize.pointee)
        }
        status = data.withUnsafeBytes({ rawPointer in
            snappy_uncompress(rawPointer.bindMemory(to: CChar.self).baseAddress!,
                              data.count,
                              dstBuffer.assumingMemoryBound(to: CChar.self),
                              uncompressedSize)
        })
        guard status == SNAPPY_OK else {
            free(dstBuffer)
            throw SnappyDecompressionFailureError()
        }
        let data = Data(bytes: dstBuffer, count: uncompressedSize.pointee)
        free(dstBuffer)
        return data
    }

    public static func isSnappy(_ data: Data) -> Bool {
        let status = data.withUnsafeBytes { rawPointer in
            snappy_validate_compressed_buffer(rawPointer.bindMemory(to: CChar.self).baseAddress!, data.count)
        }
        return status == SNAPPY_OK
    }

}
