from construct import *
from construct.lib import *

wav__chunk = Struct(
	'id' / FixedSized(4, GreedyString(encoding='ASCII')),
	'size' / Int32ul,
	'body' / Switch(this.id, {u"data": LazyBound(lambda: wav__data_chunk_body), u"fact": LazyBound(lambda: wav__fact_chunk_body), u"fmt ": LazyBound(lambda: wav__format_chunk_body), }, default=LazyBound(lambda: wav__unknown_chunk_body)),
)

wav__data_chunk_body = Struct(
	'data' / FixedSized(this._.size, GreedyBytes),
)

wav__fact_chunk_body = Struct(
	'sample_count' / Int32ul,
)

wav__format_chunk_body = Struct(
	'audio_format' / Enum(Int16ul, bioware_common__riff_wave_format_tag),
	'channels' / Int16ul,
	'sample_rate' / Int32ul,
	'bytes_per_sec' / Int32ul,
	'block_align' / Int16ul,
	'bits_per_sample' / Int16ul,
	'extra_format_bytes' / If(this._.size > 16, FixedSized(this._.size - 16, GreedyBytes)),
	'is_ima_adpcm' / Computed(lambda this: this.audio_format == 'dvi_ima_adpcm'),
	'is_mp3' / Computed(lambda this: this.audio_format == 'mpeg_layer3'),
	'is_pcm' / Computed(lambda this: this.audio_format == 'pcm'),
)

wav__riff_header = Struct(
	'riff_id' / FixedSized(4, GreedyString(encoding='ASCII')),
	'riff_size' / Int32ul,
	'wave_id' / FixedSized(4, GreedyString(encoding='ASCII')),
	'is_mp3_in_wav' / Computed(lambda this: this.riff_size == 50),
)

wav__unknown_chunk_body = Struct(
	'data' / FixedSized(this._.size, GreedyBytes),
	'padding' / If(this._.size % 2 == 1, Int8ub),
)

wav = Struct(
	'riff_header' / LazyBound(lambda: wav__riff_header),
	'chunks' / RepeatUntil(lambda obj_, list_, this: stream_iseof(_io), LazyBound(lambda: wav__chunk)),
)

_schema = wav
