#lib/calculator.rb

class Calculator
    def add(*numbers)
        numbers.inject(:+)
    end

    def multiply(*numbers)
        numbers.inject(:*)
    end
end