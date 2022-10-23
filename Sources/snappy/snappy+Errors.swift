//
//  snappy+Errors.swift.swift
//  
//
//  Created by Radzivon Bartoshyk on 23/10/2022.
//

import Foundation

public struct SnappyInvalidMemorySizeError: LocalizedError {
    let size: Int
    public var errorDescription: String? {
        "Invalid memory size was requested: \(size)"
    }
}

public struct SnappyCompressionFailureError: LocalizedError {
    public var errorDescription: String? {
        "Snappy faild to compress the buffer"
    }
}

public struct SnappyDecompressionFailureError: LocalizedError {
    public var errorDescription: String? {
        "Snappy faild to decompress the buffer"
    }
}


public struct SnappyBufferRecognitionError: LocalizedError {
    public var errorDescription: String? {
        "Buffer doesn't seems to be 'snappy' compressed"
    }
}
