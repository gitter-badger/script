#!/usr/bin/ruby -w
# canvas_activepack.rb
# Description: Canvas ActionPack class

# ## .get()
# (from gem actionpack-4.0.2)
# ## Implementation from Behavior
# ------------------------------------------------------------------------------
#   get(action, *args)
# ------------------------------------------------------------------------------
# Simulate a GET request with the given parameters.

# * action: The controller action to call.
# * parameters: The HTTP parameters that you want to pass. This may be nil, a
#   hash, or a string that is appropriately encoded
#   (application/x-www-form-urlencoded or multipart/form-data).
# * session: A hash of parameters to store in the session. This may be nil.
# * flash: A hash of parameters to store in the flash. This may be nil.

# You can also simulate POST, PATCH, PUT, DELETE, HEAD, and OPTIONS requests
# with post, patch, put, delete, head, and options.

# Note that the request method is not verified. The different methods are
# available to make the tests more expressive.


# (from gem actionpack-4.0.2)
# ## Implementation from RequestHelpers
# ------------------------------------------------------------------------------
#   get(path, parameters = nil, headers_or_env = nil)

# ------------------------------------------------------------------------------

# Performs a GET request with the given parameters.

# * path: The URI (as a String) on which you want to perform a GET request.
# * parameters: The HTTP parameters that you want to pass. This may be nil, a
#   Hash, or a String that is appropriately encoded
#   (application/x-www-form-urlencoded or multipart/form-data).
# * headers_or_env: Additional headers to pass, as a Hash. The headers will be
#   merged into the Rack env hash.

# This method returns a Response object, which one can use to inspect the
# details of the response. Furthermore, if this method was called from an
# ActionDispatch::IntegrationTest object, then that object's @response instance
# variable will point to the same response object.

# You can also perform POST, PATCH, PUT, DELETE, and HEAD requests with #post,
# #patch, #put, #delete, and #head.


# (from gem actionpack-4.0.2)
# ## Implementation from HttpHelpers
# ------------------------------------------------------------------------------
#   get(*args, &block)
# ------------------------------------------------------------------------------

# Define a route that only recognizes HTTP GET. For supported arguments, see
# match[rdoc-ref:Base#match]

#   get 'bacon', to: 'food#bacon'


# (from gem activemodel-4.0.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  EErrrroorrss
# ------------------------------------------------------------------------------
#   get(key)
# ------------------------------------------------------------------------------
# Get messages for key.

#   person.errors.messages   # => {:name=>["can not be nil"]}
#   person.errors.get(:name) # => ["can not be nil"]
#   person.errors.get(:age)  # => nil


# (from gem activesupport-4.0.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  CCllaassssCCaacchhee
# ------------------------------------------------------------------------------
#   get(key)
# ------------------------------------------------------------------------------

# (from gem celluloid-0.15.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  IInntteerrnnaallPPooooll
# ------------------------------------------------------------------------------
#   get(&block)
# ------------------------------------------------------------------------------

# Get a thread from the pool, running the given block


# (from gem celluloid-0.15.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  RReeggiissttrryy
# ------------------------------------------------------------------------------
#   get(name)
# ------------------------------------------------------------------------------


# (from gem ffi-1.9.3)
# === IImmpplleemmeennttaattiioonn  ffrroomm  EEnnuumm
# ------------------------------------------------------------------------------
#   get(ptr)
# ------------------------------------------------------------------------------

# @param [AbstractMemory] ptr pointer on a {Struct} @return [Object] Get an
# object of type {#type} from memory pointed by ptr.


# (from gem ffi-1.9.3)
# === IImmpplleemmeennttaattiioonn  ffrroomm  IInnnneerrSSttrruucctt
# ------------------------------------------------------------------------------
#   get(ptr)
# ------------------------------------------------------------------------------


# (from gem ffi-1.9.3)
# === IImmpplleemmeennttaattiioonn  ffrroomm  MMaappppeedd
# ------------------------------------------------------------------------------
#   get(ptr)
# ------------------------------------------------------------------------------


# (from gem factory_girl-4.3.0)
# === IImmpplleemmeennttaattiioonn  ffrroomm  AAttttrriibbuutteeAAssssiiggnneerr
# ------------------------------------------------------------------------------
#   get(attribute_name)
# ------------------------------------------------------------------------------


# (from gem geocoder-1.1.9)
# === IImmpplleemmeennttaattiioonn  ffrroomm  LLooookkuupp
# ------------------------------------------------------------------------------
#   get(name)
# ------------------------------------------------------------------------------

# Retrieve a Lookup object from the store. Use this instead of
# Geocoder::Lookup::X.new to get an already-configured Lookup object.


