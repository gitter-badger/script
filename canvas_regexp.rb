# canvas_regex.rb
# Author: Andy Bettisworth
# Description: Canvas Regexp for dynamic parsing using patterns

<<<<<<< HEAD
=======
## READ all non-alphanumeric characters
# validate_me = 'This is & - some thoughts / that are.'
# puts 'original: ' + validate_me
# validate_me.gsub!(/[^[:alnum:]]/,'-')
# puts 'Best method: '+ validate_me.gsub(/\W/,'_')
# puts 'updated: '+ validate_me.gsub(/\W/,'_')

>>>>>>> 009a0d805c565cd30f9a7283bd8c85cae0bb8209
## DELETE all comments
# doc_with_comments = <<-EOF
#   # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#   #
#   # Note: You'll currently still have to declare fixtures explicitly in integration tests
#   # -- they do not yet inherit this setting
#   fixtures :all
# EOF
# doc_with_comments.gsub!(/^\s*#.*\n/, '')
# doc_with_comments.gsub!(/^\s*fixtures\W:all\n/, '')
# puts doc_with_comments

## NOTE Repetition
## *      Zero or more times
## +      One or more times
## ?      Zero or more times
## {n}    Exactly n times
## {n,}   n or more times
## {,m}   m or less times
## {n,m}  At least n and at most m times
# puts /[a-c].*/.match("Testing a b c")
# puts /[a-c].{,2}/.match("Testing a b c")

## Character classes '[ab]'
## means a xor b
# /[abc]/.match("Testing a b c")
## NOTE that the first match stops the matching
## NOTE you can create a range using '-'
## abcdef == [a-f]

## Metacharacters
## ( )
## [ ]
## { }
## .
## ?
## +
## *
## NOTE to use them as literals, escape them '\'
## so to match a literal backslash-escape use '\\\'
## > Q: why the third backslash?

## EXAMPLE usage
# our_match = /cat/.match("tacocat")
#=> cat
# our_match = /cat/ =~ "tacocat"
#=> 4
# our_match = %r{cat}.match("tacocat")
#=> cat
# our_match = %r{cat} =~ "tacocat"
#=> 4
# our_match = Regexp.new("cat").match("tacocat")
#=> cat
# our_match = Regexp.new("cat") =~ "tacocat"
#=> 4
# our_match = Regexp.new(/cat/).match("tacocat")
#=> cat
# our_match = Regexp.new(/cat/) =~ "tacocat"
#=> 4
# puts our_match
## NOTE our favored method of using regex is
## with the .match() method for returning matches
## with the =~ for returning position of a match

## Q: how can I declare a regular expression in Ruby?
# //.match(content)
# // =~ content
# %r{}
# Regexp.new= RReeggeexxpp  <<  OObbjjeecctt

# (from ruby core)
# ------------------------------------------------------------------------------
# Regexp serialization/deserialization

# A Regexp holds a regular expression, used to match a pattern against strings.
# Regexps are created using the /.../ and %r{...} literals, and by the
# Regexp::new constructor.

# Regular expressions (_r_e_g_e_x_ps) are patterns which describe the
# contents of a string. They're used for testing whether a string contains a
# given pattern, or extracting the portions that match. They are created with
# the /_p_a_t/ and %r{_p_a_t} literals or the Regexp.new constructor.

# A regexp is usually delimited with forward slashes (/). For example:

#   /hay/ =~ 'haystack'   #=> 0
#   /y/.match('haystack') #=> #<MatchData "y">

# If a string contains the pattern it is said to _m_a_t_c_h. A literal
# string matches itself.

# Here 'haystack' does not contain the pattern 'needle', so it doesn't match:

#   /needle/.match('haystack') #=> nil

# Here 'haystack' contains the pattern 'hay', so it matches:

#   /hay/.match('haystack')    #=> #<MatchData "hay">

# Specifically, /st/ requires that the string contains the letter _s followed
# by the letter _t, so it matches _h_a_y_s_t_a_c_k, also.

# == ==~~  aanndd  RReeggeexxpp##mmaattcchh

# Pattern matching may be achieved by using =~ operator or Regexp#match method.

# === ==~~  ooppeerraattoorr

# =~ is Ruby's basic pattern-matching operator.  When one operand is a regular
# expression and the other is a string then the regular expression is used as a
# pattern to match against the string.  (This operator is equivalently defined
# by Regexp and String so the order of String and Regexp do not matter. Other
# classes may have different implementations of =~.)  If a match is found, the
# operator returns index of first match in string, otherwise it returns nil.

