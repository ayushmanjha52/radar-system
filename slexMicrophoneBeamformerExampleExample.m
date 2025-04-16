%% Acoustic Beamforming Using Microphone Arrays
% This example shows how to beamform signals received by an array of
% microphones to extract a desired speech signal in a noisy environment.
% This Simulink(R) example is based on the MATLAB(R) example
% <docid:phased_ug.example-ex35950825 Acoustic Beamforming Using a Microphone Array> for System objects.

%   Copyright 2013-2017 The MathWorks, Inc.

%% Structure of the Model
%
% The model simulates the reception of three audio signals from different
% directions on a 10-element uniformly linear microphone array (ULA). After
% the addition of thermal noise at the receiver, beamforming is applied and
% the result played on a sound device.

modelname = 'slexMicrophoneBeamformerExample';
open_system(modelname);

%%
% The model consists of two stages: simulate the received audio signals and
% beamform the result. The blocks that corresponds to each stage of the
% model are:
%
% *Received audio simulation*
%
% * |Audio Sources| - Subsystem reads the audio files and specifies their
% direction.

open_system([modelname '/Audio Sources']);

%%
% * |From Multimedia File| - Part of the |Audio Sources| subsystem, each
% block reads audio from a different wav file, 1000 samples at a time.
% Three blocks labeled |source1|, |source2| and |source3| correspond to
% the three sources.
% * |Concatenate| - Concatenates the output of the three |From Multimedia
% File| blocks into a three column matrix, one column per audio signal.
% * |source angles| - |Constant| block specifies the incident directions of
% the audio sources to the |Wideband Rx Array| block. The block outputs a
% 2x3 matrix. The two rows correspond to the azimuth and elevation angles
% in degrees of each source, the three columns correspond to the three
% audio signals.
% * |Wideband Rx Array| - Simulates the audio signals received at the ULA.
% The first input port to this block is a 1000x3 matrix. Each column
% corresponds to the received samples of each audio signal. The second
% input port (Ang) specifies the incident direction of the pulses. The
% first row of Ang specifies the azimuth angle in degree for each signal
% and the second row specifies the elevation angle in degree for each
% signal. The second row is optional. If they are not specified, the elevation
% angles are assumed to be 0 degrees. The output of this block is a 1000x10
% matrix. Each column corresponds to the audio recorded at each element of
% the microphone array. The microphone array's configuration is specified
% in the |Sensor Array| tab of the block dialog panel. This configuration
% should match the configuration specified on the block dialog panel of the
% |Frost Beamformer|. See the <docid:phased_ug.example-ex37574528 Conventional and Adaptive Beamformers>
% Simulink example to learn how to use sensor array configuration
% variables for conveniently sharing the same configuration across several
% blocks.
%
% <<../MicSensorArrayTab.png>>
%
% * |Receiver Preamp| - Adds white noise to the received signals.
%
% *Beamforming*
%
% * |Select beamform angle| - |Constant| block controls the |Multi-Port
% Switch| output and specifies which of the three source directions in
% which to beamform.
% * |Frost Beamformer| - Performs Frost beamforming on the matrix passed
% via the input port |X| along the direction specified via the input port
% |Ang|.
% * |2-D Selector| - Selects the received signal at one of the microphone
% elements.
% * |Manual switch| - Switches between the non-beamformed and the
% beamformed audio stream sent to the audio device.

%% Exploring the Example 
%
% Click on the |Manual switch| while running the simulation to toggle
% between playing the non-beamformed audio stream and the beamformed
% stream. Setting a value of 1, 2, or 3 in the |Select beamform angle|
% block while running the simulation will beamform along one of the three
% audio signals direction. You will notice that the non-beamformed audio
% sounds garbled while you can clearly hear any one of the selected audio
% streams after beamforming.


%%
%

close_system(modelname, 0);
