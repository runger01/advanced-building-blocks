module Enumerable
    def my_each
        i = 0
        while i < self.size
            yield(self.to_a[i])
            i += 1
        end
        self
    end

    def my_each_with_index
        i = 0
        while i < self.size
            yield(self.to_a[i], i)
            i += 1
        end
        self
    end

    def my_select
        result = []
        self.my_each {|value| result << value if yield(value)}
        result
    end

    def my_all?
        result = true
        if block_given?
            self.my_select {|value| result = false if !yield(value)}
        else
            block = Proc.new {|obj| obj}
            self.my_select {|value| result = false if !block.call(value)}
        end
        result
    end

    def my_any?
        result = false
        if block_given?
            self.my_select {|value| result = true if yield(value)}
        else
            block = Proc.new {|obj| obj}
            self.my_select {|value| result = true if block.call(value)}
        end
        result
    end

    def my_none?
        result = true
        if block_given?
            self.my_select {|value| result = false if yield(value)}
        else
            block = Proc.new {|obj| obj}
            self.my_select {|value| result = false if block.call(value)}
        end
        result
    end

    def my_count(input = nil)
        count = 0
        if block_given?
            self.my_select {|value| count += 1 if yield(value)}
        else
            self.my_select {|value| count += 1 if value == input}
        end
        count
    end

    def my_map
        result = []
        if block_given?
            self.my_each {|value| result << yield(value)}
        else
            return enum_for(:map)
        end
        result
    end

    def my_inject(memo = nil)
        memo = memo ? memo : 0
        self.my_each {|value| memo = yield(memo, value)}
        memo
    end
end

puts"*** my_each ***"
test_one = [1, 2, 3, 4, 5]
p test_one.my_each {|value| value += 10}

puts ""
puts "*** my_each_with_index ***}"
test_two = %w[this is just a test]
p test_two.my_each_with_index {|value, index| p "#{value} : #{index}"}

puts ""
puts "*** my_select ***"
test_three = [1, 2, 3, 4, 5, 6]
p test_three.my_select {|num| num > 1}

puts ""
puts "*** my_all? ***"
test_four = [1, 2, 3, 4, 5, 6]
p test_four.my_all? {|num| num > 0}
p test_four.my_all? {|num| num > 1}
p test_four.my_all? {|num| num <= 6}
p test_four.my_all?
p [nil, true, 99].my_all?

puts ""
puts "*** my_any ***"
test_five = %w[this is just a test]
p test_five.my_any? {|word| word == "test"}
p test_five.my_any? {|word| word == "not"}
p test_five.my_any?
p [nil, true, 99].my_any?
p [nil, false].my_any?

puts ""
puts "*** my_none? ***"
test_five = [1, 2, 3, 4, 5, 6]
p test_five.my_none? {|num| num == 7}
p test_five.my_none? {|num| num == 6}
p [].my_none?
p [nil].my_none?

puts ""
puts "*** my_count ***"
test_six = [7, 3, 0, 0, 0, 5, 0, 0]
p test_six.my_count(0)
p test_six.my_count {|num| num % 2 == 1}

puts ""
puts "*** my_map ***"
test_seven = [1, 2, 3, 4, 5, 6]
p test_seven.my_map {|num| num ** 2}
p test_seven.my_map

puts ""
puts "*** my_inject ***"
p (5..10).my_inject {|memo, num| memo + num}
p (5..10).my_inject(1) {|memo, num| memo * num}
