## Copyright (C) 2025 willy
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} hipotenusa (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: willy <willy@WILLYSIC>
## Created: 2025-04-10

#function hipo = hipotenusa (a, b) # sintaxis para solo dar 1 valor
function [hipo,a_cuadrada] = hipotenusa (a, b)
  hipo = sqrt(a.^2 + b^2);
  a_cuadrada = a.^2

endfunction
