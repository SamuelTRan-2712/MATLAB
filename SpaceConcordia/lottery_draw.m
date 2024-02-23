% Define amount of attendees
x = 140;
% Check if the attendees array exists in the workspace
if ~exist('attendees', 'var')
    % If it doesn't exist, create it
    attendees = 1:x;
end
% Specify the desired number of random selections
desiredSelection = fix(x/8);
% Generate x/8 unique random numbers from the current attendees array
if length(attendees) >= desiredSelection
    randomNumbers = randperm(length(attendees), desiredSelection);
else
    % Reset to the initial state of the attendees array
    disp('Numbers drawn:');
    disp(attendees);
    attendees = 1:x;
    % If the array size is less than the desired selection, select all numbers
    disp('All numbers have been selected.');
    return;
end
% Display the current attendees array and the random numbers to be removed
%disp('Current attendees array:');
%disp(attendees);
disp('Numbers drawn:');
disp(attendees(randomNumbers));
% Remove the random numbers from the current attendees array
attendees = setdiff(attendees, attendees(randomNumbers));
% Display the modified attendees array after removal
%disp('Modified attendees array after removal:');
%disp(attendees);
