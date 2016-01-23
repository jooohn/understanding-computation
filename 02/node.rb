module Node
  def reducible?
    fail NotImplementedError
  end

  def evaluate(_environment)
    fail NotImplementedError
  end

  def inspect
    "<<#{self}>>"
  end
end

module TerminalNode
  def reducible?
    false
  end
end

module ReducibleNode
  def reducible?
    true
  end

  def reduce(_environment)
    fail NotImplementedError
  end
end

