bitsof(::Type{UInt8})   =   8
bitsof(::Type{UInt16})  =  16
bitsof(::Type{UInt32})  =  32
bitsof(::Type{UInt64})  =  64
bitsof(::Type{UInt128}) = 128
bitsof(::Type{Int8})    =   8
bitsof(::Type{Int16})   =  16
bitsof(::Type{Int32})   =  32
bitsof(::Type{Int64})   =  64
bitsof(::Type{Int128})  = 128

lsbit(::Type{UInt8})    = 0x01
lsbit(::Type{UInt16})   = 0x0001
lsbit(::Type{UInt32})   = 0x00000001
lsbit(::Type{UInt64})   = 0x0000000000000001
lsbit(::Type{UInt128})  = 0x00000000000000000000000000000001
lsbit(::Type{Int8})     = 0x01%Int8
lsbit(::Type{Int16})    = 0x0001%Int16
lsbit(::Type{Int32})    = 0x00000001%Int32
lsbit(::Type{Int64})    = 0x0000000000000001%Int64
lsbit(::Type{Int128})   = 0x00000000000000000000000000000001%Int128

lsbit(::Type{MUInt8})    = 0x01%MUInt8
lsbit(::Type{MUInt16})   = 0x0001%MUInt16
lsbit(::Type{MUInt32})   = 0x00000001%MUInt32
lsbit(::Type{MUInt64})   = 0x0000000000000001%MUInt64
lsbit(::Type{MUInt128})  = 0x00000000000000000000000000000001%MUInt128
lsbit(::Type{MInt8})     = 0x01%MInt8
lsbit(::Type{MInt16})    = 0x0001%MInt16
lsbit(::Type{MInt32})    = 0x00000001%MInt32
lsbit(::Type{MInt64})    = 0x0000000000000001%MInt64
lsbit(::Type{MInt128})   = 0x00000000000000000000000000000001%MInt128

msbit(::Type{UInt8})    = 0x80
msbit(::Type{UInt16})   = 0x8000
msbit(::Type{UInt32})   = 0x80000000
msbit(::Type{UInt64})   = 0x8000000000000000
msbit(::Type{UInt128})  = 0x80000000000000000000000000000000
msbit(::Type{Int8})     = 0x80%Int8
msbit(::Type{Int16})    = 0x8000%Int16
msbit(::Type{Int32})    = 0x80000000%Int32
msbit(::Type{Int64})    = 0x8000000000000000%Int64
msbit(::Type{Int128})   = 0x80000000000000000000000000000000%Int128

msbit(::Type{MUInt8})    = 0x80%MUInt8
msbit(::Type{MUInt16})   = 0x8000%MUInt16
msbit(::Type{MUInt32})   = 0x80000000%MUInt32
msbit(::Type{MUInt64})   = 0x8000000000000000%MUInt64
msbit(::Type{MUInt128})  = 0x80000000000000000000000000000000%MUInt128
msbit(::Type{MInt8})     = 0x80%MInt8
msbit(::Type{MInt16})    = 0x8000%MInt16
msbit(::Type{MInt32})    = 0x80000000%MInt32
msbit(::Type{MInt64})    = 0x8000000000000000%MInt64
msbit(::Type{MInt128})   = 0x80000000000000000000000000000000%MInt128

msbits(::Type{UInt8})    = 0xfe      # (-one(Int8))%UInt8 << 1
msbits(::Type{UInt16})   = 0xfffe
msbits(::Type{UInt32})   = 0xfffffffe
msbits(::Type{UInt64})   = 0xfffffffffffffffe
msbits(::Type{UInt128})  = 0xfffffffffffffffffffffffffffffffe
msbits(::Type{Int8})     = 0xfe%Int8
msbits(::Type{Int16})    = 0xfffe%Int16
msbits(::Type{Int32})    = 0xfffffffe%Int32
msbits(::Type{Int64})    = 0xfffffffffffffffe%Int64
msbits(::Type{Int128})   = 0xfffffffffffffffffffffffffffffffe%Int128

msbits(::Type{MUInt8})    = 0xfe%MUInt8      # (-one(Int8))%UInt8 << 1
msbits(::Type{MUInt16})   = 0xfffe%MUInt16
msbits(::Type{MUInt32})   = 0xfffffffe%MUInt32
msbits(::Type{MUInt64})   = 0xfffffffffffffffe%MUInt64
msbits(::Type{MUInt128})  = 0xfffffffffffffffffffffffffffffffe%MUInt128
msbits(::Type{MInt8})     = 0xfe%MInt8
msbits(::Type{MInt16})    = 0xfffe%MInt16
msbits(::Type{MInt32})    = 0xfffffffe%MInt32
msbits(::Type{MInt64})    = 0xfffffffffffffffe%MInt64
msbits(::Type{MInt128})   = 0xfffffffffffffffffffffffffffffffe%MInt128

for (M,I) in ((:MUInt128, :UInt128), (:MUInt64, :UInt64),
              (:MUInt32, :UInt32), (:MUInt16, :UInt16),
              (:MUInt8, :UInt8),
              (:MInt128, :Int128), (:MInt64, :Int64),
              (:MInt32, :Int32), (:MInt16, :Int16),
              (:MInt8, :Int8))
  @eval begin
      bitsof(::Type{$M}) = bitsof($I) - 1
      msbit(::Type{$M})  = reinterpret($M, msbit($I))
      lsbit(::Type{$M})  = reinterpret($M, lsbit($I))
  end
end
