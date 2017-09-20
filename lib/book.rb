class Book

  attr_reader(:id, :title, :author)
  attr_accessor(:checked_in)

  def initialize (attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @checked_in = (attributes.has_key?(:checked_in) ? attributes[:checked_in] : true)
  end

  def self.all
    total_books = DB.exec("SELECT * from books;")
    books = []
    total_books.each do |book|
      id = book.fetch("id").to_i
      title = book.fetch("title")
      author = book.fetch("author")
      checked_in = book.fetch("checked_in")
      books.push(Book.new({:id => id, :title => title, :author => author}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(another_book)
   self.title().==(another_book.title()).&(self.id().==(another_book.id()))
  end

  def checkout(patron_id, due_date)
    today = Date.today
    checkout_list = Checkout.new({:id => nil, :due_date => due_date, :book_id => @id, :patron_id => patron_id})
    checkout_list.save
    @checked_in = false
    checkout_list
  end

  def checkin 
    @checked_in = true
  end

  def self.search_by_author(author)
    returned_books = DB.exec("SELECT * FROM books WHERE author = ('#{author}');")
    books = []
    returned_books.each do |book|
      title = book.fetch("title")
      books.push(title)
    end
  books
  end

  def self.search_by_title(title)
    returned_books = DB.exec("SELECT * FROM books WHERE title = ('#{title}');")
    books = []
    returned_books.each do |book|
      title = book.fetch("title")
      books.push(title)
    end
  books
  end

end
