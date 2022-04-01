
require 'matrix'
require_relative 'MySudukuSolver'


board = MySudukuSolver.new(0)
board.add(2, 2, 2)

board.solve
puts board




