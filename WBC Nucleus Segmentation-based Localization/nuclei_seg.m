function [final_TO] = nuclei_seg(in_img, ClusrNo, disc_rad)

%% The input variables
% -in_img   : Input Orginal Image (uint8 type RGB Image)
% -ClusrNo  : Number of cluster for k-means function (double type integer) 
% -disc_rad : radius of fspecial function (double type integer)

%% The output variables
% -final_TO : Black and White Image of Tracked Image (logical type (binary) Image)

%% by default
if nargin == 1
    ClusrNo=2;
    disc_rad=10;
end
[row, col, ~] = size(in_img);
if row>1024 || col>1024
    in_img=imresize(in_img, 0.25);
end
[row,col,~] = size(in_img);

%% For Input image Display Purpose
% figure('Name','Input Image'); imshow(in_img);


%% ****************Start of Our Nuclei Sementation Method*************************
% H = fspecial('average', [27,27]);
% H = fspecial('disk', 15);
% blurImg = imfilter(img,H,'replicate');
[rowb, colb, ~] = size(in_img);

%% Conversting RGB color space to HSV Color Space
img_hsv = rgb2hsv(in_img);
img_lab = rgb2lab(in_img);

%% Measuring the mean of each channel of HSI and Lab Image
h = img_hsv(:,:,1)*255;
s = img_hsv(:,:,2)*255;
i = img_hsv(:,:,3)*255;
avg_hsi = [mean(h(:)), mean(s(:)), mean(i(:))];

l = img_lab(:,:,1);
a = img_lab(:,:,2);
b = img_lab(:,:,3);
avg_lab = [mean(l(:)), mean(a(:)), mean(b(:))];

% fprintf('\n%d.\nMean of Hue: %f\nMean of Sat: %f\nMean of Int: %f\n',k,mean(h(:)),mean(s(:)),mean(i(:)));
% fprintf('\nMean of R: %f\nMean of G: %f\nMean of B: %f\n',mean(r(:)),mean(g(:)),mean(B(:)));
% fprintf('\nMean of L: %f\nMean of A: %f\nMean of B: %f\n',mean(l(:)),mean(a(:)),mean(b(:)));
%% Taking a channel which has minimum mean value among three channels of HSI
[~,OrgLoc] = sort(avg_hsi);
final_comp = img_hsv(:,:,OrgLoc(1))*255;
% figure; imshow(final_comp/255);

%% Taking a channel which has minimum mean value among three channels of Lab
[~,OrgLoc] = sort(avg_lab);
snd_comp = abs(img_lab(:,:,OrgLoc(1)));
% figure; imshow(snd_comp/255);

%% Nuclei detection after mathematical operation
SmulI = double(uint8(final_comp.*snd_comp/mean(final_comp(:))));
% SmulI = double(uint8(final_comp.*snd_comp/mean(snd_comp(:))));
% figure; imshow(SmulI/255);

%% Blurring the Image for detected the segmented Nucleus
H = fspecial('disk', disc_rad);
blurImg = imfilter(SmulI,H,'replicate');
% figure; imshow(blurImg/255);
% mean_I = mean(I(:));

%% Applying K-means clustering algorithm
cluster_init = zeros(ClusrNo,1);
[idx, C] = kmeans(blurImg(:), ClusrNo, 'Start', cluster_init);

%% Preparing Clustered image
outImg = zeros(row, col, 3);
temp = reshape(idx, [rowb colb]);
for ii = 1 : 1 : rowb
    for j = 1 : 1 : colb
        outImg(ii,j,:) = C(temp(ii,j),:);
    end
end
% figure; imshow(outImg/255);

%% Detectin the Nucleus from the clustered image
[~,loc_C]=sort(C,'descend');
TO_fill = (temp==loc_C(1));
% figure; imshow(TO_fill);

%% Perform hole filling operation if by any means any hole is present into the detected nucleus
final_TO = imfill(TO_fill,'holes');
end