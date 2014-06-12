function matchFig = templateMatch(img,fig)

% Corrélation d'une figure de référence avec l'image source

[H,W] = size(img);
[H1,W1] = size(fig);
matchFig = zeros([H,W]);
x0 = round(H1/2);
y0 = round(W1/2);

for i=1:H-H1
   for j=1:W-W1
       c = corr2(fig,img(i:i+H1-1, j:j+W1-1));
      matchFig(i+x0,j+y0) = c;         
   end;
end;

maxi=max(matchFig(:));
disp('Résultats de corrélation');
[indx,indy] = find(matchFig==maxi);
disp(sprintf('Maximum : %2.4f en :',maxi));
for k=1:length(indx), disp(sprintf('         -->  [%d,%d]',indx(k),indy(k)));end

end