#   /hay/ =~ 'haystack'   #=> 0
#   'haystack' =~ /hay/   #=> 0
#   /a/   =~ 'haystack'   #=> 1
#   /u/   =~ 'haystack'   #=> nil

# Using =~ operator with a String and Regexp the $~ global variable is set after
# a successful match.  $~ holds a MatchData object. Regexp.last_match is
# equivalent to $~.

# === RReeggeexxpp##mmaattcchh  mmeetthhoodd

# The #match method returns a MatchData object:

#   /st/.match('haystack')   #=> #<MatchData "st">

# == MMeettaacchhaarraacctteerrss  aanndd  EEssccaappeess

# The following are _m_e_t_a_c_h_a_r_a_c_t_e_r_s (, ), [, ], {, },
# ., ?, +, *. They have a specific meaning when appearing in a pattern. To match
# them literally they must be backslash-escaped. To match a backslash literally
# backslash-escape that: \\\\\.

#   /1 \+ 2 = 3\?/.match('Does 1 + 2 = 3?') #=> #<MatchData "1 + 2 = 3?">

# Patterns behave like double-quoted strings so can contain the same backslash
# escapes.

#   /\s\u{6771 4eac 90fd}/.match("Go to 東京都")
#       #=> #<MatchData " 東京都">

# Arbitrary Ruby expressions can be embedded into patterns with the #{...}
# construct.

#   place = "東京都"
#   /#{place}/.match("Go to 東京都")
#       #=> #<MatchData "東京都">

# == CChhaarraacctteerr  CCllaasssseess

# A _c_h_a_r_a_c_t_e_r_ _c_l_a_s_s is delimited with square
# brackets ([, ]) and lists characters that may appear at that point in the
# match. /[ab]/ means _a or _b, as opposed to /ab/ which means _a followed by
# _b.

#   /W[aeiou]rd/.match("Word") #=> #<MatchData "Word">

# Within a character class the hyphen (-) is a metacharacter denoting an
# inclusive range of characters. [abcd] is equivalent to [a-d]. A range can be
# followed by another range, so [abcdwxyz] is equivalent to [a-dw-z]. The order
# in which ranges or individual characters appear inside a character class is
# irrelevant.

#   /[0-9a-f]/.match('9f') #=> #<MatchData "9">
#   /[9f]/.match('9f')     #=> #<MatchData "9">

# If the first character of a character class is a caret (^) the class is
# inverted: it matches any character _e_x_c_e_p_t those named.

#   /[^a-eg-z]/.match('f') #=> #<MatchData "f">

# A character class may contain another character class. By itself this isn't
# useful because [a-z[0-9]] describes the same set as [a-z0-9]. However,
# character classes also support the && operator which performs set intersection
# on its arguments. The two can be combined as follows:

#   /[a-w&&[^c-g]z]/ # ([a-w] AND ([^c-g] OR z))

# This is equivalent to:

#   /[abh-w]/

# The following metacharacters also behave like character classes:

# * /./ - Any character except a newline.
# * /./m - Any character (the m modifier enables multiline mode)
# * /\w/ - A word character ([a-zA-Z0-9_])
# * /\W/ - A non-word character ([^a-zA-Z0-9_]). Please take a look at {Bug
#   #4044}[https://bugs.ruby-lang.org/issues/4044] if using /\W/ with the /i
#   modifier.
# * /\d/ - A digit character ([0-9])
# * /\D/ - A non-digit character ([^0-9])
# * /\h/ - A hexdigit character ([0-9a-fA-F])
# * /\H/ - A non-hexdigit character ([^0-9a-fA-F])
# * /\s/ - A whitespace character: /[ \t\r\n\f]/
# * /\S/ - A non-whitespace character: /[^ \t\r\n\f]/

# POSIX _b_r_a_c_k_e_t_ _e_x_p_r_e_s_s_i_o_n_s are also
# similar to character classes. They provide a portable alternative to the
# above, with the added benefit that they encompass non-ASCII characters. For
# instance, /\d/ matches only the ASCII decimal digits (0-9); whereas
# /[[:digit:]]/ matches any character in the Unicode _N_d category.

