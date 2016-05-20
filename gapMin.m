% all vehicle positions passed in are only for the duration of the reaction
% time
function [minimum] = gapMin (fcw_vehicle_pos_x, fcw_vehicle_pos_y, subject_vehicle_pos_x, subject_vehicle_pos_y, intersection_number)

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

%change the y positions so that the distance is from front vehicle's rear
%bumber and the subject vehicle's front bumper
fcw_vehicle_pos_y = fcw_vehicle_pos_y - 0.5 * fcw_vehicle_length;
subject_vehicle_pos_y = subject_vehicle_pos_y + 0.5 * subject_vehicle_length;

%y is always increasing, x stays relatively small
distance = sqrt ((fcw_vehicle_pos_x - subject_vehicle_pos_x).^2 + (fcw_vehicle_pos_y - subject_vehicle_pos_y).^2);
minimum = min (distance);

end