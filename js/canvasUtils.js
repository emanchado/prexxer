/*global app*/

app.ports.calculateDrawerContainer.subscribe(function(evt) {
    var imageId = evt.drawerId,
        partWidth = evt.partWidth,
        partHeight = evt.partHeight,
        drawerImg = document.getElementById(imageId),
        tmpCanvas = document.createElement("canvas"),
        context, imageData;

    tmpCanvas.width = drawerImg.width;
    tmpCanvas.height = drawerImg.height;

    context = tmpCanvas.getContext("2d");
    context.drawImage(drawerImg, 0, 0);

    imageData = context.getImageData(0,
                                     0,
                                     tmpCanvas.width,
                                     tmpCanvas.height);

    var squares = [];
    for (var i = 0; i < tmpCanvas.height; i += partHeight) {
        for (var j = 0; j < tmpCanvas.width; j += partWidth) {
            squares.push(containingSquare(imageData, j, i, partWidth, partHeight));
        }
    }

    var minCoord = [
        Math.min.apply(null, squares.map(function(c) { return c[0]; })),
        Math.min.apply(null, squares.map(function(c) { return c[1]; }))
    ];
    var maxCoord = [
        Math.max.apply(null, squares.map(function(c) { return c[2]; })),
        Math.max.apply(null, squares.map(function(c) { return c[3]; }))
    ];
    var sizes = [maxCoord[0] - minCoord[0] + 1,
                 maxCoord[1] - minCoord[1] + 1];

    app.ports.drawerContainerResponder.send({drawerId: evt.drawerId,
                                             dimensions: {
                                                 width: tmpCanvas.width,
                                                 height: tmpCanvas.height
                                             },
                                             coords: {
                                                 x: minCoord[0],
                                                 y: minCoord[1],
                                                 width: sizes[0],
                                                 height: sizes[1]
                                             }});
});

function containingSquare(imageData, initialX, initialY, width, height) {
    var minX = width, minY = height,
        maxX = 0,     maxY = 0;

    for (var y = 0; y < height; y++) {
        for (var x = 0; x < width; x++) {
            var i = ((initialY + y) * imageData.width + (initialX + x)) * 4;

            if (imageData.data[i + 3]) {
                minX = Math.min(minX, x);
                minY = Math.min(minY, y);
                maxX = Math.max(maxX, x);
                maxY = Math.max(maxY, y);
            }
        }
    }

    return [minX, minY, maxX, maxY];
}
