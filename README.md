# snappy in `swift`

## Simple interface to use Google `snappy` in `swift`

### build from google [snappy](https://github.com/google/snappy) repository 

Some examples

```swift
import snappy

// compression
let compressedData: Data = try snappy.compress("Example string".data(using: .utf8)!)

// check if buffer is snappy compress
assert(snappy.isSnappy(compressedData))

// decompression
let decompressedData: Data = try snappy.decompress(compressedData)

// test that compression and decompression works ok

assert(String(data: decompressedData, using: .utf8)! == "Example string")
```
