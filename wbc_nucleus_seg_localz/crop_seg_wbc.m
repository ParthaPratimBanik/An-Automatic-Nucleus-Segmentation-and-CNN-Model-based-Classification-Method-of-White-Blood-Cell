function [cropped_WBC_img, OnlyNucl] = crop_seg_wbc(in_img, TrackedObj, hwrTh)

%% The input variables
% -in_img     : Input Orginal Image (uint8 type RGB Image)
% -TrackedObj : Black and White Image of Tracked Image (logical type (binary) Image)
% -hwrTh      : height and width ratio (any value between 1.25 to 2.25)

%% The output variables
% -cropped_WBC_img: uint8 type RGB image (cropped WBC image based on nucleus tracking)
% -OnlyNucl: logical type binary image (only nucleus) 

cropped_WBC_img = cell(0);

% figure;
% imshow(TrackedObj);

se = strel('disk',5);
% im_open_img = imopen(TrackedObj, se);
im_open_img = imerode(TrackedObj, se);

% figure;
% imshow(im_open_img);


[row, col,~] = size(TrackedObj);
count=1;
try
    for rwNo=1:row
        rw_imop_vec(1,rwNo) = length(im_open_img(im_open_img(rwNo,:)==1));
%         rw_tr_vec(rwNo) = length(row_clLoc_img(row_clLoc_img(rwNo,:)==1));
    end
    %% Calculating the start and end row location
    % pos=loc_rw_g;
    % RwLoc = find(rw_imop_vec>0);
    [~,RwLoc] = max(rw_imop_vec);

    % fprintf('RwLoc:');
    % disp(RwLoc);

    % stRw = RwLoc(1);
    % edRw = RwLoc(end);

    rw_tr_vec = zeros(1,row);
    for rwNo=1:row
        rw_tr_vec(1,rwNo) = length(TrackedObj(TrackedObj(rwNo,:)==1));
        % rw_tr_vec(rwNo) = length(row_clLoc_img(row_clLoc_img(rwNo,:)==1));
    end
%   [~,RwLoc] = max(rw_tr_vec);
    pos=RwLoc(1);
    while rw_tr_vec(pos)>0
        if pos==1
            break;
        end
        pos=pos-1;
    end
    stRw=pos;
    pos=RwLoc(1);
    while rw_tr_vec(pos)>0
        if pos==row
            break;
        end
        pos=pos+1;
    end
    edRw=pos;
    %% Taking full row of specific Column location
    col_rwLoc_img=TrackedObj(stRw:edRw,:);
    %% Finding the only black pixel row vector
    cl_tr_vec = zeros(1,col);
    for clNo=1:col
        cl_tr_vec(1,clNo) = length(col_rwLoc_img(col_rwLoc_img(:,clNo)==1));
    end
    % Calculating the start and end column location
%         ClLoc = find(cl_tr_vec>0);
    [~,ClLoc] = max(cl_tr_vec);
    %         stCl = ClLoc(1);
    %         edCl = ClLoc(end);

    pos=ClLoc(1);
    while cl_tr_vec(pos)>0
        if pos==1
            break;
        end
        pos=pos-1;
    end
    stCl=pos;
    pos=ClLoc(1);
    while cl_tr_vec(pos)>0
        if pos==col
            break;
        end
        pos=pos+1;
    end
    edCl=pos;

    %% Only Nucleus on that row and column location
    OnlyNucl = TrackedObj;
    OnlyNucl(stRw:edRw, stCl:edCl) = TrackedObj(stRw:edRw, stCl:edCl);

    %% Now Creating Rectangular boundary to crop the WBC
    rwSz=edRw-stRw+1;
    clSz=edCl-stCl+1;
    if rwSz>clSz
        hw_ratio = rwSz/clSz;
        maxSz=rwSz;
    else
        hw_ratio = clSz/rwSz;
        maxSz=clSz;
    end
    % Adding 50% of maximum size
    if hw_ratio<hwrTh
        maxSz=maxSz+ceil((hwrTh-1)*maxSz);
    end
    %% Calculating the Mid Point and checking the boundary of the rectangle
    rectSz = [maxSz, maxSz];

    if rectSz(1) > row || rectSz(2) > col
        warning_mess = sprintf('\nFail to crop WBC Image.\nThe value of hwrTh should be more less but greater than 1');
        warning(warning_mess);
        return;
    end        

    midRw = ceil(rwSz/2) + stRw;
    midCl = ceil(clSz/2) + stCl;
    OrgLoc = [midRw-ceil(rectSz(1)/2), midCl-ceil(rectSz(2)/2)];

    if OrgLoc(1)<1
        OrgLoc(1) = 1;
    end
    if OrgLoc(2)<1
        OrgLoc(2) = 1;
    end
    if OrgLoc(1)>row
        OrgLoc(1) = row;
    end
    if OrgLoc(2)>col
        OrgLoc(2) = col;
    end

    if OrgLoc(1)+rectSz(1)>row
        OrgLoc(1) = OrgLoc(1)-(OrgLoc(1)+rectSz(1)-row);
    end
    if OrgLoc(2)+rectSz(2)>col
        OrgLoc(2) = OrgLoc(2)-(OrgLoc(2)+rectSz(2)-col);
    end
%   disp(OrgLoc);
%   disp(size(in_img));
    %% Cropped the image according to the location
    % cropped_WBC_img=0;

    cropped_WBC_img{1,count} = in_img(OrgLoc(1):OrgLoc(1)+rectSz(1), OrgLoc(2):OrgLoc(2)+rectSz(2), :);
%   TrackedObj(OrgLoc(1):OrgLoc(1)+rectSz(1), OrgLoc(2):OrgLoc(2)+rectSz(2)) = 0;
%   im_open_img(OrgLoc(1):OrgLoc(1)+rectSz(1), OrgLoc(2):OrgLoc(2)+rectSz(2)) = 0;
catch
    if isempty(cropped_WBC_img)
        warning_mess = sprintf('\nFail to crop WBC Image');
        warning(warning_mess);
        cropped_WBC_img = 0;
    end
end
% cropped_WBC_img = 0;
end