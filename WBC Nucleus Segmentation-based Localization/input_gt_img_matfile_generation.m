clc; clear;

%% Database Name
data_base_name = {'BCCD', 'JTSC', 'ALL-IDB2', 'CellaVision'};
folder_types = {'Input', 'Ground Truth'};
ds_folder_name = 'Datasets';

%% Save input and GT image in mat files for each dataset
curr_dir = pwd;
for mm=1:length(data_base_name)
    img_db_wbc = cell(1,4);
    for kk=1:length(folder_types)
        img_folder_addr = [curr_dir,'\',ds_folder_name,'\',folder_types{kk},'\',data_base_name{mm}];
        img_dir_info = dir(img_folder_addr);
        all_file_names = {img_dir_info(:).name};
        img_idx = 0;
        for nn=1:length(all_file_names)
            base_file_name = img_dir_info(nn).name;
            [~, ~, extension] = fileparts(base_file_name);
            extension = upper(extension);
            switch lower(extension)
                case {'.jpg', '.jpeg', '.tif', '.png', '.bmp'}
                    img_idx = img_idx + 1;
                    img_mat = imread([img_folder_addr, '\', base_file_name]);
                    img_db_wbc{img_idx, ((kk-1)*2)+1} = base_file_name;
                    img_db_wbc{img_idx, ((kk-1)*2)+2} = img_mat;
                otherwise
            end
        end
    end
    save([data_base_name{mm},'.mat'], 'img_db_wbc');
    fprintf('\nDataset--%s: input and GT image saved in %s.mat file', data_base_name{mm}, data_base_name{mm});
end