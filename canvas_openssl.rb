#!/usr/bin/ruby -w
# capistrano_openssl.rb
# Author: Andy Bettisworth
# Description: Canvas openssl package

## Q: create ssl server
## Q: create signing certificate
## LINK https://www.openssl.org/docs/HOWTO/certificates.txt

## CREATE private key [1024-bit, 2048-bit, or 4096-bit encryption]
# openssl genrsa 2048 > ec2-wurde-private-key.pem
## CREATE user signing certificate
# openssl req -new -x509 -nodes -sha1 -days 365 -key ec2-wurde-private-key.pem -outform PEM > ec2-wurde-cert.pem

############
### HELP ###
## openssl:Error: '-h' is an invalid command.

## Standard commands
# asn1parse         ca                ciphers           cms
# crl               crl2pkcs7         dgst              dh
# dhparam           dsa               dsaparam          ec
# ecparam           enc               engine            errstr
# gendh             gendsa            genpkey           genrsa
# nseq              ocsp              passwd            pkcs12
# pkcs7             pkcs8             pkey              pkeyparam
# pkeyutl           prime             rand              req
# rsa               rsautl            s_client          s_server
# s_time            sess_id           smime             speed
# spkac             srp               ts                verify
# version           x509

## Message Digest commands (see the `dgst' command for more details)
# md4               md5               rmd160            sha
# sha1

## Cipher commands (see the `enc' command for more details)
# aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb
# aes-256-cbc       aes-256-ecb       base64            bf
# bf-cbc            bf-cfb            bf-ecb            bf-ofb
# camellia-128-cbc  camellia-128-ecb  camellia-192-cbc  camellia-192-ecb
# camellia-256-cbc  camellia-256-ecb  cast              cast-cbc
# cast5-cbc         cast5-cfb         cast5-ecb         cast5-ofb
# des               des-cbc           des-cfb           des-ecb
# des-ede           des-ede-cbc       des-ede-cfb       des-ede-ofb
# des-ede3          des-ede3-cbc      des-ede3-cfb      des-ede3-ofb
# des-ofb           des3              desx              rc2
# rc2-40-cbc        rc2-64-cbc        rc2-cbc           rc2-cfb
# rc2-ecb           rc2-ofb           rc4               rc4-40
# seed              seed-cbc          seed-cfb          seed-ecb
# seed-ofb          zlib
### HELP ###
############

###############
### MANPAGE ###
# OPENSSL(1SSL)

# NAME openssl - OpenSSL command line tool

# SYNOPSIS
#   openssl command [ command_opts ] [ command_args ]

#   openssl [ list-standard-commands | list-message-digest-commands | list-cipher-commands |
#               list-cipher-algorithms | list-message-digest-algorithms |
#               list-public-key-algorithms]

#   openssl no-XXX [ arbitrary options ]

# DESCRIPTION
#  OpenSSL is a cryptography toolkit implementing the Secure Sockets Layer (SSL v2/v3) and Transport Layer Security (TLS v1) network protocols and related cryptography standards required by them.

#  The openssl program is a command line tool for using the various cryptography functions of OpenSSL's crypto library from the shell.  It can be used for

#   o  Creation and management of private keys, public keys and parameters
#   o  Public key cryptographic operations
#   o  Creation of X.509 certificates, CSRs and CRLs
#   o  Calculation of Message Digests
#   o  Encryption and Decryption with Ciphers
#   o  SSL/TLS Client and Server Tests
#   o  Handling of S/MIME signed or encrypted mail
#   o  Time Stamp requests, generation and verification

# COMMAND SUMMARY
#    The openssl program provides a rich variety of commands (command in the SYNOPSIS above), each of which often has a wealth of options and arguments (command_opts and command_args in the SYNOPSIS).

#    The pseudo-commands list-standard-commands, list-message-digest-commands, and list-cipher-commands output a list (one entry per line) of the names of all standard commands, message digest commands, or
#    cipher commands, respectively, that are available in the present openssl utility.

#    The pseudo-commands list-cipher-algorithms and list-message-digest-algorithms list all cipher and message digest names, one entry per line. Aliases are listed as:

#     from => to

#    The pseudo-command list-public-key-algorithms lists all supported public key algorithms.

