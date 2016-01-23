require './expression'
require './statement'

class Machine
  def run(statement, environment)
    step(statement, environment)
  end

  def step(statement, environment)
    puts "#{statement}, #{environment}"
    if statement.reducible?
      new_statement, new_environment = statement.reduce(environment)
      step(new_statement, new_environment)
    end
  end
end

# statement = Assign.new(:x, Add.new(Variable.new(:x), Number.new(1)))
# environment = { x: Number.new(10) }

# statement = If.new(
#   Variable.new(:x),
#   Assign.new(:y, Number.new(1)),
#   Assign.new(:y, Number.new(2))
# )
# environment = { x: Boolean.new(true) }

# statement = Sequence.new(
#   Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
#   Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))
# )
# environment = {}

# statement = While.new(
#   LessThan.new(Variable.new(:x), Number.new(5)),
#   Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
# )
# environment = { x: Number.new(1) }
#

# Machine.new.run statement, environment

statement =
  While.new(
    LessThan.new(Variable.new(:x), Number.new(5)),
    Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
  )
puts statement.evaluate x: Number.new(1)
