# canvas_regex.rb
# Author: Andy Bettisworth
# Description: Canvas Regexp for dynamic parsing using patterns

## READ all non-alphanumeric characters
# validate_me = 'This is & - some thoughts / that are.'
# puts 'original: ' + validate_me
# validate_me.gsub!(/[^[:alnum:]]/,'-')
# puts 'Best method: '+ validate_me.gsub(/\W/,'_')
# puts 'updated: '+ validate_me.gsub(/\W/,'_')

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
# Regexp.new= RReeggeexxpp  <<  OObbjjeecctt

# (from ruby core)
# ------------------------------------------------------------------------------
# Regexp serialization/deserialization

# A Regexp holds a regular expression, used to match a pattern against strings.
# Regexps are created using the /.../ and %r{...} literals, and by the
# Regexp::new constructor.

# Regular expressions (_r_e_g_e_x_ps) are patterns which describe the
# contents of a string. They're used for testing whether a string contains a
# given pattern, or extracting the portions that match. They are created with
# the /_p_a_t/ and %r{_p_a_t} literals or the Regexp.new constructor.

# A regexp is usually delimited with forward slashes (/). For example:

#   /hay/ =~ 'haystack'   #=> 0
#   /y/.match('haystack') #=> #<MatchData "y">

# If a string contains the pattern it is said to _m_a_t_c_h. A literal
# string matches itself.

# Here 'haystack' does not contain the pattern 'needle', so it doesn't match:

#   /needle/.match('haystack') #=> nil

# Here 'haystack' contains the pattern 'hay', so it matches:

#   /hay/.match('haystack')    #=> #<MatchData "hay">

# Specifically, /st/ requires that the string contains the letter _s followed
# by the letter _t, so it matches _h_a_y_s_t_a_c_k, also.

# == ==~~  aanndd  RReeggeexxpp##mmaattcchh

# Pattern matching may be achieved by using =~ operator or Regexp#match method.

# === ==~~  ooppeerraattoorr

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

# === RReeggeexxpp##mmaattcchh  mmeetthhoodd

# The #match method returns a MatchData object:

#   /st/.match('haystack')   #=> #<MatchData "st">

# == MMeettaacchhaarraacctteerrss  aanndd  EEssccaappeess

# The following are _m_e_t_a_c_h_a_r_a_c_t_e_r_s (, ), [, ], {, },
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

# == CChhaarraacctteerr  CCllaasssseess

# A _c_h_a_r_a_c_t_e_r_ _c_l_a_s_s is delimited with square
# brackets ([, ]) and lists characters that may appear at that point in the
# match. /[ab]/ means _a or _b, as opposed to /ab/ which means _a followed by
# _b.

#   /W[aeiou]rd/.match("Word") #=> #<MatchData "Word">

# Within a character class the hyphen (-) is a metacharacter denoting an
# inclusive range of characters. [abcd] is equivalent to [a-d]. A range can be
# followed by another range, so [abcdwxyz] is equivalent to [a-dw-z]. The order
# in which ranges or individual characters appear inside a character class is
# irrelevant.

#   /[0-9a-f]/.match('9f') #=> #<MatchData "9">
#   /[9f]/.match('9f')     #=> #<MatchData "9">

# If the first character of a character class is a caret (^) the class is
# inverted: it matches any character _e_x_c_e_p_t those named.

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

# POSIX _b_r_a_c_k_e_t_ _e_x_p_r_e_s_s_i_o_n_s are also
# similar to character classes. They provide a portable alternative to the
# above, with the added benefit that they encompass non-ASCII characters. For
# instance, /\d/ matches only the ASCII decimal digits (0-9); whereas
# /[[:digit:]]/ matches any character in the Unicode _N_d category.

# * /[[:alnum:]]/ - Alphabetic and numeric character
# * /[[:alpha:]]/ - Alphabetic character
# * /[[:blank:]]/ - Space or tab
# * /[[:cntrl:]]/ - Control character
# * /[[:digit:]]/ - Digit
# * /[[:graph:]]/ - Non-blank character (excludes spaces, control characters,
#   and similar)
# * /[[:graph:]]/ - Non-blank character (excludes spaces, control characters
# * /[[:lower:]]/ - Lowercase alphabetical character
# * /[[:print:]]/ - Like [:graph:], but includes the space character
# * /[[:punct:]]/ - Punctuation character
# * /[[:space:]]/ - Whitespace character ([:blank:], newline, carriage return,
#   etc.)
# * /[[:upper:]]/ - Uppercase alphabetical
# * /[[:xdigit:]]/ - Digit allowed in a hexadecimal number (i.e., 0-9a-fA-F)