# (from ruby core)
# === IImmpplleemmeennttaattiioonn  ffrroomm  GGeettooppttLLoonngg
# ------------------------------------------------------------------------------
#   get()
# ------------------------------------------------------------------------------

# Get next option name and its argument, as an Array of two elements.

# The option name is always converted to the first (preferred) name given in the
# original options to GetoptLong.new.

# Example: ['--option', 'value']

# Returns nil if the processing is complete (as determined by
# STATUS_TERMINATED).


# (from gem gherkin-2.12.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  II1188nn
# ------------------------------------------------------------------------------
#   get(iso_code)
# ------------------------------------------------------------------------------


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  HHeeaaddeerrss
# ------------------------------------------------------------------------------
#   get(key = nil)
# ------------------------------------------------------------------------------

# Returns an Array of headers for the given key.  Each element is a pair of key
# and value.  It returns an single element Array even if the only one header
# exists.  If nil key given, it returns all headers.


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  HHTTTTPPCClliieenntt
# ------------------------------------------------------------------------------
#   get(uri, *args, &block)
# ------------------------------------------------------------------------------

# Sends GET request to the specified URL.  See request for arguments.


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  BBaassiiccAAuutthh
# ------------------------------------------------------------------------------
#   get(req)
# ------------------------------------------------------------------------------

# Response handler: returns credential. It sends cred only when a given uri is;
# * child page of challengeable(got *Authenticate before) uri and,
# * child page of defined credential


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  DDiiggeessttAAuutthh
# ------------------------------------------------------------------------------
#   get(req)
# ------------------------------------------------------------------------------

# Response handler: returns credential. It sends cred only when a given uri is;
# * child page of challengeable(got *Authenticate before) uri and,
# * child page of defined credential


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  NNeeggoottiiaatteeAAuutthh
# ------------------------------------------------------------------------------
#   get(req)
# ------------------------------------------------------------------------------

# Response handler: returns credential. See ruby/ntlm for negotiation state
# transition.


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  OOAAuutthh
# ------------------------------------------------------------------------------
#   get(req)
# ------------------------------------------------------------------------------

# Response handler: returns credential. It sends cred only when a given uri is;
# * child page of challengeable(got *Authenticate before) uri and,
# * child page of defined credential


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  PPrrooxxyyBBaassiiccAAuutthh
# ------------------------------------------------------------------------------
#   get(req)

# ------------------------------------------------------------------------------


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  PPrrooxxyyDDiiggeessttAAuutthh
# ------------------------------------------------------------------------------
#   get(req)

# ------------------------------------------------------------------------------

# overrides DigestAuth#get. Uses default user name and password regardless of
# target uri if the proxy has required authentication before


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  SSSSPPIINNeeggoottiiaatteeAAuutthh
# ------------------------------------------------------------------------------
#   get(req)

# ------------------------------------------------------------------------------

# Response handler: returns credential. See win32/sspi for negotiation state
# transition.


# (from gem i18n-0.6.9)
# === IImmpplleemmeennttaattiioonn  ffrroomm  TTrraannsslliitteerraattoorr
# ------------------------------------------------------------------------------
#   get(rule = nil)

# ------------------------------------------------------------------------------

# Get a transliterator instance.


# (from gem main-5.2.0)
# === IImmpplleemmeennttaattiioonn  ffrroomm  GGeettooppttLLoonngg
# ------------------------------------------------------------------------------
#   get()

# ------------------------------------------------------------------------------

# Get next option name and its argument as an array.


# (from gem main-5.2.0)
# === IImmpplleemmeennttaattiioonn  ffrroomm  PPaarraammeetteerr
# ------------------------------------------------------------------------------
#   get()

# ------------------------------------------------------------------------------


# (from gem map-6.5.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  MMaapp
# ------------------------------------------------------------------------------
#   get(*keys) { || ... }

# ------------------------------------------------------------------------------

# support for compound key indexing and depth first iteration


# (from ruby core)
# === IImmpplleemmeennttaattiioonn  ffrroomm  FFTTPP
# ------------------------------------------------------------------------------
#   get(remotefile, localfile = File.basename(remotefile), blocksize = DEFAULT_BLOCKSIZE) { |data| ... }

# ------------------------------------------------------------------------------

# Retrieves remotefile in whatever mode the session is set (text or binary).
# See #gettextfile and #getbinaryfile.


# (from ruby core)
# === IImmpplleemmeennttaattiioonn  ffrroomm  HHTTTTPP
# ------------------------------------------------------------------------------
#   get(uri_or_host, path = nil, port = nil)

# ------------------------------------------------------------------------------

# Sends a GET request to the target and returns the HTTP response as a string.
# The target can either be specified as (uri), or as (host, path, port = 80);
# so:

#   print Net::HTTP.get(URI('http://www.example.com/index.html'))

# or:

