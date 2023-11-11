https://www.w3.org/International/questions/qa-byte-order-mark
At the beginning of a page that uses a Unicode character encoding you may find some bytes that represent the Unicode code point U+FEFF BYTE ORDER MARK (abbreviated as BOM).

Before UTF-8 was introduced in early 1993, the expected way for transferring Unicode text was using 16-bit code units using an encoding called UCS-2 which was later extended to UTF-16. 16-bit code units can be expressed as bytes in two ways: the most significant byte first (big-endian) or the least significant byte first (little-endian). To communicate which byte order was in use, U+FEFF (the byte-order mark) was used at the start of the stream as a magic number that is not logically part of the text the stream represents.

In the UTF-8 encoding, the presence of the BOM is not essential because, unlike the UTF-16 encodings, there is no alternative sequence of bytes in a character. However, the BOM may still occur in UTF-8 encoded text, either as a by-product of an encoding conversion or because it was added by an editor to flag the content as UTF-8. In this situation, the BOM is often called a UTF-8 signature.

What do I need to know about the BOM?
Most of the time you will not have to worry about the byte-order mark in UTF-8. You will find that some editors (such as Notepad on Windows) will always add a BOM when you save a file with the UTF-8 encoding, others will offer you a choice.

In HTML5 browsers are required to recognize the UTF-8 BOM and use it to detect the encoding of the page, and recent versions of major browsers handle the BOM as expected when used for UTF-8 encoded pages.

The UTF-8 BOM offers reliable encoding detection, since it is extremely short and stable, works in XML and HTML, and works whether your page is read over the network or not (unlike HTTP declarations). However, bear in mind that it is always a good idea to declare the encoding of your page using the meta element, in addition to the BOM, so that the encoding is apparent to people looking at the source text.

Also there are a number of situations where the BOM, particularly because it is invisible, may cause a problem. See the section below for more information about those
You can try looking for a UTF-8 signature in your content in your editor, but if your editor handles the BOM correctly you probably won't be able to see it. With a binary editor capable of displaying the hexadecimal byte values in the file, the UTF-8 signature displays as EF BB BF.