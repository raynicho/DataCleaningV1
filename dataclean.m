%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data cleaning script for Hyundai experiment, May 2016.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NOTE: in data, column 4 is the intersection counter, 11 is the brake
% force, 14 is the FCW state, 59 is the accelerator position.

xiswrite('cleaned_data.xlsx', {'Gender', 'Age', 'Subject', 'Block', 'Intersection', 'RT', 'Crashed?', 'Gap', 'TTC min1', 'TTC min2', 'Distracting RT'});
currentWritePosition = 2;

for i=1:40
    filename = xlsread('names.xlsx',strcat('A',num2str(i),':','A',num2str(i)));
    info_beginning = {filename(1), filename(2), filename(1:3), filename(4)};
    data = xlsread(filename);
    %% find the start and end frames of the four needed intersections, and the start frames of the response times
    intersection9 = find(data(:,4) == 9);
    intersection24 = find(data(:,4) == 24);
    intersection34 = find(data(:,4) == 34);
    intersection36 = find(data(:,4) == 36);
    
    intersection9_RT_start = -1;
    intersection24_RT_start = -1;
    intersection34_RT_start = -1;
    intersection36_RT_start = -1;
    
    for j = intersection9
        if data(j,14) == 1
            intersection9_RT_start = data(j,14);
            break;
         end
    end
    
    for j = intersection24
        if data(j,14) == 1
            intersection24_RT_start = data(j,14);
            break;
         end
    end
    
    for j = intersection34
        if data(j,14) == 1
            intersection34_RT_start = data(j,14);
            break;
         end
    end
    
    for j = intersection36
        if data(j,14) == 1
            intersection36_RT_start = data(j,14);
            break;
         end
    end
   
    %% calculate the end frames of the response times for the intersections 
    intersection9_RT_end = -1;
    intersection24_RT_end = -1;
    intersection34_RT_end = -1;
    intersection36_RT_end = -1;
    % brake pedal force is at column 11 of the excel spreadsheet,
    % accelerator pedal position is at column 59.
    
    % Case 1: both accelerator position, brake force are 0.
    if data(intersection9_RT_start, 11) == 0 && data(intersection9_RT_start, 59) == 0
        for j = intersection9_RT_start:intersection9(end)
            if data(j,59) ~= 0
                intersection9_RT_end = data(j,59);
                break;
            end
        end
    % Case 2: non-zero accelerator; zero brake force
    elseif data(intersection9_RT_start, 11) == 0 && data(intersection9_RT_start, 59) ~= 0
        for j = intersection9_RT_start:intersection9(end)
            if data(j, 59) <= (data(intersection9_RT_start, 59) * 0.95)
                intersection9_RT_end = data(j,59);
                break;
            end
        end
    % Case 4: non-zero brake force; zero accelerator
    else
        for j = intersection9_RT_start:intersection9(end)
            if data(j, 59) >= (data(intersection9_RT_start, 59) * 1.05)
                intersection9_RT_end = data(j,59);
                break;
            end
        end
    end
    
    
    
    
    
    

    
end

    
    
    
    
