function cost = costFunction(x, mdl)
    assignin('base', 'Kp', x(1));
    assignin('base', 'Ki', x(2));
    assignin('base', 'Kd', 0);

    simOut = sim(mdl, 'SimulationMode', 'normal', 'StopTime', '10', ...
                 'SaveOutput', 'on', 'OutputSaveName', 'simout', ...
                 'SaveTime', 'on', 'TimeSaveName', 'tout');

    % Eğer simout bir timeseries ise:
    speed = simOut.simout.Data;
    time = simOut.simout.Time;

    error = speed; % hedef = 0
    cost = trapz(time, error.^2);
end
