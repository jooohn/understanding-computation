require './fa'
require './dfa'
require './nfa'
require './regex'

# rules = [
#   FARule.new(1, 'a', 2),
#   FARule.new(1, 'b', 1),
#   FARule.new(2, 'a', 2),
#   FARule.new(2, 'b', 3),
#   FARule.new(3, 'a', 3),
#   FARule.new(3, 'b', 3)
# ]
# rulebook = DFARuleBook.new(rules)
#
# dfa_design = DFADesign.new(1, [3], rulebook)
# puts dfa_design.accepts? 'a'
# puts dfa_design.accepts? 'baa'
# puts dfa_design.accepts? 'baba'
#
# nfa_rules = [
#   FARule.new(1, 'a', 1),
#   FARule.new(1, 'b', 1),
#   FARule.new(1, 'b', 2),
#   FARule.new(2, 'a', 3),
#   FARule.new(2, 'b', 3),
#   FARule.new(3, 'a', 4),
#   FARule.new(3, 'b', 4)
# ]
# nfa_design = NFADesign.new(1, [4], NFARuleBook.new(nfa_rules))
# puts nfa_design.accepts? 'bab'
# puts nfa_design.accepts? 'bbbbbb'
# puts nfa_design.accepts? 'bbabb'

# nfa_rules = [
#   FARule.new(1, nil, 2),
#   FARule.new(1, nil, 4),
#   FARule.new(2, 'a', 3),
#   FARule.new(3, 'a', 2),
#   FARule.new(4, 'a', 5),
#   FARule.new(5, 'a', 6),
#   FARule.new(6, 'a', 4)
# ]
# nfa_rulebook = NFARuleBook.new(nfa_rules)
# nfa_design = NFADesign.new(1, [2, 4], nfa_rulebook)
# puts nfa_design.accepts? 'a' * 2
# puts nfa_design.accepts? 'a' * 3
# puts nfa_design.accepts? 'a' * 5
# puts nfa_design.accepts? 'a' * 6

# pattern =
#   Repeat.new(
#     Choose.new(
#       Concatenate.new(Literal.new('a'), Literal.new('b')),
#       Literal.new('a')
#     )
#   )
# puts pattern

# puts Empty.new.matches? 'aaaaaa'

# pattern = Concatenate.new(
#   Literal.new('a'),
#   Concatenate.new(Literal.new('b'), Literal.new('c'))
# )
# %w(a ab abc abcd).each { |word|
#   puts "#{word} matches #{pattern} = #{pattern.matches?(word)}"
# }

pattern = Choose.new(
  Concatenate.new(Literal.new('a'), Literal.new('b')),
  Concatenate.new(Literal.new('b'), Literal.new('a'))
)
%w(ab abc aa bb ba baa).each { |word|
  puts "#{word} matches #{pattern} = #{pattern.matches?(word)}"
}
