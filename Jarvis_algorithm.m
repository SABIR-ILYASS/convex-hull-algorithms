%% TD enveloppes convexes
%% SABIR ILYASS

close all; clearvars;
%% Jarvis algorithm

%% définition de l'orientation de 3 points:
orient = @(px,py,qx,qy, rx, ry) sign((qx - px) * (ry - py) - (rx - px) * (qy - py));
%% calcul de l'angle entre 3 points:
% par décroissance  de cosinus on calcule le - cos de l'angle à l'aide du produit scalaire
cosAngle = @(px,py,qx,qy, rx, ry) - ((qx - px) * (rx - px) + (qy - py) * (ry - py)) / (sqrt((qx - px)^2 + (qy - py)^2) * sqrt((rx - px)^2 + (ry - py)^2));

%% construire le nuage de points dans le carré [0,1]²
n = 20;
points = rand(2,n);
%% affichage de nuage de points
figure;
plot(points(1,:), points(2,:), '.');
axis square; axis equal;
title("Enveloppe convexe d'un nuage de points par l'algo de jarvis");
axis([0 1 0 1]); hold on;

%% determination de point extreme
[px, minY] = min(min(points));
py = points(2, minY);
qx = 0; qy = 0; rx = 0; ry = 0;

%% determination du premier segment de l'enveloppe convexe
for j = 1:n
        count = 0;
        if (j ~= minY)
            for k = 1:n
                if (k ~= minY && k ~= j)
                    if (orient(points(1,minY),points(2,minY),points(1,j),points(2,j),points(1,k),points(2,k)) >= 0)
                        count = count + 1;
                    else
                        count = count - 1;
                    end
                end
            end
            if (count == n - 2)
                qx = points(1,j); qy  = points(2,j);
                plot([points(1,minY) points(1,j)],[points(2,minY) points(2,j)]);
            end
        end
end

%% determiner les points du contour de l'enveloppe convexe:
while(rx ~= points(1,minY) && ry ~= points(2,minY))
    cosAng = -1;
    indexPointExtreme = 0;
    for i = 1:n
        cosangle = cosAngle(qx,qy,px,py, points(1,i),points(2,i));
        if(cosangle > cosAng)
            indexPointExtreme = i;
            cosAng = cosangle;
        end
    end
    rx = points(1, indexPointExtreme); ry = points(2, indexPointExtreme);
    px = qx; py = qy;
    qx = rx; qy = ry;
    plot([px qx],[py qy]);
end