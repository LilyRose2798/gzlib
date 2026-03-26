import gleeunit
import gzlib

pub fn main() {
  gleeunit.main()
}

pub fn compress_empty_data_test() {
  assert gzlib.compress(<<>>) == Ok(<<120, 156, 3, 0, 0, 0, 0, 1>>)
}

pub fn compress_valid_data_test() {
  assert gzlib.compress(<<1, 2, 3, 4, 5, 6, 7, 8>>)
    == Ok(<<120, 156, 99, 100, 98, 102, 97, 101, 99, 231, 0, 0, 0, 128, 0, 37>>)
}

pub fn compress_unaligned_data_test() {
  assert gzlib.compress(<<1:1>>) == Error(Nil)
}

pub fn compress_custom_empty_data_test() {
  assert gzlib.compress_custom(<<>>, 0)
    == Ok(<<120, 1, 1, 0, 0, 255, 255, 0, 0, 0, 1>>)
}

pub fn compress_custom_valid_data_test() {
  assert gzlib.compress_custom(<<1, 2, 3, 4, 5, 6, 7, 8>>, 0)
    == Ok(<<120, 1, 1, 8, 0, 247, 255, 1, 2, 3, 4, 5, 6, 7, 8, 0, 128, 0, 37>>)
}

pub fn compress_custom_unaligned_data_test() {
  assert gzlib.compress_custom(<<1:1>>, 0) == Error(Nil)
}

pub fn compress_custom_invalid_level_test() {
  assert gzlib.compress_custom(<<1, 2, 3, 4, 5, 6, 7, 8>>, -1) == Error(Nil)
  assert gzlib.compress_custom(<<1, 2, 3, 4, 5, 6, 7, 8>>, -100) == Error(Nil)
  assert gzlib.compress_custom(<<1, 2, 3, 4, 5, 6, 7, 8>>, 10) == Error(Nil)
  assert gzlib.compress_custom(<<1, 2, 3, 4, 5, 6, 7, 8>>, 100) == Error(Nil)
}

pub fn uncompress_empty_data_test() {
  assert gzlib.uncompress(<<>>) == Error(Nil)
}

pub fn uncompress_valid_data_test() {
  assert gzlib.uncompress(<<
      120,
      156,
      99,
      100,
      98,
      102,
      97,
      101,
      99,
      231,
      0,
      0,
      0,
      128,
      0,
      37,
    >>)
    == Ok(<<1, 2, 3, 4, 5, 6, 7, 8>>)
}

pub fn uncompress_unaligned_data_test() {
  assert gzlib.uncompress(<<1:1>>) == Error(Nil)
}

pub fn compress_decompress_round_trip_test() {
  let original = <<1, 2, 3, 4, 5, 6, 7, 8>>
  let assert Ok(compressed) = gzlib.compress(original)
  let assert Ok(uncompressed) = gzlib.uncompress(compressed)
  assert original == uncompressed
}

pub fn crc32_empty_data_test() {
  assert gzlib.crc32(<<>>) == Ok(0)
}

pub fn crc32_valid_data_test() {
  assert gzlib.crc32(<<1, 2, 3, 4, 5, 6, 7, 8>>) == Ok(1_070_237_893)
}

pub fn crc32_unaligned_data_test() {
  assert gzlib.crc32(<<1:1>>) == Error(Nil)
}

pub fn crc32_continue_empty_data_test() {
  assert gzlib.crc32_continue(0, <<>>) == Ok(0)
  assert gzlib.crc32_continue(12_345_678, <<>>) == Ok(12_345_678)
}

pub fn crc32_continue_valid_data_test() {
  assert gzlib.crc32_continue(0, <<1, 2, 3, 4, 5, 6, 7, 8>>)
    == Ok(1_070_237_893)
  assert gzlib.crc32_continue(12_345_678, <<1, 2, 3, 4, 5, 6, 7, 8>>)
    == Ok(1_125_436_485)
  assert gzlib.crc32_continue(4_294_967_295, <<1, 2, 3, 4, 5, 6, 7, 8>>)
    == Ok(2_769_791_059)
}

pub fn crc32_continue_unaligned_data_test() {
  assert gzlib.crc32_continue(0, <<1:1>>) == Error(Nil)
  assert gzlib.crc32_continue(12_345_678, <<1:1>>) == Error(Nil)
}

pub fn crc32_continue_invalid_crc_test() {
  assert gzlib.crc32_continue(-1, <<>>) == Error(Nil)
  assert gzlib.crc32_continue(4_294_967_296, <<1, 2, 3, 4, 5, 6, 7, 8>>)
    == Error(Nil)
}
