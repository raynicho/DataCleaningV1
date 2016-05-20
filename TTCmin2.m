%% calculate TTCmin2 (velocity only), it gives time interval in seconds
function [TTCmin2_time] = TTCmin2 (fcw_vehicle_pos_x, fcw_vehicle_pos_y, subject_vehicle_pos_x, subject_vehicle_pos_y, fcw_velocity, sv_velocity, intersection_num)

% conversion factors
mileperhrToftpersec = 1.4667;
meterToft = 3.2803;
    
% car length needs to be subtracted from current distance in ft
switch intersection_num
        % peugeot_306
    case 36
        car_length = 14.73;
    otherwise
        car_length = 14.23;
end

% in feet
distance = sqrt ((fcw_vehicle_pos_x - subject_vehicle_pos_x).^2 + (fcw_vehicle_pos_y - subject_vehicle_pos_y).^2) - car_length;

% calculate the difference in the vehicles' current velocities and multiply
% by corresponding conversion factor
switch intersection_num
    % DDO is in ft/s
    case 24
        velocity_diff = sv_velocity(mileperhrToftpersec) - fcw_velocity;
    % ADOs are in m/s
    otherwise
        velocity_diff = sv_velocity(mileperhrToftpersec) - fcw_velocity(meterToft);
end

TTCmin2_time = distance/velocity_diff;

end