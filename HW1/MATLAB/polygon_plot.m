%function polygon_plot(vertices,style)
%Draws a closed polygon described by  vertices using the style (e.g., color)
%given by  style.
function polygon_plot(vertices,style)
numberOfVertices = length(vertices);

hold on;
for i = 1:(numberOfVertices-1)
    uValue = vertices(1,i+1) - vertices(1,i);
    vValue = vertices(2,i+1) - vertices(2,i);
    quiver(vertices(1,i), vertices(2,i),uValue, vValue, style, 'LineWidth', 1.5, 'AutoScale', 'off');
end
    finalU = vertices(1,1) - vertices(1,numberOfVertices);
    finalV = vertices(2,1) - vertices(2,numberOfVertices);
    quiver(vertices(1,numberOfVertices), vertices(2,numberOfVertices), finalU, finalV, style, 'LineWidth', 1.5, 'AutoScale', 'off'); 

    
    if polygon_isFilled(vertices)
        patch(vertices(1,:), vertices(2,:), [0.5 0.5 0.5]);
    else
        set(gca, 'Color', [0.5 0.5 0.5]);
        patch(vertices(1,:), vertices(2,:), [1 1 1]);
    end
hold off;

    


%Each edge in the polygon must be an arrow pointing from one vertex to the next.
%In Matlab, use the function quiver to actually perform the drawing. The function
%should  not create a new figure.