# * /[[:alnum:]]/ - Alphabetic and numeric character
# * /[[:alpha:]]/ - Alphabetic character
# * /[[:blank:]]/ - Space or tab
# * /[[:cntrl:]]/ - Control character
# * /[[:digit:]]/ - Digit
<<<<<<< HEAD
# * /[[:graph:]]/ - Non-blank character (excludes spaces, control characters,
#   and similar)
=======
# * /[[:graph:]]/ - Non-blank character (excludes spaces, control characters
>>>>>>> 009a0d805c565cd30f9a7283bd8c85cae0bb8209
# * /[[:lower:]]/ - Lowercase alphabetical character
# * /[[:print:]]/ - Like [:graph:], but includes the space character
# * /[[:punct:]]/ - Punctuation character
# * /[[:space:]]/ - Whitespace character ([:blank:], newline, carriage return,
#   etc.)
# * /[[:upper:]]/ - Uppercase alphabetical
# * /[[:xdigit:]]/ - Digit allowed in a hexadecimal number (i.e., 0-9a-fA-F)

# Ruby also supports the following non-POSIX character classes:

# * /[[:word:]]/ - A character in one of the following Unicode general
#   categories _L_e_t_t_e_r, _M_a_r_k, _N_u_m_b_e_r,
#   _C_o_n_n_e_c_t_o_r___P_u_n_c_t_u_a_t_i_o_n
# * /[[:ascii:]]/ - A character in the ASCII character set

#     # U+06F2 is "EXTENDED ARABIC-INDIC DIGIT TWO"
#     /[[:digit:]]/.match("\u06F2")    #=> #<MatchData "\u{06F2}">
#     /[[:upper:]][[:lower:]]/.match("Hello") #=> #<MatchData "He">
#     /[[:xdigit:]][[:xdigit:]]/.match("A6")  #=> #<MatchData "A6">

# == RReeppeettiittiioonn

# The constructs described so far match a single character. They can be followed
# by a repetition metacharacter to specify how many times they need to occur.
# Such metacharacters are called _q_u_a_n_t_i_f_i_e_r_s.

# * * - Zero or more times
# * + - One or more times
# * ? - Zero or one times (optional)
# * {_n} - Exactly _n times
# * {_n,} - _n or more times
# * {,_m} - _m or less times
# * {_n,_m} - At least _n and at most _m times

# At least one uppercase character ('H'), at least one lowercase character
# ('e'), two 'l' characters, then one 'o':

#   "Hello".match(/[[:upper:]]+[[:lower:]]+l{2}o/) #=> #<MatchData "Hello">

# Repetition is _g_r_e_e_d_y by default: as many occurrences as possible
# are matched while still allowing the overall match to succeed. By contrast,
# _l_a_z_y matching makes the minimal amount of matches necessary for
# overall success. A greedy metacharacter can be made lazy by following it with
# ?.

# Both patterns below match the string. The first uses a greedy quantifier so
# '.+' matches '<a><b>'; the second uses a lazy quantifier so '.+?' matches
# '<a>':

#   /<.+>/.match("<a><b>")  #=> #<MatchData "<a><b>">
#   /<.+?>/.match("<a><b>") #=> #<MatchData "<a>">

# A quantifier followed by + matches _p_o_s_s_e_s_s_i_v_e_l_y: once
# it has matched it does not backtrack. They behave like greedy quantifiers, but
# having matched they refuse to "give up" their match even if this jeopardises
# the overall match.

# == CCaappttuurriinngg

# Parentheses can be used for _c_a_p_t_u_r_i_n_g. The text enclosed by
# the _n<sup>th</sup> group of parentheses can be subsequently referred to with
# _n. Within a pattern use the _b_a_c_k_r_e_f_e_r_e_n_c_e \n;
# outside of the pattern use MatchData[_n].

# 'at' is captured by the first group of parentheses, then referred to later
# with \1:

#   /[csh](..) [csh]\1 in/.match("The cat sat in the hat")
#       #=> #<MatchData "cat sat in" 1:"at">

# Regexp#match returns a MatchData object which makes the captured text
# available with its #[] method:

#   /[csh](..) [csh]\1 in/.match("The cat sat in the hat")[1] #=> 'at'

# Capture groups can be referred to by name when defined with the
# (?<_n_a_m_e>) or (?'_n_a_m_e') constructs.

#   /\$(?<dollars>\d+)\.(?<cents>\d+)/.match("$3.67")
#       => #<MatchData "$3.67" dollars:"3" cents:"67">
#   /\$(?<dollars>\d+)\.(?<cents>\d+)/.match("$3.67")[:dollars] #=> "3"

# Named groups can be backreferenced with \k<_n_a_m_e>, where _n_a_m_e
# is the group name.

#   /(?<vowel>[aeiou]).\k<vowel>.\k<vowel>/.match('ototomy')
#       #=> #<MatchData "ototo" vowel:"o">

# NNoottee: A regexp can't use named backreferences and numbered
# backreferences simultaneously.

