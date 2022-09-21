%% TD enveloppes convexes
%% SABIR ILYASS
close all; clearvars;

%% Graham's algorithm

%% définition de l'orientation de 3 points:

% orient = @(px,py,qx,qy, rx, ry) sign((qx - px) * (ry - py) - (rx - px) * (qy - py));

%% calcul de l'angle entre 3 points:
% par décroissance  de cosinus on calcule le - cos de l'angle à l'aide du produit scalaire:

cosAngle = @(px,py,qx,qy, rx, ry) - ((qx - px) * (rx - px) + (qy - py) * (ry - py)) / (sqrt((qx - px)^2 + (qy - py)^2) * sqrt((rx - px)^2 + (ry - py)^2));

%% construire le nuage de points dans le carré [0,1]²

n = 20;
points = rand(2,n);

%% affichage de nuage de points

figure;
plot(points(1,:), points(2,:), '.');
axis square; axis equal;
title("nuage de points, graham's method");
axis([0 1 0 1]); hold on;

% determiner le point d'abcisse minimal:

% [pxmin, minY] = min(min(points));
% pymin = points(2, minY);

[pxmin, pymin, minY] = minimum(points, n);

%% créer un tableau de taille 3 * n: les deux premiers lignes pour les coordonnées du point et le 3eme ligne pour l'angle ... 

sortedArray = zeros(3,n);
sortedArray(1,1) = pxmin; sortedArray(2,1) = pymin; sortedArray(3,1) = -2;

for i = 1:(minY - 1)
    sortedArray(1,i+1) = points(1,i);
    sortedArray(2,i+1) = points(2,i);
    sortedArray(3,i+1) = cosAngle(pxmin, pymin, points(1,i), points(2,i), 2, pymin);
end
for i = (minY + 1):n
    sortedArray(1,i) = points(1,i);
    sortedArray(2,i) = points(2,i);
    sortedArray(3,i) = cosAngle(pxmin, pymin, points(1,i), points(2,i), 2, pymin);
end


%% tri des points selon ordre croissantes des abcisse:
sortedArray = sortrows(sortedArray',3,'ascend')';

%% initialisation:
indexPoints = zeros(1, n); 
index = 2;
indexPoints(1,1) = 1; indexPoints(1,2) = 2;

%% construction des points de l'enveloppe convexe

for i = 3:n

    orientation = orient(sortedArray(1,indexPoints(1,index - 1)), sortedArray(2,indexPoints(1,index - 1)), sortedArray(1,indexPoints(1,index)), sortedArray(2, indexPoints(1,index)), ...
        sortedArray(1,i), sortedArray(2,i));
    while (orientation == -1)
        [index, indexPoints] = FIFO(indexPoints, index, i, 'pop');
        orientation = orient(sortedArray(1,indexPoints(1,index - 1)), sortedArray(2,indexPoints(1,index - 1)), sortedArray(1,indexPoints(1,index)),sortedArray(2, indexPoints(1,index)) ...
             , sortedArray(1,i), sortedArray(2,i));
    end
    [index, indexPoints] = FIFO(indexPoints, index, i, 'append');
end

%% plot l'enveloppe convexe
for i = 1:index - 1
    pointx1 = sortedArray(1,indexPoints(1,i)); pointy1 = sortedArray(2, indexPoints(1,i));
    pointx2 = sortedArray(1, indexPoints(1,i+1)); pointy2 = sortedArray(2, indexPoints(1,i+1));
    plot([pointx1 pointx2], [pointy1 pointy2]);
end

pointx1 = sortedArray(1,indexPoints(1,1)); pointy1 = sortedArray(2, indexPoints(1,1));
pointx2 = sortedArray(1, indexPoints(1, index)); pointy2 = sortedArray(2, indexPoints(1, index));
plot([pointx1 pointx2], [pointy1 pointy2]);
