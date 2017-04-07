module Cucumber
  class BooleanExpression
    # # USAGE:
    # n1 = Cucumber::BooleanExpression.new(op: :literal, elem_prim: "a")
    # n2 = Cucumber::BooleanExpression.new(op: :not, elem_prim: "a")
    # n3 = Cucumber::BooleanExpression.new(op: :and, elem_prim: "a", elem_sec: "b")
    # n4 = Cucumber::BooleanExpression.new(op: :or, elem_prim: "a", elem_sec: "b")
    # n5 = Cucumber::BooleanExpression.new(op: :or, elem_prim: n1, elem_sec: "c")
    # n6 = Cucumber::BooleanExpression.new(op: :and, elem_prim: n2, elem_sec: "d")
    # n7 = Cucumber::BooleanExpression.new(op: :and, elem_prim: n3, elem_sec: n4)
    # n8 = Cucumber::BooleanExpression.new(op: :and, elem_prim: n6, elem_sec: n7)
    # n8 = Cucumber::BooleanExpression.new(op: :parenthesis, elem_prim: n2, elem_sec: n3)
    # [n1,n2,n3,n4,n5,n6,n7].each {|n| # puts n.inspect}
    # [n1,n2,n3,n4,n5,n6,n7].each {|n| # puts n.to_s}

    alias BooleanExpressionElements = (String | Cucumber::BooleanExpression)?

    getter :op, :elem_prim, elem_sec
    @op : Symbol
    @elem_prim : BooleanExpressionElements
    @elem_sec : BooleanExpressionElements

    def initialize(@op : Symbol, @elem_prim : BooleanExpressionElements)
      @elem_sec = nil
    end

    def initialize(@op : Symbol, @elem_prim : BooleanExpressionElements, @elem_sec : BooleanExpressionElements? = nil)
    end

    def evaluate(variables : Array[String])
      case @op
        when :literal
          !!variables.index(@elem_prim)
        when :parenthesis
          @elem_prim.evaluate(variables)
        when :not
          !@elem_prim.evaluate(variables)
        when :and
          @elem_prim.evaluate(variables) && @elem_sec.evaluate(variables)
        when :or
          @elem_prim.evaluate(variables) || @elem_sec.evaluate(variables)
        else
          raise "Unsupported op: '#{@op}'"
      end      
    end

    def to_s
      case @op
        when :literal
          @elem_prim
        when :parenthesis
          "#{@elem_prim.to_s}"
        when :not
          "not ( #{@elem_prim.to_s} )"
        when :and
          "( #{@elem_prim.to_s} and #{@elem_sec.to_s} )"
        when :or
          "( #{@elem_prim.to_s} or #{@elem_sec.to_s} )"
        else
          raise "Unsupported op: '#{@op}'"
      end
    end
  end
end

    