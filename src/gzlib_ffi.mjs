import { deflateSync, inflateSync, crc32 as nodeCrc32 } from "node:zlib"
import { BitArray$BitArray, BitArray$BitArray$data, Result$Ok, Result$Error } from "./gleam.mjs"

export function compress(data, level = undefined) {
  try {
    if (level !== undefined && level < 0)
      return Result$Error(undefined)
    const buffer = deflateSync(BitArray$BitArray$data(data), { level })
    return Result$Ok(BitArray$BitArray(new Uint8Array(buffer.buffer, buffer.byteOffset, buffer.byteLength)))
  } catch (_) {
    return Result$Error(undefined)
  }
}

export function uncompress(data) {
  try {
    const buffer = inflateSync(BitArray$BitArray$data(data))
    return Result$Ok(BitArray$BitArray(new Uint8Array(buffer.buffer, buffer.byteOffset, buffer.byteLength)))
  } catch (_) {
    return Result$Error(undefined)
  }
}

export function crc32(data) {
  return crc32Continue(0, data)
} 

export function crc32Continue(crc, data) {
  try {
    if (crc < 0 || crc > 4294967295)
      return Result$Error(undefined)
    if (data.bitSize === 0)
      return Result$Ok(crc)
    return Result$Ok(nodeCrc32(BitArray$BitArray$data(data), crc))
  } catch (_) {
    return Result$Error(undefined)
  }
}