# When named capture groups are used with a literal regexp on the left-hand side
# of an expression and the =~ operator, the captured text is also assigned to
# local variables with corresponding names.

#   /\$(?<dollars>\d+)\.(?<cents>\d+)/ =~ "$3.67" #=> 0
#   dollars #=> "3"

# == GGrroouuppiinngg

# Parentheses also _g_r_o_u_p the terms they enclose, allowing them to be
# quantified as one _a_t_o_m_i_c whole.

# The pattern below matches a vowel followed by 2 word characters:

#   /[aeiou]\w{2}/.match("Caenorhabditis elegans") #=> #<MatchData "aen">

# Whereas the following pattern matches a vowel followed by a word character,
# twice, i.e. [aeiou]\w[aeiou]\w: 'enor'.

#   /([aeiou]\w){2}/.match("Caenorhabditis elegans")
#       #=> #<MatchData "enor" 1:"or">

# The (?:...) construct provides grouping without capturing. That is, it
# combines the terms it contains into an atomic whole without creating a
# backreference. This benefits performance at the slight expense of readability.

# The first group of parentheses captures 'n' and the second 'ti'. The second
# group is referred to later with the backreference \2:

#   /I(n)ves(ti)ga\2ons/.match("Investigations")
#       #=> #<MatchData "Investigations" 1:"n" 2:"ti">

# The first group of parentheses is now made non-capturing with '?:', so it
# still matches 'n', but doesn't create the backreference. Thus, the
# backreference \1 now refers to 'ti'.

#   /I(?:n)ves(ti)ga\1ons/.match("Investigations")
#       #=> #<MatchData "Investigations" 1:"ti">

# === AAttoommiicc  GGrroouuppiinngg

# Grouping can be made _a_t_o_m_i_c with (?>_p_a_t). This causes the
# subexpression _p_a_t to be matched independently of the rest of the
# expression such that what it matches becomes fixed for the remainder of the
# match, unless the entire subexpression must be abandoned and subsequently
# revisited. In this way _p_a_t is treated as a non-divisible whole. Atomic
# grouping is typically used to optimise patterns so as to prevent the regular
# expression engine from backtracking needlessly.

# The " in the pattern below matches the first character of the string, then .*
# matches _Q_u_o_t_e_". This causes the overall match to fail, so the text
# matched by .* is backtracked by one position, which leaves the final character
# of the string available to match "

#   /".*"/.match('"Quote"')     #=> #<MatchData "\"Quote\"">

# If .* is grouped atomically, it refuses to backtrack _Q_u_o_t_e_", even
# though this means that the overall match fails

#   /"(?>.*)"/.match('"Quote"') #=> nil

# == SSuubbeexxpprreessssiioonn  CCaallllss

# The \g<_n_a_m_e> syntax matches the previous subexpression named
# _n_a_m_e, which can be a group name or number, again. This differs from
# backreferences in that it re-executes the group rather than simply trying to
# re-match the same text.

# This pattern matches a _( character and assigns it to the paren group, tries
# to call that the paren sub-expression again but fails, then matches a literal
# _):

#   /\A(?<paren>\(\g<paren>*\))*\z/ =~ '()'

#   /\A(?<paren>\(\g<paren>*\))*\z/ =~ '(())' #=> 0
#   # ^1
#   #      ^2
#   #           ^3
#   #                 ^4
#   #      ^5
#   #           ^6
#   #                      ^7
#   #                       ^8
#   #                       ^9
#   #                           ^10

# 1. Matches at the beginning of the string, i.e. before the first character.
# 2. Enters a named capture group called paren
# 3. Matches a literal _(, the first character in the string
# 4. Calls the paren group again, i.e. recurses back to the second step
# 5. Re-enters the paren group
# 6. Matches a literal _(, the second character in the string
# 7. Try to call paren a third time, but fail because doing so would prevent an
#    overall successful match
# 8. Match a literal _), the third character in the string. Marks the end of
#    the second recursive call
# 9. Match a literal _), the fourth character in the string
# 10. Match the end of the string

# == AAlltteerrnnaattiioonn

# The vertical bar metacharacter (|) combines two expressions into a single one
# that matches either of the expressions. Each expression is an
# _a_l_t_e_r_n_a_t_i_v_e.

#   /\w(and|or)\w/.match("Feliformia") #=> #<MatchData "form" 1:"or">
#   /\w(and|or)\w/.match("furandi")    #=> #<MatchData "randi" 1:"and">
#   /\w(and|or)\w/.match("dissemblance") #=> nil

