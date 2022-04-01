require 'matrix'


class MySudukuSolver
    @board = Matrix.build(9) { 0 }
    refBoard = Matrix.build(9) { 0 }

    def initialize (number)
        @board = Matrix.build(9) { number }
        @refBoard = Matrix.build(9) { number }
    end


    def solve 
        solver(0,0)
    end

    

    def solver(row, col)
        if col != 8 
            nextRow = row
            nextCol = col + 1
        else 
            nextRow = row + 1
            nextCol = 0
        end 
        if row == 9
            return  true
        end
        if @refBoard[row, col] == 0
            for digit in 1 .. 9
                add(row, col, digit)
                if isValid
                    if solver nextRow, nextCol
                        return true
                    else 
                        remove(row, col)
                    end
                else
                    remove(row, col)
                end
            end

            return false
        else
            if !solver(nextRow, nextCol)
                return false
            end
        end
        return true
    end


    # ------- Operations on the board --------
    def add(row, col, digit)
        if row.instance_of? Integer and col.instance_of? Integer and digit.instance_of? Integer 
            if row < 9 and col < 9 and row >= 0 and col >= 0 and digit <= 9 and digit >= 1
                @board[row, col] = digit
                @refBoard[row, col] = digit               
            else
               puts "outside of board"
            end
        else 
            puts 'Need all as Integers'
        end
    end


    def remove (row, col)
        if row.instance_of? Integer and col.instance_of? Integer  
            if row < 9 and col < 9 and row >= 0 and col >= 0 
                @board[row, col] = 0
                @refBoard[row, col] = 0                
            else
               puts "outside of board"
            end
        else 
            puts 'Need all as Integers'
        end
    end

    def get (row, col)
        if row.instance_of? Integer and col.instance_of? Integer  
            if row < 9 and col < 9 and row >= 0 and col >= 0 
                @board[row, col]               
            else
               puts "Outside of board"
            end
        else 
            puts 'Need all as Integers'
        end
    end


    # ------- Try if valid --------
    def isValid
        rowValid and colValid and boxValid
    end
    
    def rowValid
        valid = true
        
        @board.row_vectors().map{ |j|
            checkVector = Array.new
            j.map{ |i|
                if checkVector.include?(i) and i > 0
                   valid = false                 
                else
                    checkVector.insert(0, i)
                end
            }
            
        }
        valid        
    end

    def colValid
        valid = true
        
        @board.column_vectors().map{ |j|
            checkVector = Array.new
            j.map{ |i|
                if checkVector.include?(i) and i > 0
                   valid = false                 
                else
                    checkVector.insert(0, i)
                end
            }
            
        }
        valid       
    end

    def boxValid
        valid = true
        for a in 0 .. 2 
            for b in 0 .. 2
                checkVector = Array.new
                for i in 0 .. 2
                    for j in 0 .. 2 
                        thisInt = @board[i + (a * 3), j + (b * 3 )]
                        if thisInt > 0 and checkVector.include? thisInt
                            valid = false
                        else  
                            checkVector.insert 0, thisInt 
                        end  
                    end
                end
            end
        end
        valid
    end





    def to_s 
        tempS = ' + - - - + - - - + - - - +' "\n"
		for  i in 0 .. @board.column_size - 1
			for  j in 0 .. @board.column_size - 1
			    tempS = tempS + ' |' if j % 3 == 0
			    tempS = tempS + ' ' + @board[i, j].to_s    
            end

            tempS = tempS + ' |' "\n"
            if i % 3 == 2
		        tempS = tempS + ' + - - - + - - - + - - - + ' "\n" 
            end 
            
        end 
        tempS
    end

    
end
