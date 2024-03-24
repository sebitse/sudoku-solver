function [imagine] = img_acquisition()

if isempty(webcamlist)
    imagine = [];
else
    % punem 1 deoarece ne referim la prima
    % camera detectata din lista data de comanda
    % webcamlist, cea pe care o vom folosi
    cam = webcam(1);

    imagine = snapshot(cam);
end
 
end