# == CChhaarraacctteerr  PPrrooppeerrttiieess

# The \p{} construct matches characters with the named property, much like POSIX
# bracket classes.

# * /\p{Alnum}/ - Alphabetic and numeric character
# * /\p{Alpha}/ - Alphabetic character
# * /\p{Blank}/ - Space or tab
# * /\p{Cntrl}/ - Control character
# * /\p{Digit}/ - Digit
# * /\p{Graph}/ - Non-blank character (excludes spaces, control characters, and
#   similar)
# * /\p{Lower}/ - Lowercase alphabetical character
# * /\p{Print}/ - Like \p{Graph}, but includes the space character
# * /\p{Punct}/ - Punctuation character
# * /\p{Space}/ - Whitespace character ([:blank:], newline, carriage return,
#   etc.)
# * /\p{Upper}/ - Uppercase alphabetical
# * /\p{XDigit}/ - Digit allowed in a hexadecimal number (i.e., 0-9a-fA-F)
# * /\p{Word}/ - A member of one of the following Unicode general category
#   _L_e_t_t_e_r, _M_a_r_k, _N_u_m_b_e_r,
#   _C_o_n_n_e_c_t_o_r___P_u_n_c_t_u_a_t_i_o_n
# * /\p{ASCII}/ - A character in the ASCII character set
# * /\p{Any}/ - Any Unicode character (including unassigned characters)
# * /\p{Assigned}/ - An assigned character

# A Unicode character's _G_e_n_e_r_a_l_ _C_a_t_e_g_o_r_y value
# can also be matched with \p{_A_b} where _A_b is the category's
# abbreviation as described below:

# * /\p{L}/ - 'Letter'
# * /\p{Ll}/ - 'Letter: Lowercase'
# * /\p{Lm}/ - 'Letter: Mark'
# * /\p{Lo}/ - 'Letter: Other'
# * /\p{Lt}/ - 'Letter: Titlecase'
# * /\p{Lu}/ - 'Letter: Uppercase
# * /\p{Lo}/ - 'Letter: Other'
# * /\p{M}/ - 'Mark'
# * /\p{Mn}/ - 'Mark: Nonspacing'
# * /\p{Mc}/ - 'Mark: Spacing Combining'
# * /\p{Me}/ - 'Mark: Enclosing'
# * /\p{N}/ - 'Number'
# * /\p{Nd}/ - 'Number: Decimal Digit'
# * /\p{Nl}/ - 'Number: Letter'
# * /\p{No}/ - 'Number: Other'
# * /\p{P}/ - 'Punctuation'
# * /\p{Pc}/ - 'Punctuation: Connector'
# * /\p{Pd}/ - 'Punctuation: Dash'
# * /\p{Ps}/ - 'Punctuation: Open'
# * /\p{Pe}/ - 'Punctuation: Close'
# * /\p{Pi}/ - 'Punctuation: Initial Quote'
# * /\p{Pf}/ - 'Punctuation: Final Quote'
# * /\p{Po}/ - 'Punctuation: Other'
# * /\p{S}/ - 'Symbol'
# * /\p{Sm}/ - 'Symbol: Math'
# * /\p{Sc}/ - 'Symbol: Currency'
# * /\p{Sc}/ - 'Symbol: Currency'
# * /\p{Sk}/ - 'Symbol: Modifier'
# * /\p{So}/ - 'Symbol: Other'
# * /\p{Z}/ - 'Separator'
# * /\p{Zs}/ - 'Separator: Space'
# * /\p{Zl}/ - 'Separator: Line'
# * /\p{Zp}/ - 'Separator: Paragraph'
# * /\p{C}/ - 'Other'
# * /\p{Cc}/ - 'Other: Control'
# * /\p{Cf}/ - 'Other: Format'
# * /\p{Cn}/ - 'Other: Not Assigned'
# * /\p{Co}/ - 'Other: Private Use'
# * /\p{Cs}/ - 'Other: Surrogate'

