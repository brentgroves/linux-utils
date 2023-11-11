https://github.com/lapo-luchini/asn1js
# ASN.1 JavaScript decoder
https://lapo.it/asn1js/

pushd ~/src/linux-utils/crypto/book/certificates
https://en.wikipedia.org/wiki/ASN.1
ASN.1 is closely associated with a set of encoding rules that specify how to represent a data structure as a series of bytes. The standard ASN.1 encoding rules include:

Abstract Syntax Notation One (ASN.1) is a standard interface description language for defining data structures that can be serialized and deserialized in a cross-platform way. It is broadly used in telecommunications and computer networking, and especially in cryptography.[1]

Protocol developers define data structures in ASN.1 modules, which are generally a section of a broader standards document written in the ASN.1 language. The advantage is that the ASN.1 description of the data encoding is independent of a particular computer or programming language. Because ASN.1 is both human-readable and machine-readable, an ASN.1 compiler can compile modules into libraries of code, codecs, that decode or encode the data structures. Some ASN.1 compilers can produce code to encode or decode several encodings, e.g. packed, BER or XML.

Language support
ASN.1 is a data type declaration notation. It does not define how to manipulate a variable of such a type. Manipulation of variables is defined in other languages such as SDL (Specification and Description Language) for executable modeling or TTCN-3 (Testing and Test Control Notation) for conformance testing. Both these languages natively support ASN.1 declarations. It is possible to import an ASN.1 module and declare a variable of any of the ASN.1 types declared in the module.

Basic Encoding Rules
The first specified encoding rules. Encodes elements as tag-length-value (TLV) sequences. Typically provides several options as to how data values are to be encoded. This is one of the more flexible encoding rules.

Distinguished Encoding Rules
A restricted subset of the Basic Encoding Rules (BER). Typically used for things that are digitally-signed because, since the DER allow for fewer options for encoding, and because DER-encoded values are more likely to be re-encoded on the exact same bytes, digital signatures produced by a given abstract value will be the same across implementations and digital signatures produced over DER-encoded data will be less susceptible to collision-based attacks.
Canonical Encoding Rules
A restricted subset of the Basic Encoding Rules (BER). Employs almost all of the same restrictions as the Distinguished Encoding Rules (DER), but the noteworthy difference is that the CER specify that many large values (especially strings) are to be "chopped up" into individual substring elements at the 1000-byte or 1000-character mark (depending on the data type).

Example
This is an example ASN.1 module defining the messages (data structures) of a fictitious Foo Protocol:

FooProtocol DEFINITIONS ::= BEGIN

    FooQuestion ::= SEQUENCE {
        trackingNumber INTEGER,
        question       IA5String
    }

    FooAnswer ::= SEQUENCE {
        questionNumber INTEGER,
        answer         BOOLEAN
    }

END

This could be a specification published by creators of Foo Protocol. Conversation flows, transaction interchanges, and states are not defined in ASN.1, but are left to other notations and textual description of the protocol.

Assuming a message that complies with the Foo Protocol and that will be sent to the receiving party, this particular message (protocol data unit (PDU)) is:

myQuestion FooQuestion ::= {
    trackingNumber     5,
    question           "Anybody there?"
}
ASN.1 supports constraints on values and sizes, and extensibility. The above specification can be changed to

FooProtocol DEFINITIONS ::= BEGIN

    FooQuestion ::= SEQUENCE {
        trackingNumber INTEGER(0..199),
        question       IA5String
    }

    FooAnswer ::= SEQUENCE {
        questionNumber INTEGER(10..20),
        answer         BOOLEAN
    }

    FooHistory ::= SEQUENCE {
        questions SEQUENCE(SIZE(0..10)) OF FooQuestion,
        answers   SEQUENCE(SIZE(1..10)) OF FooAnswer,
        anArray   SEQUENCE(SIZE(100))  OF INTEGER(0..1000),
        ...
    }

END

This change constrains trackingNumbers to have a value between 0 and 199 inclusive, and questionNumbers to have a value between 10 and 20 inclusive. The size of the questions array can be between 0 and 10 elements, with the answers array between 1 and 10 elements. The anArray field is a fixed length 100 element array of integers that must be in the range 0 to 1000. The '...' extensibility marker means that the FooHistory message specification may have additional fields in future versions of the specification; systems compliant with one version should be able to receive and transmit transactions from a later version, though able to process only the fields specified in the earlier version. Good ASN.1 compilers will generate (in C, C++, Java, etc.) source code that will automatically check that transactions fall within these constraints. Transactions that violate the constraints should not be accepted from, or presented to, the application. Constraint management in this layer significantly simplifies protocol specification because the applications will be protected from constraint violations, reducing risk and cost.

To send the myQuestion message through the network, the message is serialized (encoded) as a series of bytes using one of the encoding rules. The Foo protocol specification should explicitly name one set of encoding rules to use, so that users of the Foo protocol know which one they should use and expect.

Example encoded in DER
Below is the data structure shown above as myQuestion encoded in DER format (all numbers are in hexadecimal):

myQuestion FooQuestion ::= {
    trackingNumber     5,
    question           "Anybody there?"
}
30 13 02 01 05 16 0e 41 6e 79 62 6f 64 79 20 74 68 65 72 65 3f
DER is a type–length–value encoding, so the sequence above can be interpreted, with reference to the standard SEQUENCE, INTEGER, and IA5String types, as follows:

30 — type tag indicating SEQUENCE
13 — length in octets of value that follows
  02 — type tag indicating INTEGER
  01 — length in octets of value that follows
    05 — value (5)
  16 — type tag indicating IA5String 
     (IA5 means the full 7-bit ISO 646 set, including variants, 
      but is generally US-ASCII)
  0e — length in octets of value that follows
    41 6e 79 62 6f 64 79 20 74 68 65 72 65 3f — value ("Anybody there?")
