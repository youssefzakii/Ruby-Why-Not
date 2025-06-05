class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def to_line
    "#{@title}|#{@author}|#{@isbn}"
  end

  def self.from_line(line)
    title, author, isbn = line.strip.split('|')
    new(title, author, isbn)
  end
end

class Inventory
  Path = 'books.txt'

  def initialize
    @books = load_books
  end

  def list_books
    if @books.empty?
      puts "Inventory is empty."
    else
      puts "Books in Inventory:"
      @books.each_with_index do |book, index|
        puts "#{index + 1}. #{book.title} by #{book.author} (ISBN: #{book.isbn})"
      end
    end
  end

  def add_book(book)
    if @books.any? { |b| b.isbn == book.isbn }
      puts "book with #{book.isbn}exists"
      return
    end

    @books << book
    save_books
    puts "book '#{book.title}' added."
  end

  def remove_book_by_isbn(isbn)
    original_size = @books.size
    @books.reject! { |book| book.isbn == isbn }

    if @books.size < original_size
      save_books
      puts "book with isbn #{isbn} removed."
    else
      puts "No book isbn #{isbn}."
    end
  end

  private

  def load_books
    return [] unless File.exist?(Path)

    File.readlines(Path).map { |line| Book.from_line(line) }
  end

  def save_books
    File.open(Path, 'w') do |file|
      @books.each { |book| file.puts(book.to_line) }
    end
  end
end


inventory = Inventory.new
loop do
  puts "\nChoose an option:"
  puts "1. List books"
  puts "2. Add new book"
  puts "3. Remove book by ISBN"
  puts "4. Exit"
  print "> "
  choice = gets.chomp

  case choice
  when '1'
    inventory.list_books
  when '2'
    print "Title: "
    title = gets.chomp
    print "Author: "
    author = gets.chomp
    print "ISBN: "
    isbn = gets.chomp
    inventory.add_book(Book.new(title, author, isbn))
  when '3'
    print "Enter ISBN to remove: "
    isbn = gets.chomp
    inventory.remove_book_by_isbn(isbn)
  when '4'
    puts "bye!"
    break
  else
    puts "Invalid choice."
  end
end
