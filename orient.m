function [orientation] = orient(px,py,qx,qy, rx, ry)

orientation = sign((qx - px) * (ry - py) - (rx - px) * (qy - py));

if orientation == 0
    orientation = 1;
end
