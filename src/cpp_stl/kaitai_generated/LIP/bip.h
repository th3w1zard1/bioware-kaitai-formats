#ifndef BIP_H_
#define BIP_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

class bip_t;

#include "kaitai/kaitaistruct.h"
#include <stdint.h>

#if KAITAI_STRUCT_VERSION < 11000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.11 or later is required"
#endif

/**
 * **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
 * framed wire lives in `LIP.ksy`.
 * 
 * **TODO: VERIFY** full BIP layout against Odyssey Ghidra (`user-agdec-http`) and PyKotor; until then this spec
 * exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.
 * \sa https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198 xoreos — `kFileTypeBIP`
 * \sa https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP family
 * \sa https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; placeholder wire — verify in Ghidra)
 */

class bip_t : public kaitai::kstruct {

public:

    bip_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, bip_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~bip_t();

private:
    std::string m_payload;
    bip_t* m__root;
    kaitai::kstruct* m__parent;

public:

    /**
     * Opaque binary LIP payload — replace with structured fields after verification.
     */
    std::string payload() const { return m_payload; }
    bip_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // BIP_H_
