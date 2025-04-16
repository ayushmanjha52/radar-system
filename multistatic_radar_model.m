% Create a new Simulink Model
model_name = 'multistatic_radar_model';
new_system(model_name);
open_system(model_name);

% Define block positions
x_start = 50;
y_start = 50;
block_width = 100;
block_height = 50;
x_gap = 150;
y_gap = 100;

% Add Transmitter Block (Use Sine Wave as Placeholder)
add_block('simulink/Sources/Sine Wave', [model_name, '/Tx_Waveform'], ...
    'Position', [x_start, y_start, x_start + block_width, y_start + block_height]);

% Add Target Blocks
add_block('phased/Target', [model_name, '/Target1'], ...
    'Position', [x_start + 2*x_gap, y_start, x_start + 2*x_gap + block_width, y_start + block_height]);

add_block('phased/Target', [model_name, '/Target2'], ...
    'Position', [x_start + 2*x_gap, y_start + y_gap, x_start + 2*x_gap + block_width, y_start + y_gap + block_height]);

% Add Free Space Propagation Blocks
add_block('phased/Free Space', [model_name, '/Free_Space1'], ...
    'Position', [x_start + 3*x_gap, y_start, x_start + 3*x_gap + block_width, y_start + block_height]);

add_block('phased/Free Space', [model_name, '/Free_Space2'], ...
    'Position', [x_start + 3*x_gap, y_start + y_gap, x_start + 3*x_gap + block_width, y_start + y_gap + block_height]);

% Add Receiver Blocks
add_block('phased/Radar Receiver', [model_name, '/Receiver1'], ...
    'Position', [x_start + 4*x_gap, y_start, x_start + 4*x_gap + block_width, y_start + block_height]);

add_block('phased/Radar Receiver', [model_name, '/Receiver2'], ...
    'Position', [x_start + 4*x_gap, y_start + y_gap, x_start + 4*x_gap + block_width, y_start + y_gap + block_height]);

% Add Signal Processing Block
add_block('phased/Range Doppler Response', [model_name, '/Signal_Processing'], ...
    'Position', [x_start + 5*x_gap, y_start + y_gap/2, x_start + 5*x_gap + block_width, y_start + y_gap/2 + block_height]);

% Connect Blocks
add_line(model_name, 'Tx_Waveform/1', 'Target1/1');
add_line(model_name, 'Tx_Waveform/1', 'Target2/1');
add_line(model_name, 'Target1/1', 'Free_Space1/1');
add_line(model_name, 'Target2/1', 'Free_Space2/1');
add_line(model_name, 'Free_Space1/1', 'Receiver1/1');
add_line(model_name, 'Free_Space2/1', 'Receiver2/1');
add_line(model_name, 'Receiver1/1', 'Signal_Processing/1');
add_line(model_name, 'Receiver2/1', 'Signal_Processing/2');

% Save and Open the Model
save_system(model_name);
disp('Multistatic radar model created successfully!');