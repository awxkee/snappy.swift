# snappy in `swift`

## Simple interface to use Google `snappy` compression in `swift`

### Built from google [snappy](https://github.com/google/snappy) repository 

The snappy compression library for iOS and macOS which provides simple and convinient interface

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
