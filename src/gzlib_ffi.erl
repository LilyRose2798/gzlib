-module(gzlib_ffi).

-export([compress/1, compress/2, uncompress/1, crc32/1, crc32/2]).

compress(Data) ->
  try
    Z = zlib:open(),
    Bs = try
      zlib:deflateInit(Z),
      B = zlib:deflate(Z, Data, finish),
      zlib:deflateEnd(Z),
      B
    after
      zlib:close(Z)
    end,
    {ok, iolist_to_binary(Bs)}
  catch _:_ -> {error, nil} end.

compress(Data, Level) ->
  try
    Z = zlib:open(),
    Bs = try
      zlib:deflateInit(Z, Level),
      B = zlib:deflate(Z, Data, finish),
      zlib:deflateEnd(Z),
      B
    after
      zlib:close(Z)
    end,
    {ok, iolist_to_binary(Bs)}
  catch _:_ -> {error, nil} end.

uncompress(Data) ->
  try
    Z = zlib:open(),
    Bs = try
        zlib:inflateInit(Z),
        B = zlib:inflate(Z, Data),
        zlib:inflateEnd(Z),
        B
    after
        zlib:close(Z)
    end,
    {ok, iolist_to_binary(Bs)}
  catch _:_ -> {error, nil} end.

crc32(Data) ->
  try {ok, erlang:crc32(Data)}
  catch _:_ -> {error, nil} end.

crc32(Crc, Data) ->
  try {ok, erlang:crc32(Crc, Data)}
  catch _:_ -> {error, nil} end.