#    The pseudo-command no-XXX tests whether a command of the specified name is available.  If no command named XXX exists, it returns 0 (success) and prints no-XXX; otherwise it returns 1 and prints XXX.
#    In both cases, the output goes to stdout and nothing is printed to stderr.  Additional command line arguments are always ignored.  Since for each cipher there is a command of the same name, this
#    provides an easy way for shell scripts to test for the availability of ciphers in the openssl program.  (no-XXX is not able to detect pseudo-commands such as quit, list-...-commands, or no-XXX
#    itself.)

# STANDARD COMMANDS
#    asn1parse Parse an ASN.1 sequence.

#    ca        Certificate Authority (CA) Management.

#    ciphers   Cipher Suite Description Determination.

#    cms       CMS (Cryptographic Message Syntax) utility

#    crl       Certificate Revocation List (CRL) Management.

#    crl2pkcs7 CRL to PKCS#7 Conversion.

#    dgst      Message Digest Calculation.

#    dh        Diffie-Hellman Parameter Management.  Obsoleted by dhparam.

#    dhparam   Generation and Management of Diffie-Hellman Parameters. Superseded by genpkey and pkeyparam

#    dsa       DSA Data Management.

#    dsaparam  DSA Parameter Generation and Management. Superseded by genpkey and pkeyparam

#    ec        EC (Elliptic curve) key processing

#    ecparam   EC parameter manipulation and generation

#    enc       Encoding with Ciphers.

#    engine    Engine (loadble module) information and manipulation.

#    errstr    Error Number to Error String Conversion.

#    gendh     Generation of Diffie-Hellman Parameters.  Obsoleted by dhparam.

#    gendsa    Generation of DSA Private Key from Parameters. Superseded by genpkey and pkey

#    genpkey   Generation of Private Key or Parameters.

#    genrsa    Generation of RSA Private Key. Superceded by genpkey.

#    nseq      Create or examine a netscape certificate sequence

#    ocsp      Online Certificate Status Protocol utility.

#    passwd    Generation of hashed passwords.

#    pkcs12    PKCS#12 Data Management.

#    pkcs7     PKCS#7 Data Management.

#    pkey      Public and private key management.

#    pkeyparam Public key algorithm parameter management.

#    pkeyutl   Public key algorithm cryptographic operation utility.

#    rand      Generate pseudo-random bytes.

#    req       PKCS#10 X.509 Certificate Signing Request (CSR) Management.

#    rsa       RSA key management.

#    rsautl    RSA utility for signing, verification, encryption, and decryption. Superseded by  pkeyutl

#    s_client  This implements a generic SSL/TLS client which can establish a transparent connection to a remote server speaking SSL/TLS. It's intended for testing purposes only and provides only
#              rudimentary interface functionality but internally uses mostly all functionality of the OpenSSL ssl library.

#    s_server  This implements a generic SSL/TLS server which accepts connections from remote clients speaking SSL/TLS. It's intended for testing purposes only and provides only rudimentary interface
#              functionality but internally uses mostly all functionality of the OpenSSL ssl library.  It provides both an own command line oriented protocol for testing SSL functions and a simple HTTP
#              response facility to emulate an SSL/TLS-aware webserver.

#    s_time    SSL Connection Timer.

#    sess_id   SSL Session Data Management.

#    smime     S/MIME mail processing.

#    speed     Algorithm Speed Measurement.

#    spkac     SPKAC printing and generating utility

#    ts        Time Stamping Authority tool (client/server)

#    verify    X.509 Certificate Verification.

#    version   OpenSSL Version Information.

#    x509      X.509 Certificate Data Management.

# MESSAGE DIGEST COMMANDS
#    md2       MD2 Digest

#    md5       MD5 Digest

#    mdc2      MDC2 Digest

#    rmd160    RMD-160 Digest

#    sha       SHA Digest

#    sha1      SHA-1 Digest

#    sha224    SHA-224 Digest

#    sha256    SHA-256 Digest

#    sha384    SHA-384 Digest

#    sha512    SHA-512 Digest

# ENCODING AND CIPHER COMMANDS
#    base64    Base64 Encoding

#    bf bf-cbc bf-cfb bf-ecb bf-ofb
#              Blowfish Cipher

#    cast cast-cbc
#              CAST Cipher

#    cast5-cbc cast5-cfb cast5-ecb cast5-ofb
#              CAST5 Cipher

