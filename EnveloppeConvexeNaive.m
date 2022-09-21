%% TD enveloppes convexes
close all; clearvars;
%% définition de l'orientation de 3 points:
orient = @(px,py,qx,qy, rx, ry) sign((qx - px) * (ry - py) - (rx - px) * (qy - py));

%% Un nuage dde points aléatoire dans le carré [0,1]²
n = 20;
points = rand(2,n);

%% Affichage du nuage
figure;
plot(points(1,:), points(2,:), '.');
axis square; axis equal;
title("nuage de points");
axis([0 1 0 1]); hold on;

tStart = tic;
list = zeros(n,2)
for i = 1:n
    for j = 1:n
        count = 0;
        if (j ~= i)
            for k = 1:n
                if (k ~= i && k ~= j)
                    if (orient(points(1,i),points(2,i),points(1,j),points(2,j),points(1,k),points(2,k)) >= 0)
                        count = count + 1;
                    else
                        count = count - 1;
                    end
                end
            end
            if ((count == n - 2) || (count == 2 - n))
                plot([points(1,i) points(1,j)],[points(2,i) points(2,j)]);
            end
        end
    end
end
tEnd = toc(tStart);




