#!/usr/bin/env ruby -w
# gem_cucumber.rb
# Description: Canvas gem cucumber

## 0. Feature banner
# Friends' playlist mashup
#
## 1. Feature usage statement
# As a <role>
# I want <feature>
# So that <value>
#
## 1. Collect user stories (one-liner)
# <role> <action>
# Code-breaker starts game
# Code-breaker submits guess
# Code-breaker wins game
# Code-breaker loses game
# Code-breaker plays again
# Code-breaker requests hint
# Code-breaker saves score
#
## 2. Token conversations per user story (index card)
# Code-breaker starts game
#  The code-breaker opens a shell,
#  types a command,
#  and sees a welcome message
#  and a prompt to enter the first guess.
# Code-breaker submits guess
#  The code-breaker enters a guess,
#  and the system replies
#  by marking the guess according to the marking algorithm.
# Code-breaker wins game
#  The code-breaker enters a guess that matches the secret code exactly.
#  The system responsd by marking the guess with four + signs
#  and a message conngratulating the code-breaker on breaking the code
#  including however many guesses it took.
# Code-breaker loses game
#  After some number of turns,
#  the game tells the code-breaker that the game is over
#  (need to decide how many turns and whether to reveal the code).
# Code-breaker plays again
#  After the game is won or lost,
#  the system prompts the code-breaker to play again.
#  If the code-breaker indiactes yes, a new game begins.
#  If the code-breaker indicitaes no, the system shuts down.
# Code-breaker requests hint
#  At any time during a game,
#  the code-breaker can request a hint,
#  at which point the system reveal one of the numbers in the secret code.
# Code-breaker saves score
#  After the game is won or lost,
#  the code-breaker can opt to save information about the game:
#  who (indicates?).
#  how many turns, and so on.
#
## 3. Narrow to the CORE user stories (37Signals)
# NOTE it depends on the context of the stakeholders
# Code-breaker starts a game
# Code-breaker submits guess