#    des des-cbc des-cfb des-ecb des-ede des-ede-cbc des-ede-cfb des-ede-ofb des-ofb
#              DES Cipher

#    des3 desx des-ede3 des-ede3-cbc des-ede3-cfb des-ede3-ofb
#              Triple-DES Cipher

#    idea idea-cbc idea-cfb idea-ecb idea-ofb
#              IDEA Cipher

#    rc2 rc2-cbc rc2-cfb rc2-ecb rc2-ofb
#              RC2 Cipher

#    rc4       RC4 Cipher

#    rc5 rc5-cbc rc5-cfb rc5-ecb rc5-ofb
#              RC5 Cipher

# PASS PHRASE ARGUMENTS
#    Several commands accept password arguments, typically using -passin and -passout for input and output passwords respectively. These allow the password to be obtained from a variety of sources. Both of
#    these options take a single argument whose format is described below. If no password argument is given and a password is required then the user is prompted to enter one: this will typically be read
#    from the current terminal with echoing turned off.

#    pass:password
#              the actual password is password. Since the password is visible to utilities (like 'ps' under Unix) this form should only be used where security is not important.

#    env:var   obtain the password from the environment variable var. Since the environment of other processes is visible on certain platforms (e.g. ps under certain Unix OSes) this option should be used
#              with caution.

#    file:pathname
#              the first line of pathname is the password. If the same pathname argument is supplied to -passin and -passout arguments then the first line will be used for the input password and the next
#              line for the output password. pathname need not refer to a regular file: it could for example refer to a device or named pipe.

#    fd:number read the password from the file descriptor number. This can be used to send the data via a pipe for example.

#    stdin     read the password from standard input.

# SEE ALSO
#    asn1parse(1), ca(1), config(5), crl(1), crl2pkcs7(1), dgst(1), dhparam(1), dsa(1), dsaparam(1), enc(1), gendsa(1), genpkey(1), genrsa(1), nseq(1), openssl(1), passwd(1), pkcs12(1), pkcs7(1), pkcs8(1),
#    rand(1), req(1), rsa(1), rsautl(1), s_client(1), s_server(1), s_time(1), smime(1), spkac(1), verify(1), version(1), x509(1), crypto(3), ssl(3), x509v3_config(5)

# HISTORY
#    The openssl(1) document appeared in OpenSSL 0.9.2.  The list-XXX-commands pseudo-commands were added in OpenSSL 0.9.3; The list-XXX-algorithms pseudo-commands were added in OpenSSL 1.0.0; the no-XXX
#    pseudo-commands were added in OpenSSL 0.9.5a.  For notes on the availability of other commands, see their individual manual pages.

### MANPAGE ###
###############


###################
### HOWTO: keys ###
# 1. Introduction

# Keys are the basis of public key algorithms and PKI.  Keys usually
# come in pairs, with one half being the public key and the other half
# being the private key.  With OpenSSL, the private key contains the
# public key information as well, so a public key doesn't need to be
# generated separately.

# Public keys come in several flavors, using different cryptographic
# algorithms.  The most popular ones associated with certificates are
# RSA and DSA, and this HOWTO will show how to generate each of them.


# 2. To generate a RSA key

# A RSA key can be used both for encryption and for signing.

# Generating a key for the RSA algorithm is quite easy, all you have to
# do is the following:

#   openssl genrsa -des3 -out privkey.pem 2048

# With this variant, you will be prompted for a protecting password.  If
# you don't want your key to be protected by a password, remove the flag
# '-des3' from the command line above.

#     NOTE: if you intend to use the key together with a server
#     certificate, it may be a good thing to avoid protecting it
#     with a password, since that would mean someone would have to
#     type in the password every time the server needs to access
#     the key.

# The number 2048 is the size of the key, in bits.  Today, 2048 or
# higher is recommended for RSA keys, as fewer amount of bits is
# consider insecure or to be insecure pretty soon.


# 3. To generate a DSA key

# A DSA key can be used for signing only.  This is important to keep
# in mind to know what kind of purposes a certificate request with a
# DSA key can really be used for.

# Generating a key for the DSA algorithm is a two-step process.  First,
# you have to generate parameters from which to generate the key:

#   openssl dsaparam -out dsaparam.pem 2048

# The number 2048 is the size of the key, in bits.  Today, 2048 or
# higher is recommended for DSA keys, as fewer amount of bits is
# consider insecure or to be insecure pretty soon.

