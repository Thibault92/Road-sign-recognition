function [imLabel,Etiquettes, classAire, index] = etiquette(img)


[imLabel,Etiquettes] = bwlabel(img);
disp(sprintf('     -- > %d objets détectés',Etiquettes));

Etiquettes = regionprops(imLabel, 'BoundingBox', 'Area');

for k = 1 : length(Etiquettes)
  objet(k,:) = Etiquettes(k).BoundingBox;
end

Aires = [Etiquettes.Area];
[classAire, index] = sort(Aires, 'descend');
end
