/**
 * Trims the leading and trailing spaces from the specified
 * text string.
 * @param	text - the string text
 * @return	the trimmed text
 */
function trimSpace(text) {
	var iStartIndex = 0;
	var iEndIndex = text.length;

	for (var i = 0; i < text.length; ) {
		if (text.charAt(i) == " ") {
			iStartIndex = ++i;
		} else {
			break;
		}
	}
	if (iStartIndex < iEndIndex) {
		for (var i = text.length; i >= 0; ) {
			if (text.charAt(--i) == " ") {
				iEndIndex = i;
			} else {
				break;
			}
		}
	}
//alert(iStartIndex + ", " + iEndIndex);
	return text.substring(iStartIndex, iEndIndex);
}