from construct import *
from construct.lib import *

itp_xml = Struct(
	'xml_content' / GreedyString(encoding='UTF-8'),
)

_schema = itp_xml
