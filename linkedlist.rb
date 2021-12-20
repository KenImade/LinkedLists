class Node
    attr_accessor :value, :link
    def initialize(value = nil, link = nil)
        @value = value
        @link = link
    end
end

class LinkedList

    attr_reader :head, :tail

    def initialize
        @head = nil
        @tail = nil
    end

    def append(value)
        new_node = Node.new(value)
        if @head == nil
            @head = new_node
        elsif !@tail
            @tail = new_node
        else
            @tail.link = new_node
        end
        @tail = new_node
    end

    def prepend(value)
        new_node = Node.new(value, @head)
        @head = new_node
    end

    def size
        i = 0
        current_node = @head
        until current_node.nil?
            i += 1
            current_node = current_node.link
        end
        i
    end

    def at(index)
        current_node = @head
        index.times do
            current_node = current_node.link
        end
        current_node
    end

    def pop
        nil if size() < 1
        current_node = @head
        current_node = current_node.link until current_node.link == @tail
        current_node.link = nil
        @tail = current_node 
    end

    def contains?(value)
        current_node = @head
        contains = false
        until current_node.nil?
            if current_node.value == value
                contains = true
            end
            current_node = current_node.link
        end
        contains
    end

    def find(value)
        current_node = @head
        index = 0
        found = false
        until current_node.nil?
            found = true if current_node.value == value
            current_node = current_node.link
            index += 1 unless found
        end
        if found 
            index
        else
            puts "Value does not exist"
        end
    end

    def to_s
        string = ""
        current_node = @head
        until current_node.nil?
            string += "( #{current_node.value} ) ->"
            current_node = current_node.link
        end
        puts string + "nil"
    end

    def insert_at(value, index)
        return puts "IndexError: index out of range" if index > size()

        if index.zero?
            prepend(value)
        else
            new_node = Node.new(value, at(index))
            prev_node = at(index - 1)
            prev_node.link = new_node
            @tail = new_node if new_node.link.nil?
        end
    end

    def remove_at(index)
        return puts "IndexError: index out of range" if index > size

        if index.zero?
            @head = at(1)
        elsif at(index) == @tail
            @tail = at(index - 1)
            @tail.link = nil
        else
            prev_node = at(index - 1)
            prev_node.link = at(index + 1)
        end
    end
end

list = LinkedList.new()
# puts list
list.append('last')
# puts list
list.prepend('first')
puts list
puts "Size: #{list.size}"
puts "Head: #{list.head.value}"
puts "Tail: #{list.tail.value}"
puts "At 1: #{list.at(1).value}"
list.pop
puts list
puts "Contains 'first': #{list.contains?('first')}"
puts "Contains 'last': #{list.contains?('last')}"
puts "Index of 'first': #{list.find('first')}"
list.insert_at('new_first', 0)
list.insert_at('new_last', 2)
puts list
list.remove_at(1)
puts list
