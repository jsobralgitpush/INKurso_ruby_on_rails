class Matrix
  def initialize(matrix)
    @matrix = matrix
  end

  def rows
    rows_str = @matrix.split("\n") 
    rows_answer = []

    for i in rows_str
      rows_inside = []
      for j in i.split(' ')
        rows_inside.append(j.to_i)
      end

      rows_answer.append(rows_inside)
    end

    return rows_answer

  end

  def columns
    col_str = @matrix.split("\n") 
    col_answer = []

    num_col = (col_str[0].split(' ')).length()

    counter = 0
    while counter != num_col
      col_inside = []

      for j in col_str
        row = j.split(' ')
        col_inside.append(row[counter].to_i)
      end

      counter +=1
      col_answer.append(col_inside)
    end

    return col_answer

  end


end

