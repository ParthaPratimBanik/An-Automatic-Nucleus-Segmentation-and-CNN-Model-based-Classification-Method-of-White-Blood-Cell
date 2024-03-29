%% Some Important Notes
% -input should be the name of database
% -eg. BCCD or ALL-IDB2 or JTSC or CellaVision

clc; clear;

%% Argument setting for nuclei_seg and crop_seg_wbc function
ClusrNo = 2;
disc_rad = [15, 3, 10, 5];
hwrTh = [1.5, 1.25, 1, 1.5];

%% Database Name
databaseName = {'BCCD', 'JTSC', 'ALL-IDB2', 'CellaVision'};

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

folderName = {[answer{:}, '_seg_cropped_img']};
if ~isdir(folderName{:})
    mkdir(folderName{:});
else
    fprintf('\nfolder %s already exists.', folderName{:});
end

%% loading database
load([answer{:},'.mat'])

%% input image taking from cell type mat file
in_img_cell = img_db_wbc(:,2);


%% Now cropped the input image of the input dataset and saved the cropped image to the directory 
for i=1:length(in_img_cell)
    %% Applying proposed nuclei segmentaion method
    seg_nuc_log = nuclei_seg(in_img_cell{i}, ClusrNo, disc_rad(dbnv));
%     imshow(seg_nuc_log);
    
    %% Applying proposed cropping method
    cropped_wbc = crop_seg_wbc(in_img_cell{i}, seg_nuc_log, hwrTh(dbnv));
    
    %% For Showing Cropped Images
%     if iscell(cropped_wbc)
%         for kk=1:length(cropped_wbc)
%             figure;
%             imshow(cropped_wbc{1,kk});
%         end
%     end
    
    %% For Saving immage
    if iscell(cropped_wbc)
        for kk=1:length(cropped_wbc)
            imgAddrWithName = strcat(folderName{:}, '/',...
                img_db_wbc{i,1}(1:end-4), '_', num2str(kk), '.png');
            imwrite(cropped_wbc{1,kk}, imgAddrWithName, 'png');
            fprintf('\n%d-%s--No. of WBC: %d--status: cropped and saved',i,img_db_wbc{i,1},kk);
        end
    end
end