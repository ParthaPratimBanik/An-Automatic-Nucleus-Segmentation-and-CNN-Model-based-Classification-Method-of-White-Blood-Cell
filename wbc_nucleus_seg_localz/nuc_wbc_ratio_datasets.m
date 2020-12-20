clc;clear;format compact;warning off;

%% Database Name
databaseName = {'BCCD', 'JTSC', 'ALL-IDB2', 'CellaVision'};
folder_types = {'Input', 'Ground Truth'};
ds_folder_name = 'Datasets';

%% Input Dialogue
text_promp = sprintf('Enter Database Name\n(eg. BCCD, ALL-IDB2, JTSC or CellaVision)');
prompt = {text_promp};
dlgtitle = 'Input';
definput = {'BCCD'};
opts.Interpreter = 'tex';
opts.Resize = 'on';
answer = inputdlg(prompt,dlgtitle,[1 100],definput,opts);

%% Folder Name and creating the folder to save Cropped Image
if isempty(answer)
    warning_mess = sprintf('\nNo input is given\nPlease write one of the database name, shown below:\nBCCD, ALL-IDB2, JTSC, CellaVision.');
    error(warning_mess);  
end

for dbnv=1:length(databaseName)
    if isequal(databaseName{dbnv}, answer{:})
        break;
    end
    if dbnv==length(databaseName)
        warning_mess = sprintf('\nDatabase name not matched\nPlease write one of the database name, shown below:\nBCCD, ALL-IDB2, JTSC, CellaVision.');
        error(warning_mess);
    end
end

%% Read and estimates the WBC:nucleus of all Ground Truth (GT) Images for the input dataset
currDir = pwd;
gt_imgAddr = [currDir, '\', ds_folder_name, '\', folder_types{2}, '\', answer{:}];
D = dir(gt_imgAddr);  % or jpeg or whatever.
L_gt = {D(:).name}; % Store the name of all items returned in D.
M = {};

for index = 1:length(L_gt)
    baseFileName = D(index).name;
    [~, ~, extension] = fileparts(baseFileName);
    extension = upper(extension);
    switch lower(extension)
        case {'.png', '.bmp', '.jpg', '.jpeg', '.tif', '.avi'}
            % Allow only PNG, TIF, JPG, or BMP images
            M = [M baseFileName];
        otherwise
    end
end
L_gt = M'; CmdStrLen=0;

f = uifigure;
d = uiprogressdlg(f,'Title','Progressing...','Message','0','Cancelable','on');

ratio_wbc_nuc=zeros(length(L_gt),1);
%% Segmentation Processing for all images
for k=1:length(L_gt)
    gt_img = imread([gt_imgAddr, '\', L_gt{k}]);
    [~,~,chn] = size(gt_img);
    if(chn>1)
        gt_img=gt_img(:,:,1);
    end
%         figure; imshow(gt_img);

    gt_whl = double(gt_img>0);
%         figure; imshow(gt_whl);

    max_gt = max(gt_img(:));
    gt_nuc_img = double(gt_img==max_gt);
%         figure; imshow(gt_nuc_img);

    ratio_wbc_nuc(k,:) = sum(gt_whl)/sum(gt_nuc_img);
    
    if d.CancelRequested
        break
    end
    d.Value = k/length(L_gt);
    prog_perc = d.Value*100;
    d.Message = sprintf('Completed: %.2f%%', prog_perc);
end

close(d);
close(f);

if k==length(L_gt)
    fprintf('Completed\n');
else
    fprintf('Completed on only %d GT images\n', k);
end