# Ruby also supports the following non-POSIX character classes:

# * /[[:word:]]/ - A character in one of the following Unicode general
#   categories _L_e_t_t_e_r, _M_a_r_k, _N_u_m_b_e_r,
#   _C_o_n_n_e_c_t_o_r___P_u_n_c_t_u_a_t_i_o_n
# * /[[:ascii:]]/ - A character in the ASCII character set

#     # U+06F2 is "EXTENDED ARABIC-INDIC DIGIT TWO"
#     /[[:digit:]]/.match("\u06F2")    #=> #<MatchData "\u{06F2}">
#     /[[:upper:]][[:lower:]]/.match("Hello") #=> #<MatchData "He">
#     /[[:xdigit:]][[:xdigit:]]/.match("A6")  #=> #<MatchData "A6">

# == RReeppeettiittiioonn

# The constructs described so far match a single character. They can be followed
# by a repetition metacharacter to specify how many times they need to occur.
# Such metacharacters are called _q_u_a_n_t_i_f_i_e_r_s.

# * * - Zero or more times
# * + - One or more times
# * ? - Zero or one times (optional)
# * {_n} - Exactly _n times
# * {_n,} - _n or more times
# * {,_m} - _m or less times
# * {_n,_m} - At least _n and at most _m times

# At least one uppercase character ('H'), at least one lowercase character
# ('e'), two 'l' characters, then one 'o':

#   "Hello".match(/[[:upper:]]+[[:lower:]]+l{2}o/) #=> #<MatchData "Hello">

# Repetition is _g_r_e_e_d_y by default: as many occurrences as possible
# are matched while still allowing the overall match to succeed. By contrast,
# _l_a_z_y matching makes the minimal amount of matches necessary for
# overall success. A greedy metacharacter can be made lazy by following it with
# ?.

# Both patterns below match the string. The first uses a greedy quantifier so
# '.+' matches '<a><b>'; the second uses a lazy quantifier so '.+?' matches
# '<a>':

#   /<.+>/.match("<a><b>")  #=> #<MatchData "<a><b>">
#   /<.+?>/.match("<a><b>") #=> #<MatchData "<a>">

# A quantifier followed by + matches _p_o_s_s_e_s_s_i_v_e_l_y: once
# it has matched it does not backtrack. They behave like greedy quantifiers, but
# having matched they refuse to "give up" their match even if this jeopardises
# the overall match.

# == CCaappttuurriinngg

# Parentheses can be used for _c_a_p_t_u_r_i_n_g. The text enclosed by
# the _n<sup>th</sup> group of parentheses can be subsequently referred to with
# _n. Within a pattern use the _b_a_c_k_r_e_f_e_r_e_n_c_e \n;
# outside of the pattern use MatchData[_n].

# 'at' is captured by the first group of parentheses, then referred to later
# with \1:

#   /[csh](..) [csh]\1 in/.match("The cat sat in the hat")
#       #=> #<MatchData "cat sat in" 1:"at">

# Regexp#match returns a MatchData object which makes the captured text
# available with its #[] method:

#   /[csh](..) [csh]\1 in/.match("The cat sat in the hat")[1] #=> 'at'

# Capture groups can be referred to by name when defined with the
# (?<_n_a_m_e>) or (?'_n_a_m_e') constructs.

#   /\$(?<dollars>\d+)\.(?<cents>\d+)/.match("$3.67")
#       => #<MatchData "$3.67" dollars:"3" cents:"67">
#   /\$(?<dollars>\d+)\.(?<cents>\d+)/.match("$3.67")[:dollars] #=> "3"

# Named groups can be backreferenced with \k<_n_a_m_e>, where _n_a_m_e
# is the group name.

#   /(?<vowel>[aeiou]).\k<vowel>.\k<vowel>/.match('ototomy')
#       #=> #<MatchData "ototo" vowel:"o">

# NNoottee: A regexp can't use named backreferences and numbered
# backreferences simultaneously.

# When named capture groups are used with a literal regexp on the left-hand side
# of an expression and the =~ operator, the captured text is also assigned to
# local variables with corresponding names.

