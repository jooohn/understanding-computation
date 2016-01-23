require './node.rb'

module ExpressionNode
  include ReducibleNode
end

class Value < Struct.new(:value)
  include Node
  include TerminalNode

  def to_s
    value.to_s
  end

  def evaluate(environment)
    self
  end
end

class Boolean < Value
end

class Number < Value
end

class Variable < Struct.new(:name)
  include Node
  include ReducibleNode

  def to_s
    name.to_s
  end

  def reduce(environment)
    environment[name]
  end

  def evaluate(environment)
    environment[name]
  end
end

class BinaryExpression < Struct.new(:left, :right)
  include Node
  include ExpressionNode

  def to_s
    "(#{left} #{symbol} #{right})"
  end

  def reduce(environment)
    case
    when left.reducible?
      self.class.new(left.reduce(environment), right)
    when right.reducible?
      self.class.new(left, right.reduce(environment))
    else
      operate(left.value, right.value)
    end
  end

  def evaluate(environment)
    operate(
      left.evaluate(environment).value,
      right.evaluate(environment).value
    )
  end

  def symbol
    fail NotImplementedError
  end

  protected

  def operate(left, right)
    fail NotImplementedError
  end
end

class Add < BinaryExpression
  def symbol
    '+'
  end

  def operate(left, right)
    Number.new(left + right)
  end
end

class Subtraction < BinaryExpression
  def symbol
    '-'
  end

  def operate(left, right)
    Number.new(left - right)
  end
end

class Multiply < BinaryExpression
  def symbol
    '*'
  end

  def operate(left, right)
    Number.new(left * right)
  end
end

class Division < BinaryExpression
  def symbol
    '/'
  end

  def operate(left, right)
    Number.new(left / right)
  end
end

class LessThan < BinaryExpression
  def symbol
    '<'
  end

  def operate(left, right)
    Boolean.new(left < right)
  end
end