#   print Net::HTTP.get('www.example.com', '/index.html')


# (from ruby core)
# === IImmpplleemmeennttaattiioonn  ffrroomm  HHTTTTPP
# ------------------------------------------------------------------------------
#   get(path, initheader = {}, dest = nil) { |body_segment| ... }

# ------------------------------------------------------------------------------

# Retrieves data from path on the connected-to host which may be an absolute
# path String or a URI to extract the path from.

# initheader must be a Hash like { 'Accept' => '//', ... }, and it defaults to
# an empty hash. If initheader doesn't have the key 'accept-encoding', then a
# value of "gzip;q=1.0,deflate;q=0.6,identity;q=0.3" is used, so that gzip
# compression is used in preference to deflate compression, which is used in
# preference to no compression. Ruby doesn't have libraries to support the
# compress (Lempel-Ziv) compression, so that is not supported.  The intent of
# this is to reduce bandwidth by default.   If this routine sets up compression,
# then it does the decompression also, removing the header as well to prevent
# confusion.  Otherwise it leaves the body as it found it.

# This method returns a Net::HTTPResponse object.

# If called with a block, yields each fragment of the entity body in turn as a
# string as it is read from the socket.  Note that in this case, the returned
# response object will nnoott contain a (meaningful) body.

# dest argument is obsolete. It still works but you must not use it.

# This method never raises an exception.

#   response = http.get('/index.html')

#   # using block
#   File.open('result.txt', 'w') {|f|
#     http.get('/~foo/') do |str|
#       f.write str
#     end
#   }


# (from gem net-ssh-2.7.0)
# === IImmpplleemmeennttaattiioonn  ffrroomm  KKeeyyFFaaccttoorryy
# ------------------------------------------------------------------------------
#   get(name)

# ------------------------------------------------------------------------------

# Fetch an OpenSSL key instance by its SSH name. It will be a new, empty key of
# the given type.


# (from gem net-ssh-2.7.0)
# === IImmpplleemmeennttaattiioonn  ffrroomm  CCiipphheerrFFaaccttoorryy
# ------------------------------------------------------------------------------
#   get(name, options={})

# ------------------------------------------------------------------------------

# Retrieves a new instance of the named algorithm. The new instance will be
# initialized using an iv and key generated from the given iv, key, shared, hash
# and digester values. Additionally, the cipher will be put into encryption or
# decryption mode, based on the value of the encrypt parameter.


# (from gem net-ssh-2.7.0)
# === IImmpplleemmeennttaattiioonn  ffrroomm  HHMMAACC
# ------------------------------------------------------------------------------
#   get(name, key="", parameters = {})

# ------------------------------------------------------------------------------

# Retrieves a new hmac instance of the given SSH type (name). If key is given,
# the new instance will be initialized with that key.


# (from gem nokogiri-1.6.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  EEnnttiittyyLLooookkuupp
# ------------------------------------------------------------------------------
#   get(key)

# ------------------------------------------------------------------------------

# Get the HTML::EntityDescription for key


# (from gem nokogiri-1.6.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  NNooddee
# ------------------------------------------------------------------------------
#   get(attribute)

# ------------------------------------------------------------------------------

# Get the value for attribute


# (from ruby core)
# === IImmpplleemmeennttaattiioonn  ffrroomm  PPaarrsseerr
# ------------------------------------------------------------------------------
#   get()

# ------------------------------------------------------------------------------

# Pulls the next token from the stream.


# (from gem rspec-expectations-2.14.4)
# === IImmpplleemmeennttaattiioonn  ffrroomm  OOppeerraattoorrMMaattcchheerr
# ------------------------------------------------------------------------------
#   get(klass, operator)

# ------------------------------------------------------------------------------


# (from gem rack-1.5.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  HHaannddlleerr
# ------------------------------------------------------------------------------
#   get(server)

# ------------------------------------------------------------------------------


# (from gem rack-1.5.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  MMoocckkRReeqquueesstt
# ------------------------------------------------------------------------------
#   get(uri, opts={})

# ------------------------------------------------------------------------------


# (from gem rack-test-0.6.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  SSeessssiioonn
# ------------------------------------------------------------------------------
#   get(uri, params = {}, env = {}, &block)

# ------------------------------------------------------------------------------

# Issue a GET request for the given URI with the given params and Rack
# environment. Stores the issues request object in #last_request and the app's
# response in #last_response. Yield #last_response to a block if given.

# Example:
#   get "/"


# (from gem redis-3.0.6)
# === IImmpplleemmeennttaattiioonn  ffrroomm  RReeddiiss
# ------------------------------------------------------------------------------
#   get(key)

# ------------------------------------------------------------------------------

# Get the value of a key.

# @param [String] key @return [String]


