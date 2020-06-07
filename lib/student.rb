class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    student = Self.new 
    
  end

  def self.all
    sql = <<-SQL
      Select * 
      FROM students
    SQL
  end

  def self.find_by_name(name)
    sql = <<-SQL
      Select * 
      FROM students 
      WHERE name = ?
      LIMIT 1 
    SQL
    
    DB[:conn].execut(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
