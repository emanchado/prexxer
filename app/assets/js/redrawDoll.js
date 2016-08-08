var node = document.getElementById("main");
var app = Elm.Main.embed(node);

app.ports.redrawDoll.subscribe(function(evt) {
    var canvas = document.getElementById(evt.dollCanvasId),
        canvasContext = canvas.getContext("2d"),
        multiplierX = evt.wardrobe.dollWidth + evt.wardrobe.spacerWidth,
        multiplierY = evt.wardrobe.dollHeight + evt.wardrobe.spacerHeight;

    canvasContext.clearRect(0, 0, canvas.width, canvas.height);

    var selectionDict = {};
    evt.outfitSelections.forEach(function(part) {
        selectionDict[part[0]] = part[1];
    });

    evt.wardrobe.drawers.forEach(function(drawer) {
        if (selectionDict.hasOwnProperty(drawer.id)) {
            var img = document.getElementById(drawer.id),
                drawerCoords = selectionDict[drawer.id];

            canvasContext.drawImage(img,
                                    multiplierX * drawerCoords.drawerCol,
                                    multiplierY * drawerCoords.drawerRow,
                                    evt.wardrobe.dollWidth,
                                    evt.wardrobe.dollHeight,
                                    0,
                                    0,
                                    evt.wardrobe.dollWidth,
                                    evt.wardrobe.dollHeight);
        }
    });
});
