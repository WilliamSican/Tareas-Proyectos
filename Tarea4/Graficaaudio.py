import numpy as np
import sounddevice as sd
import scipy.io.wavfile as wav
import matplotlib.pyplot as plt
import os


def grabar_audio(filename='audio.wav', fs=44100, duration=5):
    if os.path.isfile(filename):
        respuesta = input(
            'Ya existe un archivo de audio grabado (audio.wav). ¿Desea eliminarlo y grabar uno nuevo? (s/n): ')
        if respuesta.lower() == 's':
            os.remove(filename)
            print('Archivo anterior eliminado. Preparándose para grabar uno nuevo...')
        else:
            print('Se conservará el archivo existente.')
            return

    print('Comenzando la grabación...')
    audio = sd.rec(int(duration * fs), samplerate=fs, channels=1, dtype='int16')
    sd.wait()
    print('Grabación finalizada.')
    wav.write(filename, fs, audio)
    print('Archivo de audio guardado correctamente.')


def reproducir_audio(filename='audio.wav'):
    try:
        fs, data = wav.read(filename)
        sd.play(data, fs)
        sd.wait()
    except Exception as e:
        print(f'Error al reproducir el audio: {e}')


def graficar_audio(filename='audio.wav'):
    try:
        fs, data = wav.read(filename)
        tiempo = np.linspace(0, len(data) / fs, num=len(data))
        plt.plot(tiempo, data)
        plt.xlabel('Tiempo (s)')
        plt.ylabel('Amplitud')
        plt.title('Audio')
        plt.show()
    except Exception as e:
        print(f'Error al graficar el audio: {e}')


def graficar_densidad_espectral(filename='audio.wav'):
    try:
        print('Graficando espectro de frecuencia...')
        fs, audio = wav.read(filename)
        N = len(audio)
        f = np.linspace(0, fs / 2, N // 2 + 1)
        ventana = np.hanning(N)
        sxx = np.abs(np.fft.rfft(audio * ventana)) ** 2
        plt.plot(f, 10 * np.log10(sxx))
        plt.xlabel('Frecuencia (Hz)')
        plt.ylabel('Densidad espectral de potencia (dB/Hz)')
        plt.title('Espectro de frecuencia del audio grabado')
        plt.show()
    except Exception as e:
        print(f'Error al graficar la densidad espectral: {e}')


def menu():
    while True:
        print('\nSeleccione una opción:')
        print('1. Grabar')
        print('2. Reproducir')
        print('3. Graficar')
        print('4. Graficar densidad')
        print('5. Salir')

        opcion = input('Ingrese su elección: ')

        if opcion == '1':
            duracion = float(input('Ingrese la duración de la grabación en segundos: '))
            grabar_audio(duration=duracion)
        elif opcion == '2':
            reproducir_audio()
        elif opcion == '3':
            graficar_audio()
        elif opcion == '4':
            graficar_densidad_espectral()
        elif opcion == '5':
            print('Saliendo del programa...')
            break
        else:
            print('Opción no válida. Intente de nuevo.')


if __name__ == '__main__':
    menu()