#   /\$(?<dollars>\d+)\.(?<cents>\d+)/ =~ "$3.67" #=> 0
#   dollars #=> "3"

# == GGrroouuppiinngg

# Parentheses also _g_r_o_u_p the terms they enclose, allowing them to be
# quantified as one _a_t_o_m_i_c whole.

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

# === AAttoommiicc  GGrroouuppiinngg

# Grouping can be made _a_t_o_m_i_c with (?>_p_a_t). This causes the
# subexpression _p_a_t to be matched independently of the rest of the
# expression such that what it matches becomes fixed for the remainder of the
# match, unless the entire subexpression must be abandoned and subsequently
# revisited. In this way _p_a_t is treated as a non-divisible whole. Atomic
# grouping is typically used to optimise patterns so as to prevent the regular
# expression engine from backtracking needlessly.

# The " in the pattern below matches the first character of the string, then .*
# matches _Q_u_o_t_e_". This causes the overall match to fail, so the text
# matched by .* is backtracked by one position, which leaves the final character
# of the string available to match "

#   /".*"/.match('"Quote"')     #=> #<MatchData "\"Quote\"">

# If .* is grouped atomically, it refuses to backtrack _Q_u_o_t_e_", even
# though this means that the overall match fails

#   /"(?>.*)"/.match('"Quote"') #=> nil

# == SSuubbeexxpprreessssiioonn  CCaallllss

# The \g<_n_a_m_e> syntax matches the previous subexpression named
# _n_a_m_e, which can be a group name or number, again. This differs from
# backreferences in that it re-executes the group rather than simply trying to
# re-match the same text.

# This pattern matches a _( character and assigns it to the paren group, tries
# to call that the paren sub-expression again but fails, then matches a literal
# _):

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
# 3. Matches a literal _(, the first character in the string
# 4. Calls the paren group again, i.e. recurses back to the second step
# 5. Re-enters the paren group
# 6. Matches a literal _(, the second character in the string
# 7. Try to call paren a third time, but fail because doing so would prevent an
#    overall successful match
# 8. Match a literal _), the third character in the string. Marks the end of
#    the second recursive call
# 9. Match a literal _), the fourth character in the string
# 10. Match the end of the string

# == AAlltteerrnnaattiioonn

# The vertical bar metacharacter (|) combines two expressions into a single one
# that matches either of the expressions. Each expression is an
# _a_l_t_e_r_n_a_t_i_v_e.

#   /\w(and|or)\w/.match("Feliformia") #=> #<MatchData "form" 1:"or">
#   /\w(and|or)\w/.match("furandi")    #=> #<MatchData "randi" 1:"and">
#   /\w(and|or)\w/.match("dissemblance") #=> nil

# == CChhaarraacctteerr  PPrrooppeerrttiieess

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
#   _L_e_t_t_e_r, _M_a_r_k, _N_u_m_b_e_r,
#   _C_o_n_n_e_c_t_o_r___P_u_n_c_t_u_a_t_i_o_n
# * /\p{ASCII}/ - A character in the ASCII character set
# * /\p{Any}/ - Any Unicode character (including unassigned characters)
# * /\p{Assigned}/ - An assigned character

# A Unicode character's _G_e_n_e_r_a_l_ _C_a_t_e_g_o_r_y value
# can also be matched with \p{_A_b} where _A_b is the category's
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

