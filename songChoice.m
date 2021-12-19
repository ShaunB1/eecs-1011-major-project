function [choice] = songChoice(choice)
amongus = ["C2", "C5", "Eb5", "F5", "Gb5", "F5", "Eb5", "C5", "Bb4", "Eb5", "C5"];
ussr = ["G4" "C5" "G4" "A5" "B5" "E4" "E4" "A4" "G4" "F4" "G4" "C4" "C4" "D4" "D4" "E4" "F4" "F4" "G5" "G4" "A5" "B5" "C6" "D6"];
riverflows = ["A4", "Db5", "A5", "Ab5", "A5", "Ab5", "A5", "E4", "A5", "D4", "Db4", "D4", "E4", "Db4", "B4"];
rickroll = ["Bb4", "C5", "Db5", "Bb4", "F5", "F5","Eb5", "Bb4", "C5", "Db4", "C5", "Eb5", "Eb5", "Db5", "C5", "Bb4", "Bb4", "C5", "Db5", "Bb4", "Db5", "Db5", "Eb5", "C5", "Bb4", "Ab4", "F4", "Eb5", "Db5"];
mariotheme = ["E5", "E5", "E5", "C5", "E5", "G5", "G4", "C5", "G4", "E4", "A4", "B4", "Bb4", "A4", "G4", "E5", "G5", "A5", "F5", "G5", "E5", "C5", "D5", "B4"];
furelise = ["A4" "Ab4" "A4" "Ab4" "A4" "E4" "G4" "F4" "D4" "F3" "A3" "D4" "E4" "A3" "Db4" "E4" "F4"];

% Song Options
if choice == 1
    choice = amongus;
elseif choice == 2
    choice = ussr;
elseif choice == 3
    choice = riverflows;
elseif choice == 4
    choice = rickroll;
elseif choice == 5
    choice = mariotheme;
elseif choice == 6
    choice = furelise;
else
    choice = ["A4", "F4"];
end

end