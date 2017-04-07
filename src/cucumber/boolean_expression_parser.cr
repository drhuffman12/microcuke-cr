# require "boolean_expression"

module Cucumber
  class BooleanExpressionParser
    # # USAGE:

    # require "./src/cucumber"
    # parser = Cucumber::BooleanExpressionParser.new
    # parsed = parser.parse("a and b")

    # Parses infix boolean expression (using Dijkstra's Shunting Yard algorithm)
    # and builds a tree of expressions. The root node of the expression is returned.
    #
    # This expression can be evaluated by passing in an array of literals that resolve to true
    #

    alias Stack = Array(Cucumber::BooleanExpression?)
    alias Operation = Symbol | String

    getter :infix, :expression_stack, :operations
    @expression_stack : Array(Cucumber::BooleanExpression?)
    @operations : Array(Operation?)
    @tokens : Array(String?)
    @infix : String

    ASSOC = {"or" => "left", "and" => "left", "not" => "right"}

    PREC = {"(" => -2, ")" => -1, "or" => 0, "and" => 1, "not" => 2}

    def initialize()
      @expression_stack = [] of Cucumber::BooleanExpression?
      @operations = [] of Operation?
      @tokens = [] of String?
      @infix = ""
    end

    def reset
      @expression_stack = [] of Cucumber::BooleanExpression?
      @operations = [] of Operation?
      @tokens = [] of String?
      @infix = ""
    end

    def parse(infix : String)
      reset
      @infix = infix
      infix_to_tokens
      @tokens.each.with_index do |token, index|
        if is_op(token)
          while (!@operations.empty? && is_op(peek) && (
            (ASSOC[token] == "left" && PREC[token] <= PREC[peek]) ||
            (ASSOC[token] == "right" && PREC[token] < PREC[peek])
          ))
            push_expr(pop(@operations))
          end
          @operations << token
        else
          case token
            when "("
              @operations << token
            when ")"
              while (@operations.size > 0 && @operations.first == "(")
                puts ".. while (@operations.size > 0 && peek != \"(\")"
                push_expr(pop(@operations))
              end
            else
              push_expr(token)
          end
        end
      end

      while (!@operations.empty?)
        raise "Unclosed (" if (peek == "(")
        push_expr(pop(@operations))
      end

      expr = pop(@expression_stack)
      raise "@expression_stack Not empty" if !@expression_stack.empty?

      expr
    end

    def infix_to_tokens
      @infix.gsub(/\(/, " ( ").gsub(/\)/, " ) ").strip().split(/\s+/)do |t|
        @tokens << t
      end
    end

    def is_op(token)
      ASSOC.has_key?(token)
    end

    def peek
      @operations.first
    end

    def pop(arr : Array(Operation? | Cucumber::BooleanExpression?))
      raise "empty stack" if !arr || arr.empty?
      arr.pop
    end

    def push_expr(token : (String | Symbol)?) : Stack?
      return if token.nil?

      case token.to_s
        when "("
          @expression_stack << Cucumber::BooleanExpression.new(op: :parenthesis, elem_prim: pop(@expression_stack))
        when ")"
        when "and"
            right_and_expr = pop(@expression_stack)
            @expression_stack << Cucumber::BooleanExpression.new(op: :and, elem_prim: pop(@expression_stack), elem_sec: right_and_expr)
        when "or"
            right_or_expr = pop(@expression_stack)
            @expression_stack << Cucumber::BooleanExpression.new(op: :or, elem_prim: pop(@expression_stack), elem_sec: right_or_expr)
        when "not"
            @expression_stack << Cucumber::BooleanExpression.new(op: :not, elem_prim: pop(@expression_stack))
        else
          @expression_stack << Cucumber::BooleanExpression.new(op: :literal, elem_prim: token.to_s)
      end
      @expression_stack
    end
  end
end
