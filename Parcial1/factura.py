import os
import psycopg2

# Ruta de almacenamiento del archivo de texto
factura_path = "C:/Users/willy/Desktop/tareasproyectos2025/Parcial1/factura.txt"

# Conexión a la base de datos
conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password="shwilly",
    host="localhost",
    port="5432"
)
cursor = conn.cursor()

while True:
    persona = input("Ingrese su nombre: ")
    placa = input("Ingrese su número de placa: ")

    print("Precio de gasolina por galón:")
    print("1. Diésel a Q28.78")
    print("2. Regular a Q30.36")
    print("3. Súper a Q31.85")

    # Validar opción de gasolina
    while True:
        opc = input("¿Qué tipo de gasolina desea?: ")
        if opc == "1":
            precio = 28.78
            tipo = "Diésel"
            break
        elif opc == "2":
            precio = 30.36
            tipo = "Regular"
            break
        elif opc == "3":
            precio = 31.85
            tipo = "Súper"
            break
        else:
            print("Opción no válida. Intente nuevamente.")

    # Validar cantidad de galones
    while True:
        try:
            cantidad = float(input("¿Cuántos galones desea?: "))
            if cantidad > 0:
                break
            else:
                print("Error: Ingrese un número mayor a 0.")
        except ValueError:
            print("Error: Ingrese un número válido.")

    total = cantidad * precio
    print(f"Su total es: Q{total:.2f}\nFactura generada.\n")

    # Guardar factura en el archivo
    with open(factura_path, "a") as file:
        file.write("*************************\n")
        file.write(f"Nombre: {persona}\n")
        file.write(f"Número de placa: {placa}\n")
        file.write(f"Tipo de combustible: {tipo}\n")
        file.write(f"Cantidad de galones: {cantidad:.2f}\n")
        file.write(f"Precio por galón: Q{precio:.2f}\n")
        file.write(f"Total a pagar: Q{total:.2f}\n")
        file.write("** Gracias por su Compra **\n\n")
    print("Datos guardados en el archivo.")

    # Imprimir factura en consola con formato claro
    print("\n*************************")
    print(f"Nombre:          {persona}")
    print(f"Número de placa: {placa}")
    print(f"Tipo de combustible: {tipo}")
    print(f"Cantidad de galones: {cantidad:.2f}")
    print(f"Precio por galón:    Q {precio:.2f}")
    print(f"Total a pagar:       Q {total:.2f}")
    print("** Gracias por su Compra **\n")

    # Guardar en la base de datos
    try:
        cursor.execute("""
            INSERT INTO factura (Nombre, Numero_de_Placa, Combustible, Galones, Precio, Total)
            VALUES (%s, %s, %s, %s, %s, %s);
        """, (persona, placa, tipo, cantidad, precio, total))
        conn.commit()
        print("Datos guardados en la base de datos.")
    except Exception as e:
        print(f"Error al guardar en la base de datos: {e}")
        conn.rollback()

    # Preguntar si desea realizar otra compra
    continuar = input("¿Desea realizar otra compra? (s/n): ").lower()
    if continuar != 's':
        break

# Cerrar conexión a la base de datos
cursor.close()
conn.close()
