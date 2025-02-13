%comprueba si estamos en Matlab o Octave
if (exist('OCTAVE_VERSION','builtin')~=0)
  %estamos en octave
  pkg load signal;
end
%Menu principal
opcion = 0;
while opcion~=5
  %opcion = input('Seleccione una opcion:\n 1. Grabar audio\n 2. Reproducir audio\n 3. grabar audio\n 4. Salir\n');
  %Menu de opciones
  disp('Seleccione una opcion: ')
  disp('1. Grabar')
  disp('2. Reproducir')
  disp('3. Graficar')
  disp('4. Graficar densidad')
  disp('5. Salir')
  opcion = input('Ingrese su eleccion: ');
  switch opcion
    case 1
      %Grabacion de audio
      try
        % Verificar si el archivo "audio.wav" ya existe
        if exist('audio.wav', 'file') == 2
          disp('Ya existe un archivo de audio grabado (audio.wav).');
          respuesta = input('¿Desea eliminarlo y grabar uno nuevo? (s/n): ', 's');
          if lower(respuesta) == 's'
            delete('audio.wav'); % Eliminar el archivo existente
            disp('Archivo anterior eliminado. Preparándose para grabar uno nuevo...');
          else
            disp('Se conservará el archivo existente.');
          end
        end

        duracion = input('Ingrese la duracion de la grabacion en segundos: ');
        %configuraciones para la calidad
        Fs = 44100; %frecuencia de muestreo 44.1khz
        bits = 24; %profundidad de bits
        numChannels = 1; %canal estereo

        disp('Comenzando la grabacion...');
        recObj = audiorecorder(Fs, bits, numChannels);
        recordblocking(recObj, duracion);
        disp('Grabacion finalizada.');
        data = getaudiodata(recObj, 'double');
        audiowrite('audio.wav', data, Fs, 'BitsPerSample', bits);
        disp('Archivo de audio guardado correctamente.');
      catch
        disp('Error al grabar el audio');
      end
    case 2
      % Reproduccion de audio
      try
        [data, fs] = audioread('audio.wav');
        sound(data, fs);
      catch
        disp('Error al reproducir el audio');
      end
    case 3
      %Grafica del audio
      try
        [data, fs] = audioread('audio.wav');
        tiempo = linspace(0, length(data)/fs, length(data));
        plot(tiempo, data);
        xlabel('Tiempo (s)');
        ylabel('Amplitud');
        title('Audio');
      catch
        disp('Error al graficar el audio');
      end
    case 4
      %Graficando espectro de frecuencia
      try
        disp('Graficando espectro de Frecuencia...');
        [audio, Fs] = audioread('audio.wav');%lee el audio del archivo.wav
        N = length(audio); % numero de muestras de la se;al
        f = linspace(0, Fs/2, N/2+1); %vector de frecuencias
        ventana = hann(N); %ventana de Hann para reducir el efecto de las discontinuidades al calcular la FFT
        sxx = pwelch(audio, ventana, 0, N, Fs);% densidad expectral de potencia
        plot(f, 10*log10(sxx(1:N/2+1))); %grafica el espectro de frecuencia en dB
        xlabel('frecuencia (Hz)');
        ylabel('Densidad espectral de potencia (dB/Hz)');
        title('Espectro de frecuencia de el audio Grabado');
      catch
        disp('Error al graficar el audio.');
      end
    case 5
      %salir
      disp('Saliendo del programa...');
    otherwise
      disp('Opcion no valida');
    end
endwhile
