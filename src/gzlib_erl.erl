-module(gzlib_erl).

-export([compress/2]).

compress(Data, Level) ->
    Z = zlib:open(),
    ok = zlib:deflateInit(Z, Level),
    Compressed = zlib:deflate(Z, Data),
    Last = zlib:deflate(Z, [], finish),
    ok = zlib:deflateEnd(Z),
    zlib:close(Z),
    list_to_binary([Compressed|Last]).
