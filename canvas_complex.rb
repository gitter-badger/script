# complex_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas Complex class

# # Complex < Numeric

# (from ruby core)
# ------------------------------------------------------------------------------
# A complex number can be represented as a paired real number with imaginary
# unit; a+bi.  Where a is real part, b is imaginary part and i is imaginary
# unit.  Real a equals complex a+0i mathematically.

# In ruby, you can create complex object with Complex, Complex::rect,
# Complex::polar or to_c method.

#   Complex(1)           #=> (1+0i)
#   Complex(2, 3)        #=> (2+3i)
#   Complex.polar(2, 3)  #=> (-1.9799849932008908+0.2822400161197344i)
#   3.to_c               #=> (3+0i)

# You can also create complex object from floating-point numbers or strings.

#   Complex(0.3)         #=> (0.3+0i)
#   Complex('0.3-0.5i')  #=> (0.3-0.5i)
#   Complex('2/3+3/4i')  #=> ((2/3)+(3/4)*i)
#   Complex('1@2')       #=> (-0.4161468365471424+0.9092974268256817i)

#   0.3.to_c             #=> (0.3+0i)
#   '0.3-0.5i'.to_c      #=> (0.3-0.5i)
#   '2/3+3/4i'.to_c      #=> ((2/3)+(3/4)*i)
#   '1@2'.to_c           #=> (-0.4161468365471424+0.9092974268256817i)

# A complex object is either an exact or an inexact number.

#   Complex(1, 1) / 2    #=> ((1/2)+(1/2)*i)
#   Complex(1, 1) / 2.0  #=> (0.5+0.5i)

# ------------------------------------------------------------------------------
# # Constants:
# I:
#   The imaginary unit.

# # Class methods
#   json_create
#   polar
#   rect
#   rectangular

# # Instance methods
#   *
#   **
#   +
#   -
#   -@
#   /
#   ==
#   abs
#   abs2
#   angle
#   arg
#   as_json
#   conj
#   conjugate
#   denominator
#   fdiv
#   imag
#   imaginary
#   inspect
#   magnitude
#   numerator
#   phase
#   polar
#   quo
#   rationalize
#   real
#   real?
#   rect
#   rectangular
#   to_c
#   to_f
#   to_i
#   to_json
#   to_r
#   to_s
#   ~

# (from gem json-1.8.1)
# ------------------------------------------------------------------------------
# # Class Methods
#   json_create

# # Instance Methods
#   as_json
#   to_json
