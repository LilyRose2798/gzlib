# gzlib

[![Package Version](https://img.shields.io/hexpm/v/gzlib)](https://hex.pm/packages/gzlib)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gzlib/)

```sh
gleam add gzlib
```
```gleam
import gzlib

pub fn main() {
  let data = <<1, 2, 3, 4, 5>>
  let compressed_data = gzlib.compress(data)
  let more_compressed_data = gzlib.compress_with_level(data, gzlib.max_compression)
  let crc = gzlib.crc32(data)
}
```

Further documentation can be found at <https://hexdocs.pm/gzlib>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
gleam shell # Run an Erlang shell
```