# (from gem redis-3.0.6)
# === IImmpplleemmeennttaattiioonn  ffrroomm  DDiissttrriibbuutteedd
# ------------------------------------------------------------------------------
#   get(key)

# ------------------------------------------------------------------------------

# Get the value of a key.


# (from gem slop-3.4.7)
# === IImmpplleemmeennttaattiioonn  ffrroomm  SSlloopp
# ------------------------------------------------------------------------------
#   get(key)

# ------------------------------------------------------------------------------


# (from gem slop-3.4.7)
# === IImmpplleemmeennttaattiioonn  ffrroomm  CCoommmmaannddss
# ------------------------------------------------------------------------------
#   get(key)

# ------------------------------------------------------------------------------


# (from gem term-ansicolor-1.2.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  AAttttrriibbuuttee
# ------------------------------------------------------------------------------
#   get(name)

# ------------------------------------------------------------------------------


# (from gem thor-0.18.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  AAccttiioonnss
# ------------------------------------------------------------------------------
#   get(source, *args, &block)

# ------------------------------------------------------------------------------

# Gets the content at the given address and places it at the given relative
# destination. If a block is given instead of destination, the content of the
# url is yielded and used as location.

# ==== PPaarraammeetteerrss
# source<String>:
#   the address of the given content.

# destination<String>:
#   the relative path to the destination root.

# config<Hash>:
#   give :verbose => false to not log the status.


# ==== EExxaammpplleess

#   get "http://gist.github.com/103208", "doc/README"

#   get "http://gist.github.com/103208" do |content|
#     content.split("\n").first
#   end


# = ..ppuutt

# (from gem actionpack-4.0.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  BBeehhaavviioorr
# ------------------------------------------------------------------------------
#   put(action, *args)

# ------------------------------------------------------------------------------

# Simulate a PUT request with the given parameters and set/volley the response.
# See get for more details.


# (from gem actionpack-4.0.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  RReeqquueessttHHeellppeerrss
# ------------------------------------------------------------------------------
#   put(path, parameters = nil, headers_or_env = nil)

# ------------------------------------------------------------------------------

# Performs a PUT request with the given parameters. See #get for more details.


# (from gem actionpack-4.0.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  HHttttppHHeellppeerrss
# ------------------------------------------------------------------------------
#   put(*args, &block)

# ------------------------------------------------------------------------------

# Define a route that only recognizes HTTP PUT. For supported arguments, see
# match[rdoc-ref:Base#match]

#   put 'bacon', to: 'food#bacon'


# (from gem celluloid-0.15.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  IInntteerrnnaallPPooooll
# ------------------------------------------------------------------------------
#   put(thread)

# ------------------------------------------------------------------------------

# Return a thread to the pool


# (from gem ffi-1.9.3)
# === IImmpplleemmeennttaattiioonn  ffrroomm  EEnnuumm
# ------------------------------------------------------------------------------
#   put(ptr, value)

# ------------------------------------------------------------------------------

# @param [AbstractMemory] ptr pointer on a {Struct} @param  value @return [nil]
# Set value into memory pointed by ptr.


# (from gem ffi-1.9.3)
# === IImmpplleemmeennttaattiioonn  ffrroomm  IInnnneerrSSttrruucctt
# ------------------------------------------------------------------------------
#   put(ptr, value)

# ------------------------------------------------------------------------------


# (from gem ffi-1.9.3)
# === IImmpplleemmeennttaattiioonn  ffrroomm  MMaappppeedd
# ------------------------------------------------------------------------------
#   put(ptr, value)

# ------------------------------------------------------------------------------


# (from gem httpclient-2.3.4.1)
# === IImmpplleemmeennttaattiioonn  ffrroomm  HHTTTTPPCClliieenntt
# ------------------------------------------------------------------------------
#   put(uri, *args, &block)

# ------------------------------------------------------------------------------

# Sends PUT request to the specified URL.  See request for arguments.


# (from ruby core)
# === IImmpplleemmeennttaattiioonn  ffrroomm  FFTTPP
# ------------------------------------------------------------------------------
#   put(localfile, remotefile = File.basename(localfile), blocksize = DEFAULT_BLOCKSIZE, &block)

# ------------------------------------------------------------------------------

# Transfers localfile to the server in whatever mode the session is set (text or
# binary).  See #puttextfile and #putbinaryfile.


# (from gem rack-1.5.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  MMoocckkRReeqquueesstt
# ------------------------------------------------------------------------------
#   put(uri, opts={})

# ------------------------------------------------------------------------------


# (from gem rack-test-0.6.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  SSeessssiioonn
# ------------------------------------------------------------------------------
#   put(uri, params = {}, env = {}, &block)

# ------------------------------------------------------------------------------

# Issue a PUT request for the given URI. See #get

# Example:
#   put "/"