# Lastly, \p{} matches a character's Unicode _s_c_r_i_p_t. The following
# scripts are supported: _A_r_a_b_i_c, _A_r_m_e_n_i_a_n,
# _B_a_l_i_n_e_s_e, _B_e_n_g_a_l_i, _B_o_p_o_m_o_f_o,
# _B_r_a_i_l_l_e, _B_u_g_i_n_e_s_e, _B_u_h_i_d,
# _C_a_n_a_d_i_a_n___A_b_o_r_i_g_i_n_a_l, _C_a_r_i_a_n,
# _C_h_a_m, _C_h_e_r_o_k_e_e, _C_o_m_m_o_n,
# _C_o_p_t_i_c, _C_u_n_e_i_f_o_r_m, _C_y_p_r_i_o_t,
# _C_y_r_i_l_l_i_c, _D_e_s_e_r_e_t,
# _D_e_v_a_n_a_g_a_r_i, _E_t_h_i_o_p_i_c,
# _G_e_o_r_g_i_a_n, _G_l_a_g_o_l_i_t_i_c, _G_o_t_h_i_c,
# _G_r_e_e_k, _G_u_j_a_r_a_t_i, _G_u_r_m_u_k_h_i,
# _H_a_n, _H_a_n_g_u_l, _H_a_n_u_n_o_o, _H_e_b_r_e_w,
# _H_i_r_a_g_a_n_a, _I_n_h_e_r_i_t_e_d, _K_a_n_n_a_d_a,
# _K_a_t_a_k_a_n_a, _K_a_y_a_h___L_i,
# _K_h_a_r_o_s_h_t_h_i, _K_h_m_e_r, _L_a_o, _L_a_t_i_n,
# _L_e_p_c_h_a, _L_i_m_b_u, _L_i_n_e_a_r___B,
# _L_y_c_i_a_n, _L_y_d_i_a_n, _M_a_l_a_y_a_l_a_m,
# _M_o_n_g_o_l_i_a_n, _M_y_a_n_m_a_r,
# _N_e_w___T_a_i___L_u_e, _N_k_o, _O_g_h_a_m,
# _O_l___C_h_i_k_i, _O_l_d___I_t_a_l_i_c,
# _O_l_d___P_e_r_s_i_a_n, _O_r_i_y_a, _O_s_m_a_n_y_a,
# _P_h_a_g_s___P_a, _P_h_o_e_n_i_c_i_a_n, _R_e_j_a_n_g,
# _R_u_n_i_c, _S_a_u_r_a_s_h_t_r_a, _S_h_a_v_i_a_n,
# _S_i_n_h_a_l_a, _S_u_n_d_a_n_e_s_e,
# _S_y_l_o_t_i___N_a_g_r_i, _S_y_r_i_a_c,
# _T_a_g_a_l_o_g, _T_a_g_b_a_n_w_a, _T_a_i___L_e,
# _T_a_m_i_l, _T_e_l_u_g_u, _T_h_a_a_n_a, _T_h_a_i,
# _T_i_b_e_t_a_n, _T_i_f_i_n_a_g_h, _U_g_a_r_i_t_i_c,
# _V_a_i, and _Y_i.

# Unicode codepoint U+06E9 is named "ARABIC PLACE OF SAJDAH" and belongs to the
# Arabic script:

#   /\p{Arabic}/.match("\u06E9") #=> #<MatchData "\u06E9">

# All character properties can be inverted by prefixing their name with a caret
# (^).

# Letter 'A' is not in the Unicode Ll (Letter; Lowercase) category, so this
# match succeeds:

#   /\p{^Ll}/.match("A") #=> #<MatchData "A">

# == AAnncchhoorrss

# Anchors are metacharacter that match the zero-width positions between
# characters, _a_n_c_h_o_r_i_n_g the match to a specific position.

# * ^ - Matches beginning of line
# * $ - Matches end of line
# * \A - Matches beginning of string.
# * \Z - Matches end of string. If string ends with a newline, it matches just
#   before newline
# * \z - Matches end of string
# * \G - Matches point where last match finished
# * \b - Matches word boundaries when outside brackets; backspace (0x08) when
#   inside brackets
# * \B - Matches non-word boundaries
# * (?=_p_a_t) - _P_o_s_i_t_i_v_e_ _l_o_o_k_a_h_e_a_d
#   assertion: ensures that the following characters match _p_a_t, but
#   doesn't include those characters in the matched text
# * (?!_p_a_t) - _N_e_g_a_t_i_v_e_ _l_o_o_k_a_h_e_a_d
#   assertion: ensures that the following characters do not match _p_a_t, but
#   doesn't include those characters in the matched text
# * (?<=_p_a_t) - _P_o_s_i_t_i_v_e_ _l_o_o_k_b_e_h_i_n_d
#   assertion: ensures that the preceding characters match _p_a_t, but
#   doesn't include those characters in the matched text
# * (?<!_p_a_t) - _N_e_g_a_t_i_v_e_ _l_o_o_k_b_e_h_i_n_d
#   assertion: ensures that the preceding characters do not match _p_a_t, but
#   doesn't include those characters in the matched text

