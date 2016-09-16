function [ F ] = trapezoid( x, y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dim = size(x);
a = x-y;
b=x+y;
if y == 0
 for i=1:dim(2)
    if (0  <=x(i)) & (x(i)< 2/3*pi)
        F(i)=1;
    elseif (2/3*pi  <= x(i)) & (x(i) < pi)
        F(i)=1-6/pi*(x(i) -2/3*pi);
    elseif (pi<=x(i)) & (x(i) < 5/3*pi)
        F(i)=-1;
    elseif (5/3*pi <= x(i)) & (x(i) < 2*pi)
        F(i)=-1+6/pi*(x(i) -5/3*pi);
    else
        F(i)=0;
    end
 end
elseif y == 2/3*pi
    for i=1:dim(2)
    if ((0+y)  <=x(i)) & (x(i)< (2/3*pi+y))
        F(i)=1;
    elseif ((2/3*pi+y)  <= x(i)) & (x(i) < (pi+y))
        F(i)=1-6/pi*(x(i) -(2/3*pi+y));
    elseif ((pi+y)<=x(i) & x(i) < 2*pi) | (0 <= x(i) & x(i) < (5/3*pi+y - 2*pi))
        F(i)=-1;
    elseif ((5/3*pi+y-2*pi) <= x(i)) & (x(i) < (2*pi+y-2*pi))
        F(i)=-1+6/pi*(x(i) -(5/3*pi+y-2*pi));
    else
        F(i)=0;
    end
    end
elseif y==4/3*pi
    for i=1:dim(2)
    if ((0+y)  <=x(i)) & (x(i)< (2/3*pi+y))
        F(i)=1;
    elseif ((2/3*pi+y-2*pi)  <= x(i)) & (x(i) < (pi+y-2*pi))
        F(i)=1-6/pi*(x(i) -(2/3*pi+y-2*pi));
    elseif ((pi+y-2*pi)<=x(i) & x(i) < (5/3*pi+y - 2*pi))
        F(i)=-1;
    elseif ((5/3*pi+y-2*pi) <= x(i)) & (x(i) < (2*pi+y-2*pi))
        F(i)=-1+6/pi*(x(i) -(5/3*pi+y-2*pi));
    else
        F(i)=0;
    end
    end
end
 
end