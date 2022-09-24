%% TD enveloppes convexes
%% SABIR ILYASS
close all; clearvars;

%% Graham's algorithm (2eme version)

n = 20;
points = rand(2,n);

%% affichage de nuage de points

figure;
plot(points(1,:), points(2,:), '.');
axis square; axis equal;
title("nuage de points, graham's method");
axis([0 1 0 1]); hold on;

%% tri des points selon ordre croissantes des abcisse:
%points = sortrows(points',2,'ascend')';
points = sortrows(points',[1,2],'ascend')'

% [pxmin, pymin, minY] = minimum(points, n);

% if(minY ~= 1)
%     points(1, minY) = points(1,1); points(2, minY) = points(1,2);
%     points(1,1) = pxmin; points(2,1) = pymin;
% end


%% initialisation:
indexPoints = zeros(1, n); 
index = 2;
indexPoints(1,1) = 1; indexPoints(1,2) = 2;

%% construction des points de l'enveloppe convexe (partie supérieure)

for i = 3:n

    orientation = orient(points(1,indexPoints(1,index - 1)), points(2,indexPoints(1,index - 1)), points(1,indexPoints(1,index)), points(2, indexPoints(1,index)), ...
        points(1,i), points(2,i));
    while (orientation == 1)
        [index, indexPoints] = FIFO(indexPoints, index, i, 'pop');

        if( index == 1)
            break;
        else
                    orientation = orient(points(1,indexPoints(1,index - 1)), points(2,indexPoints(1,index - 1)), points(1,indexPoints(1,index)),points(2, indexPoints(1,index)) ...
             , points(1,i), points(2,i));
        end
    end
    [index, indexPoints] = FIFO(indexPoints, index, i, 'append');
end

%% plot l'enveloppe convexe
for i = 1:index - 1
    pointx1 = points(1,indexPoints(1,i)); pointy1 = points(2, indexPoints(1,i));
    pointx2 = points(1, indexPoints(1,i+1)); pointy2 = points(2, indexPoints(1,i+1));
    plot([pointx1 pointx2], [pointy1 pointy2]);
end

%% construction des points de l'enveloppe convexe (partie inférieure)
indexPoints = zeros(1, n); 
index = 2;
indexPoints(1,1) = n; indexPoints(1,2) = n - 1;

for i = 3:n

    orientation = orient(points(1,indexPoints(1,index - 1)), points(2,indexPoints(1,index - 1)), points(1,indexPoints(1,index)), points(2, indexPoints(1,index)), ...
        points(1,n - i + 1), points(2,n - i + 1));
    while (orientation == 1)
        [index, indexPoints] = FIFO(indexPoints, index, n - i + 1, 'pop');

        if( index == 1)
            break;
        else
                    orientation = orient(points(1,indexPoints(1,index - 1)), points(2,indexPoints(1,index - 1)), points(1,indexPoints(1,index)),points(2, indexPoints(1,index)) ...
             , points(1,n - i + 1), points(2,n - i + 1));

        end
    end
    [index, indexPoints] = FIFO(indexPoints, index, n - i + 1, 'append');
end

%% plot l'enveloppe convexe
for i = 1:index - 1
    pointx1 = points(1,indexPoints(1,i)); pointy1 = points(2, indexPoints(1,i));
    pointx2 = points(1, indexPoints(1,i+1)); pointy2 = points(2, indexPoints(1,i+1));
    plot([pointx1 pointx2], [pointy1 pointy2]);
end