# When that is done, you can generate a key using the parameters in
# question (actually, several keys can be generated from the same
# parameters):

#   openssl gendsa -des3 -out privkey.pem dsaparam.pem

# With this variant, you will be prompted for a protecting password.  If
# you don't want your key to be protected by a password, remove the flag
# '-des3' from the command line above.

#     NOTE: if you intend to use the key together with a server
#     certificate, it may be a good thing to avoid protecting it
#     with a password, since that would mean someone would have to
#     type in the password every time the server needs to access
#     the key.

# --
# Richard Levitte
### HOWTO: keys ###
###################

###########################
### HOWTO: certificates ###
# 1. Introduction

# How you handle certificates depend a great deal on what your role is.
# Your role can be one or several of:

#   - User of some client software
#   - User of some server software
#   - Certificate authority

# This file is for users who wish to get a certificate of their own.
# Certificate authorities should read ca.txt.

# In all the cases shown below, the standard configuration file, as
# compiled into openssl, will be used.  You may find it in /etc/,
# /usr/local/ssl/ or somewhere else.  The name is openssl.cnf, and
# is better described in another HOWTO <config.txt?>.  If you want to
# use a different configuration file, use the argument '-config {file}'
# with the command shown below.


# 2. Relationship with keys

# Certificates are related to public key cryptography by containing a
# public key.  To be useful, there must be a corresponding private key
# somewhere.  With OpenSSL, public keys are easily derived from private
# keys, so before you create a certificate or a certificate request, you
# need to create a private key.

# Private keys are generated with 'openssl genrsa' if you want a RSA
# private key, or 'openssl gendsa' if you want a DSA private key.
# Further information on how to create private keys can be found in
# another HOWTO <keys.txt?>.  The rest of this text assumes you have
# a private key in the file privkey.pem.


# 3. Creating a certificate request

# To create a certificate, you need to start with a certificate
# request (or, as some certificate authorities like to put
# it, "certificate signing request", since that's exactly what they do,
# they sign it and give you the result back, thus making it authentic
# according to their policies).  A certificate request can then be sent
# to a certificate authority to get it signed into a certificate, or if
# you have your own certificate authority, you may sign it yourself, or
# if you need a self-signed certificate (because you just want a test
# certificate or because you are setting up your own CA).

# The certificate request is created like this:

#   openssl req -new -key privkey.pem -out cert.csr

# Now, cert.csr can be sent to the certificate authority, if they can
# handle files in PEM format.  If not, use the extra argument '-outform'
# followed by the keyword for the format to use (see another HOWTO
# <formats.txt?>).  In some cases, that isn't sufficient and you will
# have to be more creative.

# When the certificate authority has then done the checks the need to
# do (and probably gotten payment from you), they will hand over your
# new certificate to you.

# Section 5 will tell you more on how to handle the certificate you
# received.


# 4. Creating a self-signed test certificate

# If you don't want to deal with another certificate authority, or just
# want to create a test certificate for yourself.  This is similar to
# creating a certificate request, but creates a certificate instead of
# a certificate request.  This is NOT the recommended way to create a
# CA certificate, see ca.txt.

#   openssl req -new -x509 -key privkey.pem -out cacert.pem -days 1095


# 5. What to do with the certificate

# If you created everything yourself, or if the certificate authority
# was kind enough, your certificate is a raw DER thing in PEM format.
# Your key most definitely is if you have followed the examples above.
# However, some (most?) certificate authorities will encode them with
# things like PKCS7 or PKCS12, or something else.  Depending on your
# applications, this may be perfectly OK, it all depends on what they
# know how to decode.  If not, There are a number of OpenSSL tools to
# convert between some (most?) formats.

# So, depending on your application, you may have to convert your
# certificate and your key to various formats, most often also putting
# them together into one file.  The ways to do this is described in
# another HOWTO <formats.txt?>, I will just mention the simplest case.
# In the case of a raw DER thing in PEM format, and assuming that's all
# right for yor applications, simply concatenating the certificate and
# the key into a new file and using that one should be enough.  With
# some applications, you don't even have to do that.


# By now, you have your cetificate and your private key and can start
# using the software that depend on it.

# --
# Richard Levitte
### HOWTO: certificates ###
###########################

