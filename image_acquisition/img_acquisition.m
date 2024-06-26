function [img] = img_acquisition()

if isempty(webcamlist)
    img = [];
else
    % punem 1 deoarece ne referim la prima
    % camera detectata din lista data de comanda
    % webcamlist, cea pe care o vom folosi
    cam = webcam(1);

    img = snapshot(cam);
end

% m = mobiledev;
% cam = camera(m,'back');
% % cam.Flash = 'on';
% 
% img = snapshot(cam,'manual');

% image(img);
end