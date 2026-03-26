/// Compress (deflate) data with the default compression level
/// of the platform - typically level 6 (out of a maximum of 9)
/// 
/// Returns an error if the data is not byte-aligned.
@external(erlang, "gzlib_ffi", "compress")
@external(javascript, "./gzlib_ffi.mjs", "compress")
pub fn compress(data: BitArray) -> Result(BitArray, Nil)

/// Compress (deflate) data with a custom compression level.
/// 
/// Compression level should be between 0 (no compression) and 9 (maximum compression).
/// 
/// Returns an error if the data is not byte-aligned
/// or the compression level is out of range.
@external(erlang, "gzlib_ffi", "compress")
@external(javascript, "./gzlib_ffi.mjs", "compress")
pub fn compress_custom(
  data: BitArray,
  level level: Int,
) -> Result(BitArray, Nil)

/// Uncompress (inflate) data.
/// 
/// Returns an error if the data does not contain the necessary zlib headers
/// or if the data is not byte-aligned.
@external(erlang, "gzlib_ffi", "uncompress")
@external(javascript, "./gzlib_ffi.mjs", "uncompress")
pub fn uncompress(data: BitArray) -> Result(BitArray, Nil)

/// Calculate the CRC checksum for the given data.
/// 
/// Returns an error if the data is not byte-aligned.
@external(erlang, "gzlib_ffi", "crc32")
@external(javascript, "./gzlib_ffi.mjs", "crc32")
pub fn crc32(data: BitArray) -> Result(Int, Nil)

/// Combine an existing CRC checksum with the checksum of the given data.
/// 
/// Returns an error if the existing CRC is not in the range 0 to 2^32
/// or if the data is not byte-aligned.
@external(erlang, "gzlib_ffi", "crc32")
@external(javascript, "./gzlib_ffi.mjs", "crc32Continue")
pub fn crc32_continue(crc: Int, data: BitArray) -> Result(Int, Nil)
