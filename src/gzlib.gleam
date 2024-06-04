pub opaque type CompressionLevel {
  CompressionLevel(level: Int)
}

pub const no_compression = CompressionLevel(0)

pub const min_compression = CompressionLevel(1)

pub const max_compression = CompressionLevel(9)

pub const default_compression = CompressionLevel(6)

pub fn compression_level(level: Int) -> Result(CompressionLevel, Nil) {
  case level >= 0 && level <= 9 {
    True -> Ok(CompressionLevel(level))
    False -> Error(Nil)
  }
}

@external(erlang, "zlib", "compress")
@external(javascript, "./gzlib_js.mjs", "compress")
pub fn compress(data: BitArray) -> BitArray

@external(erlang, "gzlib_erl", "compress")
@external(javascript, "./gzlib_js.mjs", "compress")
fn do_compress_with_level(data: BitArray, level: Int) -> BitArray

pub fn compress_with_level(data: BitArray, level: CompressionLevel) -> BitArray {
  do_compress_with_level(data, level.level)
}

@external(erlang, "zlib", "uncompress")
@external(javascript, "./gzlib_js.mjs", "uncompress")
pub fn uncompress(data: BitArray) -> BitArray

@external(erlang, "erlang", "crc32")
@external(javascript, "./gzlib_js.mjs", "crc32")
pub fn crc32(data: BitArray) -> Int

@external(erlang, "erlang", "crc32")
@external(javascript, "./gzlib_js.mjs", "continueCrc32")
pub fn continue_crc32(init: Int, data: BitArray) -> Int
