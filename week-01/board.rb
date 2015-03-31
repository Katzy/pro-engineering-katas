class Board

  class DimensionError < StandardError;end
  class CellError < StandardError;end

  attr_reader :row_count, :column_count


  def initialize(row_count, column_count)
    unless row_count > 0
      raise DimensionError, "row_count must be > 0 (got #{row_count})"
    end

    unless column_count > 0
      raise DimensionError, "column_count must be > 0 (got #{column_count})"
    end

    @row_count    = row_count
    @column_count = column_count

    @board = Array.new(@row_count) { Array.new(@column_count) }
  end

  def get(row, column)
    raise_unless_dimensions_valid!(row, column)
    @board[row][column]

  end

  def place(row, column, piece)
    raise_unless_dimensions_valid!(row, column)
    raise_unless_cell_unoccupied!(row, column)
    @board[row][column] = piece

  end

  def remove(row, column)
    raise_unless_dimensions_valid!(row, column)
    raise_unless_cell_occupied!(row, column)
    @board[row][column] = nil

  end

  private
  def raise_unless_dimensions_valid!(row, column)
    unless (column >= 0 && column < column_count) && (row >= 0 && row < row_count)
      raise DimensionError
    end
  end

  def raise_unless_cell_unoccupied!(row, column)
    unless @board[row][column] == nil
      raise CellError
    end
  end

  def raise_unless_cell_occupied!(row, column)
    unless @board[row][column] != nil
      raise CellError
    end
  end
end