# If a pattern isn't anchored it can begin at any point in the string:

#   /real/.match("surrealist") #=> #<MatchData "real">

# Anchoring the pattern to the beginning of the string forces the match to start
# there. 'real' doesn't occur at the beginning of the string, so now the match
# fails:

#   /\Areal/.match("surrealist") #=> nil

# The match below fails because although 'Demand' contains 'and', the pattern
# does not occur at a word boundary.

#   /\band/.match("Demand")

# Whereas in the following example 'and' has been anchored to a non-word
# boundary so instead of matching the first 'and' it matches from the fourth
# letter of 'demand' instead:

#   /\Band.+/.match("Supply and demand curve") #=> #<MatchData "and curve">

# The pattern below uses positive lookahead and positive lookbehind to match
# text appearing in  tags without including the tags in the match:

#   /(?<=<b>)\w+(?=<\/b>)/.match("Fortune favours the <b>bold</b>")
#       #=> #<MatchData "bold">

# == OOppttiioonnss

# The end delimiter for a regexp can be followed by one or more single-letter
# options which control how the pattern can match.

# * /pat/i - Ignore case
# * /pat/m - Treat a newline as a character matched by .
# * /pat/x - Ignore whitespace and comments in the pattern
# * /pat/o - Perform #{} interpolation only once

# i, m, and x can also be applied on the subexpression level with the
# (?_o_n-_o_f_f) construct, which enables options _o_n, and disables
# options _o_f_f for the expression enclosed by the parentheses.

#   /a(?i:b)c/.match('aBc') #=> #<MatchData "aBc">
#   /a(?i:b)c/.match('abc') #=> #<MatchData "abc">

# Options may also be used with Regexp.new:

#   Regexp.new("abc", Regexp::IGNORECASE)                     #=> /abc/i
#   Regexp.new("abc", Regexp::MULTILINE)                      #=> /abc/m
#   Regexp.new("abc # Comment", Regexp::EXTENDED)             #=> /abc # Comment/x
#   Regexp.new("abc", Regexp::IGNORECASE | Regexp::MULTILINE) #=> /abc/mi

# == FFrreeee--SSppaacciinngg  MMooddee  aanndd  CCoommmmeennttss

# As mentioned above, the x option enables _f_r_e_e_-_s_p_a_c_i_n_g
# mode. Literal white space inside the pattern is ignored, and the octothorpe
# (#) character introduces a comment until the end of the line. This allows the
# components of the pattern to be organised in a potentially more readable
# fashion.

# A contrived pattern to match a number with optional decimal places:

#   float_pat = /\A
#       [[:digit:]]+ # 1 or more digits before the decimal point
#       (\.          # Decimal point
#           [[:digit:]]+ # 1 or more digits after the decimal point
#       )? # The decimal point and following digits are optional
#   \Z/x
#   float_pat.match('3.14') #=> #<MatchData "3.14" 1:".14">

# NNoottee: To match whitespace in an x pattern use an escape such as \s or
# \p{Space}.

# Comments can be included in a non-x pattern with the (?#_c_o_m_m_e_n_t)
# construct, where _c_o_m_m_e_n_t is arbitrary text ignored by the regexp
# engine.

# == EEnnccooddiinngg

# Regular expressions are assumed to use the source encoding. This can be
# overridden with one of the following modifiers.

# * /_p_a_t/u - UTF-8
# * /_p_a_t/e - EUC-JP
# * /_p_a_t/s - Windows-31J
# * /_p_a_t/n - ASCII-8BIT

# A regexp can be matched against a string when they either share an encoding,
# or the regexp's encoding is _U_S_-_A_S_C_I_I and the string's encoding
# is ASCII-compatible.

# If a match between incompatible encodings is attempted an
# Encoding::CompatibilityError exception is raised.

# The Regexp#fixed_encoding? predicate indicates whether the regexp has a
# _f_i_x_e_d encoding, that is one incompatible with ASCII. A regexp's
# encoding can be explicitly fixed by supplying Regexp::FIXEDENCODING as the
# second argument of Regexp.new:

#   r = Regexp.new("a".force_encoding("iso-8859-1"),Regexp::FIXEDENCODING)
#   r =~"a\u3042"
#      #=> Encoding::CompatibilityError: incompatible encoding regexp match
#           (ISO-8859-1 regexp with UTF-8 string)

# == SSppeecciiaall  gglloobbaall  vvaarriiaabblleess

