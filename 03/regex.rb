require './fa'
require './nfa'

module Pattern
  def bracket(outer_precedence)
    if precedence < outer_precedence
      '(' + to_s + ')'
    else
      to_s
    end
  end

  def inspect
    "/#{salt}"
  end

  def matches?(string)
    to_nfa_design.accepts?(string)
  end

  def to_nfa_design
    fail NotImplementedError
  end

  protected

  def precedence
    fail NotImplementedError
  end
end

class Empty
  include Pattern

  def to_s
    ''
  end

  def to_nfa_design
    start_state = Object.new
    accept_states = [start_state]
    rulebook = NFARuleBook.new([])

    NFADesign.new(start_state, accept_states, rulebook)
  end

  def precedence
    3
  end
end

class Literal < Struct.new(:character)
  include Pattern

  def to_s
    character
  end

  def to_nfa_design
    start_state = Object.new
    accept_state = Object.new
    rule = FARule.new(start_state, character, accept_state)
    rulebook = NFARuleBook.new([rule])

    NFADesign.new(start_state, [accept_state], rulebook)
  end

  def precedence
    3
  end
end

class Concatenate < Struct.new(:first, :second)
  include Pattern

  def to_s
    [first, second].map { |pattern| pattern.bracket(precedence) }.join
  end

  def to_nfa_design
    first_nfa_design = first.to_nfa_design
    second_nfa_design = second.to_nfa_design

    start_state = first_nfa_design.start_state
    accept_states = second_nfa_design.accept_states
    rules = first_nfa_design.rulebook.rules + second_nfa_design.rulebook.rules
    extra_rules = first_nfa_design.accept_states.map { |state|
      FARule.new(state, nil, second_nfa_design.start_state)
    }
    rulebook = NFARuleBook.new(rules + extra_rules)

    NFADesign.new(start_state, accept_states, rulebook)
  end

  def precedence
    1
  end
end

class Choose < Struct.new(:first, :second)
  include Pattern

  def to_s
    [first, second].map { |pattern| pattern.bracket(precedence) }.join('|')
  end

  def to_nfa_design
    first_nfa_design = first.to_nfa_design
    second_nfa_design = second.to_nfa_design

    start_state = Object.new
    accept_states = [first_nfa_design, second_nfa_design].flat_map(&:accept_states)
    rules = [first_nfa_design, second_nfa_design].flat_map { |nfa_design|
      nfa_design.rulebook.rules +
        [FARule.new(start_state, nil, nfa_design.start_state)]
    }

    NFADesign.new(start_state, accept_states, NFARuleBook.new(rules))
  end

  def precedence
    0
  end
end

class Repeat < Struct.new(:pattern)
  include Pattern

  def to_s
    pattern.bracket(precedence) + '*'
  end

  def to_nfa_design
    start_state = Object.new
    accept_state = start_state
    rules = pattern.to_nfa_design.rulebook.rules +
  end

  def precedence
    2
  end
end
