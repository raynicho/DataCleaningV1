% all vehicle positions passed in are only for the duration of the reaction
% time
function [minimum] = gapMin (fcw_vehicle_pos_x, fcw_vehicle_pos_y, subject_vehicle_pos_x, subject_vehicle_pos_y, intersection_number) %#ok<STOUT,*INUSD>

% ford taurus
subject_vehicle_length = 16.46;

% get the size of the FCW vehicle
switch intersection_number
    % peugeot_306
    case 36
        fcw_vehicle_length = 13;
    % windstar, deville, and towncar are 12 ft long
    otherwise
        fcw_vehicle_length = 12.0;
        
end


end