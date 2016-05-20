% all variables are assumed to be over the duration of the reaction time
% subject acceleration is in feet/sec*sec
% subject velocity is in mph
function [minimum] = TTCmin1 (subject_acceleration, subject_velocity, subject_position_y, subject_position_x, fcw_position_y, fcw_position_x, intersection_number)

minimum = 0;

% find the size displacement between the vehicles
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
%bumper and the subject vehicle's front bumper
fcw_position_y = fcw_position_y - 0.5 * fcw_vehicle_length;
subject_position_y = subject_position_y + 0.5 * subject_vehicle_length;

%y is always increasing, x stays relatively small
distance = sqrt ((fcw_position_x - subject_position_x).^2 + (fcw_position_y - subject_position_y).^2);

% calculate the vector of TTC
accel_is_zero = (subject_acceleration == 0);
accel_is_non_zero = ~accel_is_zero;

TTC = zeros (length (accel_is_zero));
TTC_plus_half = TTC;
TTC_minus_half = TTC;
TTC (accel_is_zero) = distance (accel_is_zero)./subject_velocity (accel_is_zero);

TTC_plus_half (accel_is_non_zero) = (-subject_velocity (accel_is_non_zero) + sqrt (subject_velocity (accel_is_non_zero).^2 - 4 * 0.5 * subject_acceleration (accel_is_non_zero) * (- distance (accel_is_non_zero))))./(2*subject_acceleration(accel_is_non_zero));
TTC_minus_half (accel_is_non_zero) = (-subject_velocity (accel_is_non_zero) - sqrt (subject_velocity (accel_is_non_zero).^2 - 4 * 0.5 * subject_acceleration (accel_is_non_zero) * (- distance (accel_is_non_zero))))./(2*subject_acceleration(accel_is_non_zero));

if TTC_plus_half (accel_is_non_zero) > TTC_minus_half (accel_is_non_zero)
    TTC (accel_is_non_zero) = TTC_plus_half (accel_is_non_zero); 
else
    TTC (accel_is_non_zero) = TTC_minus_half (accel_is_non_zero);
end

% find the min
minimum = min (TTC);

end