# Lastly, \p{} matches a character's Unicode _s_c_r_i_p_t. The following
# scripts are supported: _A_r_a_b_i_c, _A_r_m_e_n_i_a_n,
# _B_a_l_i_n_e_s_e, _B_e_n_g_a_l_i, _B_o_p_o_m_o_f_o,
# _B_r_a_i_l_l_e, _B_u_g_i_n_e_s_e, _B_u_h_i_d,
# _C_a_n_a_d_i_a_n___A_b_o_r_i_g_i_n_a_l, _C_a_r_i_a_n,
# _C_h_a_m, _C_h_e_r_o_k_e_e, _C_o_m_m_o_n,
# _C_o_p_t_i_c, _C_u_n_e_i_f_o_r_m, _C_y_p_r_i_o_t,
# _C_y_r_i_l_l_i_c, _D_e_s_e_r_e_t,
# _D_e_v_a_n_a_g_a_r_i, _E_t_h_i_o_p_i_c,
# _G_e_o_r_g_i_a_n, _G_l_a_g_o_l_i_t_i_c, _G_o_t_h_i_c,
# _G_r_e_e_k, _G_u_j_a_r_a_t_i, _G_u_r_m_u_k_h_i,
# _H_a_n, _H_a_n_g_u_l, _H_a_n_u_n_o_o, _H_e_b_r_e_w,
# _H_i_r_a_g_a_n_a, _I_n_h_e_r_i_t_e_d, _K_a_n_n_a_d_a,
# _K_a_t_a_k_a_n_a, _K_a_y_a_h___L_i,
# _K_h_a_r_o_s_h_t_h_i, _K_h_m_e_r, _L_a_o, _L_a_t_i_n,
# _L_e_p_c_h_a, _L_i_m_b_u, _L_i_n_e_a_r___B,
# _L_y_c_i_a_n, _L_y_d_i_a_n, _M_a_l_a_y_a_l_a_m,
# _M_o_n_g_o_l_i_a_n, _M_y_a_n_m_a_r,
# _N_e_w___T_a_i___L_u_e, _N_k_o, _O_g_h_a_m,
# _O_l___C_h_i_k_i, _O_l_d___I_t_a_l_i_c,
# _O_l_d___P_e_r_s_i_a_n, _O_r_i_y_a, _O_s_m_a_n_y_a,
# _P_h_a_g_s___P_a, _P_h_o_e_n_i_c_i_a_n, _R_e_j_a_n_g,
# _R_u_n_i_c, _S_a_u_r_a_s_h_t_r_a, _S_h_a_v_i_a_n,
# _S_i_n_h_a_l_a, _S_u_n_d_a_n_e_s_e,
# _S_y_l_o_t_i___N_a_g_r_i, _S_y_r_i_a_c,
# _T_a_g_a_l_o_g, _T_a_g_b_a_n_w_a, _T_a_i___L_e,
# _T_a_m_i_l, _T_e_l_u_g_u, _T_h_a_a_n_a, _T_h_a_i,
# _T_i_b_e_t_a_n, _T_i_f_i_n_a_g_h, _U_g_a_r_i_t_i_c,
# _V_a_i, and _Y_i.

# Unicode codepoint U+06E9 is named "ARABIC PLACE OF SAJDAH" and belongs to the
# Arabic script:

#   /\p{Arabic}/.match("\u06E9") #=> #<MatchData "\u06E9">

# All character properties can be inverted by prefixing their name with a caret
# (^).

# Letter 'A' is not in the Unicode Ll (Letter; Lowercase) category, so this
# match succeeds:

#   /\p{^Ll}/.match("A") #=> #<MatchData "A">

# == AAnncchhoorrss

# Anchors are metacharacter that match the zero-width positions between
# characters, _a_n_c_h_o_r_i_n_g the match to a specific position.

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
# * (?=_p_a_t) - _P_o_s_i_t_i_v_e_ _l_o_o_k_a_h_e_a_d
#   assertion: ensures that the following characters match _p_a_t, but
#   doesn't include those characters in the matched text
# * (?!_p_a_t) - _N_e_g_a_t_i_v_e_ _l_o_o_k_a_h_e_a_d
#   assertion: ensures that the following characters do not match _p_a_t, but
#   doesn't include those characters in the matched text
# * (?<=_p_a_t) - _P_o_s_i_t_i_v_e_ _l_o_o_k_b_e_h_i_n_d
#   assertion: ensures that the preceding characters match _p_a_t, but
#   doesn't include those characters in the matched text
# * (?<!_p_a_t) - _N_e_g_a_t_i_v_e_ _l_o_o_k_b_e_h_i_n_d
#   assertion: ensures that the preceding characters do not match _p_a_t, but
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

# == OOppttiioonnss

# The end delimiter for a regexp can be followed by one or more single-letter
# options which control how the pattern can match.

# * /pat/i - Ignore case
# * /pat/m - Treat a newline as a character matched by .
# * /pat/x - Ignore whitespace and comments in the pattern
# * /pat/o - Perform #{} interpolation only once

# i, m, and x can also be applied on the subexpression level with the
# (?_o_n-_o_f_f) construct, which enables options _o_n, and disables
# options _o_f_f for the expression enclosed by the parentheses.

#   /a(?i:b)c/.match('aBc') #=> #<MatchData "aBc">
#   /a(?i:b)c/.match('abc') #=> #<MatchData "abc">

# Options may also be used with Regexp.new:

