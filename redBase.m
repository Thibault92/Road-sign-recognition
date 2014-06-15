function imStop = redBase(img, R)

[H,W,Canaux] = size(img);
imStop = zeros([H,W]);

for i = 1:H
    for j = 1:W
        if R(i,j,1) == 255
            imStop(i,j,:) = 1;
        else imStop(i,j,:) = 0;
        end
    end
end