# Pattern matching sets some global variables :
# * $~ is equivalent to Regexp.last_match;
# * $& contains the complete matched text;
# * $` contains string before match;
# * $' contains string after match;
# * $1, $2 and so on contain text matching first, second, etc capture group;
# * $+ contains last capture group.

# Example:

#   m = /s(\w{2}).*(c)/.match('haystack') #=> #<MatchData "stac" 1:"ta" 2:"c">
#   $~                                    #=> #<MatchData "stac" 1:"ta" 2:"c">
#   Regexp.last_match                     #=> #<MatchData "stac" 1:"ta" 2:"c">

#   $&      #=> "stac"
#           # same as m[0]
#   $`      #=> "hay"
#           # same as m.pre_match
#   $'      #=> "k"
#           # same as m.post_match
#   $1      #=> "ta"
#           # same as m[1]
#   $2      #=> "c"
#           # same as m[2]
#   $3      #=> nil
#           # no third group in pattern
#   $+      #=> "c"
#           # same as m[-1]

# These global variables are thread-local and method-local variables.

# == PPeerrffoorrmmaannccee

# Certain pathological combinations of constructs can lead to abysmally bad
# performance.

# Consider a string of 25 _as, a _d, 4 _as, and a _c.

#   s = 'a' * 25 + 'd' + 'a' * 4 + 'c'
#   #=> "aaaaaaaaaaaaaaaaaaaaaaaaadaaaac"

# The following patterns match instantly as you would expect:

#   /(b|a)/ =~ s #=> 0
#   /(b|a+)/ =~ s #=> 0
#   /(b|a+)*/ =~ s #=> 0

# However, the following pattern takes appreciably longer:

#   /(b|a+)*c/ =~ s #=> 26

# This happens because an atom in the regexp is quantified by both an immediate
# + and an enclosing * with nothing to differentiate which is in control of any
# particular character. The nondeterminism that results produces super-linear
# performance. (Consult _M_a_s_t_e_r_i_n_g_ _R_e_g_u_l_a_r_
# _E_x_p_r_e_s_s_i_o_n_s (3rd ed.), pp 222, by
# _J_e_f_f_e_r_y_ _F_r_i_e_d_l, for an in-depth analysis). This
# particular case can be fixed by use of atomic grouping, which prevents the
# unnecessary backtracking:

#   (start = Time.now) && /(b|a+)*c/ =~ s && (Time.now - start)
#      #=> 24.702736882
#   (start = Time.now) && /(?>b|a+)*c/ =~ s && (Time.now - start)
#      #=> 0.000166571

# A similar case is typified by the following example, which takes approximately
# 60 seconds to execute for me:

# Match a string of 29 _as against a pattern of 29 optional _as followed by 29
# mandatory _as:

#   Regexp.new('a?' * 29 + 'a' * 29) =~ 'a' * 29

# The 29 optional _as match the string, but this prevents the 29 mandatory _as
# that follow from matching. Ruby must then backtrack repeatedly so as to
# satisfy as many of the optional matches as it can while still matching the
# mandatory 29. It is plain to us that none of the optional matches can succeed,
# but this fact unfortunately eludes Ruby.

# The best way to improve performance is to significantly reduce the amount of
# backtracking needed.  For this case, instead of individually matching 29
# optional _as, a range of optional _as can be matched all at once with
# _a_{_0_,_2_9_}:

#   Regexp.new('a{0,29}' + 'a' * 29) =~ 'a' * 29
# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::

# EXTENDED:
#   see Regexp.options and Regexp.new


# FIXEDENCODING:
#   see Regexp.options and Regexp.new


# IGNORECASE:
#   see Regexp.options and Regexp.new


# MULTILINE:
#   see Regexp.options and Regexp.new


# NOENCODING:
#   see Regexp.options and Regexp.new



# = CCllaassss  mmeetthhooddss::

#   compile
#   escape
#   json_create
#   last_match
#   new
#   quote
#   try_convert
#   union

# = IInnssttaannccee  mmeetthhooddss::

#   ==
#   ===
#   =~
#   as_json
#   casefold?
#   encoding
#   eql?
#   fixed_encoding?
#   hash
#   inspect
#   match
#   named_captures
#   names
#   options
#   source
#   to_json
#   to_s
#   ~

# (from gem json-1.8.1)
# ------------------------------------------------------------------------------
# Regexp serialization/deserialization
# ------------------------------------------------------------------------------
# = CCllaassss  mmeetthhooddss::

#   json_create

# = IInnssttaannccee  mmeetthhooddss::

#   as_json
#   to_json

# ------------------------------------------------------------------------------
# Also found in:
#   gem activesupport-4.0.2

