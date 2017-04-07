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
end
