require 'Sqlite3'


class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=(nil))
    @name = name
    @grade = grade
    @id = id
  end

  def self.create(attr_hash)
    new_student = Student.new(attr_hash[:name], attr_hash[:grade])
    new_student.save
    new_student
  end

  def self.create_table
    sql = "CREATE TABLE students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    );"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade)
    VALUES ('#{self.name}', '#{self.grade}')"
    DB[:conn].execute(sql)
    sql = "SELECT id FROM students ORDER BY id DESC LIMIT 1;"
    @id = DB[:conn].execute(sql).first.first # I don't like the @id here
  end



end
