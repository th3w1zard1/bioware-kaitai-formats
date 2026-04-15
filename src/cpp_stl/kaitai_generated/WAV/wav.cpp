// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "wav.h"
#include "kaitai/exceptions.h"

wav_t::wav_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, wav_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root ? p__root : this;
    m_riff_header = 0;
    m_chunks = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void wav_t::_read() {
    m_riff_header = new riff_header_t(m__io, this, m__root);
    m_chunks = new std::vector<chunk_t*>();
    {
        int i = 0;
        chunk_t* _;
        do {
            _ = new chunk_t(m__io, this, m__root);
            m_chunks->push_back(_);
            i++;
        } while (!(_io()->is_eof()));
    }
}

wav_t::~wav_t() {
    _clean_up();
}

void wav_t::_clean_up() {
    if (m_riff_header) {
        delete m_riff_header; m_riff_header = 0;
    }
    if (m_chunks) {
        for (std::vector<chunk_t*>::iterator it = m_chunks->begin(); it != m_chunks->end(); ++it) {
            delete *it;
        }
        delete m_chunks; m_chunks = 0;
    }
}

wav_t::chunk_t::chunk_t(kaitai::kstream* p__io, wav_t* p__parent, wav_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void wav_t::chunk_t::_read() {
    m_id = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    m_size = m__io->read_u4le();
    {
        std::string on = id();
        if (on == std::string("data")) {
            m_body = new data_chunk_body_t(m__io, this, m__root);
        }
        else if (on == std::string("fact")) {
            m_body = new fact_chunk_body_t(m__io, this, m__root);
        }
        else if (on == std::string("fmt ")) {
            m_body = new format_chunk_body_t(m__io, this, m__root);
        }
        else {
            m_body = new unknown_chunk_body_t(m__io, this, m__root);
        }
    }
}

wav_t::chunk_t::~chunk_t() {
    _clean_up();
}

void wav_t::chunk_t::_clean_up() {
    if (m_body) {
        delete m_body; m_body = 0;
    }
}

wav_t::data_chunk_body_t::data_chunk_body_t(kaitai::kstream* p__io, wav_t::chunk_t* p__parent, wav_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void wav_t::data_chunk_body_t::_read() {
    m_data = m__io->read_bytes(_parent()->size());
}

wav_t::data_chunk_body_t::~data_chunk_body_t() {
    _clean_up();
}

void wav_t::data_chunk_body_t::_clean_up() {
}

wav_t::fact_chunk_body_t::fact_chunk_body_t(kaitai::kstream* p__io, wav_t::chunk_t* p__parent, wav_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void wav_t::fact_chunk_body_t::_read() {
    m_sample_count = m__io->read_u4le();
}

wav_t::fact_chunk_body_t::~fact_chunk_body_t() {
    _clean_up();
}

void wav_t::fact_chunk_body_t::_clean_up() {
}

wav_t::format_chunk_body_t::format_chunk_body_t(kaitai::kstream* p__io, wav_t::chunk_t* p__parent, wav_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_is_ima_adpcm = false;
    f_is_mp3 = false;
    f_is_pcm = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void wav_t::format_chunk_body_t::_read() {
    m_audio_format = static_cast<bioware_common_t::riff_wave_format_tag_t>(m__io->read_u2le());
    m_channels = m__io->read_u2le();
    m_sample_rate = m__io->read_u4le();
    m_bytes_per_sec = m__io->read_u4le();
    m_block_align = m__io->read_u2le();
    m_bits_per_sample = m__io->read_u2le();
    n_extra_format_bytes = true;
    if (_parent()->size() > 16) {
        n_extra_format_bytes = false;
        m_extra_format_bytes = m__io->read_bytes(_parent()->size() - 16);
    }
}

wav_t::format_chunk_body_t::~format_chunk_body_t() {
    _clean_up();
}

void wav_t::format_chunk_body_t::_clean_up() {
    if (!n_extra_format_bytes) {
    }
}

bool wav_t::format_chunk_body_t::is_ima_adpcm() {
    if (f_is_ima_adpcm)
        return m_is_ima_adpcm;
    f_is_ima_adpcm = true;
    m_is_ima_adpcm = audio_format() == bioware_common_t::RIFF_WAVE_FORMAT_TAG_DVI_IMA_ADPCM;
    return m_is_ima_adpcm;
}

bool wav_t::format_chunk_body_t::is_mp3() {
    if (f_is_mp3)
        return m_is_mp3;
    f_is_mp3 = true;
    m_is_mp3 = audio_format() == bioware_common_t::RIFF_WAVE_FORMAT_TAG_MPEG_LAYER3;
    return m_is_mp3;
}

bool wav_t::format_chunk_body_t::is_pcm() {
    if (f_is_pcm)
        return m_is_pcm;
    f_is_pcm = true;
    m_is_pcm = audio_format() == bioware_common_t::RIFF_WAVE_FORMAT_TAG_PCM;
    return m_is_pcm;
}

wav_t::riff_header_t::riff_header_t(kaitai::kstream* p__io, wav_t* p__parent, wav_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_is_mp3_in_wav = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void wav_t::riff_header_t::_read() {
    m_riff_id = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_riff_id == std::string("RIFF"))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("RIFF"), m_riff_id, m__io, std::string("/types/riff_header/seq/0"));
    }
    m_riff_size = m__io->read_u4le();
    m_wave_id = kaitai::kstream::bytes_to_str(m__io->read_bytes(4), "ASCII");
    if (!(m_wave_id == std::string("WAVE"))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("WAVE"), m_wave_id, m__io, std::string("/types/riff_header/seq/2"));
    }
}

wav_t::riff_header_t::~riff_header_t() {
    _clean_up();
}

void wav_t::riff_header_t::_clean_up() {
}

bool wav_t::riff_header_t::is_mp3_in_wav() {
    if (f_is_mp3_in_wav)
        return m_is_mp3_in_wav;
    f_is_mp3_in_wav = true;
    m_is_mp3_in_wav = riff_size() == 50;
    return m_is_mp3_in_wav;
}

wav_t::unknown_chunk_body_t::unknown_chunk_body_t(kaitai::kstream* p__io, wav_t::chunk_t* p__parent, wav_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void wav_t::unknown_chunk_body_t::_read() {
    m_data = m__io->read_bytes(_parent()->size());
    n_padding = true;
    if (kaitai::kstream::mod(_parent()->size(), 2) == 1) {
        n_padding = false;
        m_padding = m__io->read_u1();
    }
}

wav_t::unknown_chunk_body_t::~unknown_chunk_body_t() {
    _clean_up();
}

void wav_t::unknown_chunk_body_t::_clean_up() {
    if (!n_padding) {
    }
}