#   Regexp.new("abc", Regexp::IGNORECASE)                     #=> /abc/i
#   Regexp.new("abc", Regexp::MULTILINE)                      #=> /abc/m
#   Regexp.new("abc # Comment", Regexp::EXTENDED)             #=> /abc # Comment/x
#   Regexp.new("abc", Regexp::IGNORECASE | Regexp::MULTILINE) #=> /abc/mi

# == FFrreeee--SSppaacciinngg  MMooddee  aanndd  CCoommmmeennttss

# As mentioned above, the x option enables _f_r_e_e_-_s_p_a_c_i_n_g
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

# NNoottee: To match whitespace in an x pattern use an escape such as \s or
# \p{Space}.

# Comments can be included in a non-x pattern with the (?#_c_o_m_m_e_n_t)
# construct, where _c_o_m_m_e_n_t is arbitrary text ignored by the regexp
# engine.

# == EEnnccooddiinngg

# Regular expressions are assumed to use the source encoding. This can be
# overridden with one of the following modifiers.

# * /_p_a_t/u - UTF-8
# * /_p_a_t/e - EUC-JP
# * /_p_a_t/s - Windows-31J
# * /_p_a_t/n - ASCII-8BIT

# A regexp can be matched against a string when they either share an encoding,
# or the regexp's encoding is _U_S_-_A_S_C_I_I and the string's encoding
# is ASCII-compatible.

# If a match between incompatible encodings is attempted an
# Encoding::CompatibilityError exception is raised.

# The Regexp#fixed_encoding? predicate indicates whether the regexp has a
# _f_i_x_e_d encoding, that is one incompatible with ASCII. A regexp's
# encoding can be explicitly fixed by supplying Regexp::FIXEDENCODING as the
# second argument of Regexp.new:

#   r = Regexp.new("a".force_encoding("iso-8859-1"),Regexp::FIXEDENCODING)
#   r =~"a\u3042"
#      #=> Encoding::CompatibilityError: incompatible encoding regexp match
#           (ISO-8859-1 regexp with UTF-8 string)

# == SSppeecciiaall  gglloobbaall  vvaarriiaabblleess

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

# == PPeerrffoorrmmaannccee

# Certain pathological combinations of constructs can lead to abysmally bad
# performance.

# Consider a string of 25 _as, a _d, 4 _as, and a _c.

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
# performance. (Consult _M_a_s_t_e_r_i_n_g_ _R_e_g_u_l_a_r_
# _E_x_p_r_e_s_s_i_o_n_s (3rd ed.), pp 222, by
# _J_e_f_f_e_r_y_ _F_r_i_e_d_l, for an in-depth analysis). This
# particular case can be fixed by use of atomic grouping, which prevents the
# unnecessary backtracking:

#   (start = Time.now) && /(b|a+)*c/ =~ s && (Time.now - start)
#      #=> 24.702736882
#   (start = Time.now) && /(?>b|a+)*c/ =~ s && (Time.now - start)
#      #=> 0.000166571

# A similar case is typified by the following example, which takes approximately
# 60 seconds to execute for me:

# Match a string of 29 _as against a pattern of 29 optional _as followed by 29
# mandatory _as:

#   Regexp.new('a?' * 29 + 'a' * 29) =~ 'a' * 29

# The 29 optional _as match the string, but this prevents the 29 mandatory _as
# that follow from matching. Ruby must then backtrack repeatedly so as to
# satisfy as many of the optional matches as it can while still matching the
# mandatory 29. It is plain to us that none of the optional matches can succeed,
# but this fact unfortunately eludes Ruby.

# The best way to improve performance is to significantly reduce the amount of
# backtracking needed.  For this case, instead of individually matching 29
# optional _as, a range of optional _as can be matched all at once with
# _a_{_0_,_2_9_}:

#   Regexp.new('a{0,29}' + 'a' * 29) =~ 'a' * 29
# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::

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

# = CCllaassss  mmeetthhooddss::
#   compile
#   escape
#   json_create
#   last_match
#   new
#   quote
#   try_convert
#   union

# = IInnssttaannccee  mmeetthhooddss::
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
# = CCllaassss  mmeetthhooddss::

#   json_create
# = IInnssttaannccee  mmeetthhooddss::
#   as_json
#   to_json

# ------------------------------------------------------------------------------
# Also found in:
#   gem activesupport-4.0.2

