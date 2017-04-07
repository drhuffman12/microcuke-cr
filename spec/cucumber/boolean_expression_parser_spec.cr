require "../spec_helper"

Spec2.describe Cucumber::BooleanExpressionParser do
  let(parser) { Cucumber::BooleanExpressionParser.new }

  describe "#parse" do
    it "a and b" do
      infix = "a and b"
      outfix = "( a and b )"
      expr = parser.parse(infix)

      puts "infix: #{infix}"
      infix_str = "#{infix}"
      outfix_str = "#{outfix}"
      puts "outfix: #{outfix}"
      puts "expr: #{expr.inspect || "(nil)"}"

      expect(expr.to_s).to eq(outfix)
    end
    
    it "( a and b )" do
      infix = "( a and b )"
      outfix = "( a and b )"
      expr = parser.parse(infix)

      puts "infix: #{infix}"
      infix_str = "#{infix}"
      outfix_str = "#{outfix}"
      puts "outfix: #{outfix}"
      puts "expr: #{expr || "(nil)"}"

      expect(expr.to_s).to eq(outfix)
    end
    
    it "a or b" do
      infix = "a or b"
      outfix = "( a or b )"
      expr = parser.parse(infix)

      puts "infix: #{infix}"
      infix_str = "#{infix}"
      outfix_str = "#{outfix}"
      puts "outfix: #{outfix}"
      puts "expr: #{expr || "(nil)"}"

      expect(expr.to_s).to eq(outfix)
    end
    
    it "not a" do
      infix = "not a"
      outfix = "not ( a )"
      expr = parser.parse(infix)

      puts "infix: #{infix}"
      infix_str = "#{infix}"
      outfix_str = "#{outfix}"
      puts "outfix: #{outfix}"
      puts "expr: #{expr || "(nil)"}"

      expect(expr.to_s).to eq(outfix)
    end
    
    it "( a and b ) or ( c and d )" do
      infix = "( a and b ) or ( c and d )"
      outfix = "( ( a and b ) or ( c and d ) )"
      expr = parser.parse(infix)

      puts "infix: #{infix}"
      infix_str = "#{infix}"
      outfix_str = "#{outfix}"
      puts "outfix: #{outfix}"
      puts "expr: #{expr || "(nil)"}"

      expect(expr.to_s).to eq(outfix)
    end
    
    it "not a or b and not c or not d or e and f" do
      infix = "not a or b and not c or not d or e and f"
      outfix = "( ( ( not ( a ) or ( b and not ( c ) ) ) or not ( d ) ) or ( e and f ) )"
      expr = parser.parse(infix)

      puts "infix: #{infix}"
      infix_str = "#{infix}"
      outfix_str = "#{outfix}"
      puts "outfix: #{outfix}"
      puts "expr: #{expr || "(nil)"}"

      expect(expr.to_s).to eq(outfix)
    end
  end

  # describe "#parse" do
  #   [
  #     ["a and b", "( a and b )"],
  #     # ["a or b", "( a or b )"],
  #     # ["not a", "not ( a )"],
  #     # ["( a and b ) or ( c and d )", "( ( a and b ) or ( c and d ) )"],
  #     #@ ["( a and b ) or ( c and d )", "( ( ( a and b ) ) or ( ( c and d ) ) )"],
  #     # ["not a or b and not c or not d or e and f", "( ( ( not ( a ) or ( b and not ( c ) ) ) or not ( d ) ) or ( e and f ) )"]
  #     # a or not b
  #   ].each do |in_out|
  #     # puts "infix: #{infix}"
  #     # puts "outfix: #{outfix}"
  #     puts "in_out: #{in_out}"
  #     @in_out = in_out
  #     # @infix = in_out[0]
  #     # @outfix = in_out[1]
  #     # let(infix) { @in_out[0] }
  #     # let(outfix) { @in_out[1] }
  #     it "a and b" do
  #       # infix = "a and b"
  #       # outfix = "( a and b )"
  #       infix = @in_out[0]
  #       outfix = @in_out[1]
  #       expr = parser.parse(infix)

  #       puts "infix: #{infix}"
  #       infix_str = "#{infix}"
  #       outfix_str = "#{outfix}"
  #       puts "outfix: #{outfix}"
  #       puts "expr: #{expr || "(nil)"}"

  #       expect(expr.to_s).to eq(outfix)
  #     end
  #   end

  #   # it "TODO" do
  #   #   expect(false).to eq(true)
  #   # end
  # end

end
