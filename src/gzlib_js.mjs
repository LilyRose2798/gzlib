import { deflateSync, inflateSync } from "node:zlib"
import { BitArray } from "./gleam.mjs"

export const compress = (data, level = undefined) => new BitArray(new Uint8Array(deflateSync(data.buffer, { level })))

export const uncompress = data => new BitArray(new Uint8Array(inflateSync(data.buffer)))

const crcTable = [...Array(256)].map((_, i) => [...Array(8)].reduce(c => ((c & 1) ? (0xEDB88320 ^ (c >>> 1)) : (c >>> 1)), i))

export const crc32 = (data, init = 0) => (data.buffer.reduce((crc, x) => (crc >>> 8) ^ crcTable[(crc ^ x) & 0xFF], init ^ (-1)) ^ (-1)) >>> 0

export const continueCrc32 = (init, str) => crc32(str, init)
