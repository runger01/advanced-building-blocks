def bubble_sort(input_array)
    numbers = input_array
    end_of_array = numbers.length
    count = 0

    while count < end_of_array
        numbers.each_with_index do |num, index|
            current_number = num
            next_number = numbers[index.next]

            if !next_number.nil? && current_number > next_number
                numbers[index], numbers[index.next] = next_number, current_number
            end
        end
        count += 1
    end
    numbers

end


def bubble_sort_by(input_array)
    sorted_array = input_array

    for num in 0..sorted_array.length
        sorted_array.each_with_index do |left, index|
            right = sorted_array[index.next]

            unless right.nil?
                swap_factor = yield(left, right)
                if swap_factor < 0
                    sorted_array[index], sorted_array[index.next] = right, left
                end
            end
        end
    end

    sorted_array
end


numbers = [4, 6, 2, 4, 1, 1, 7, 5, 3, 2, 9, 8]
p bubble_sort(numbers)

result = bubble_sort_by(%w[hello hi hey sup greetings]) do |left, right|
    right.length - left.length
end
p result