Manual de Usuario - Analizador de HTML
¿Qué hace este programa?
Este programa analiza documentos HTML (como los que se usan para crear páginas web) y los divide en sus partes más básicas. Es como tomar un texto y separarlo en palabras, signos de puntuación y espacios, pero para código HTML.

Requisitos para usar el programa:
Tener Java instalado en la computadora
Tener el programa "Analizador HTML"

Cómo usar el programa:
Paso 1: Preparar el archivo HTML a analizar
1. Abrir la carpeta "Analizador HTML"
2. Entra a la carpeta "src"
3. Abrir el archivo "entrada.html" con cualquier editor de texto.
4. Borra todo el contenido actual del archivo.
5. Copiar y pegar el código HTML que se quiere analizar.
6. Guardar y cerrar el archivo.

Paso 2: Ejecución
1. Abrir el programa.
2. Navegar a la carpeta llamada "Analizador HTML".
3. Ejecutar el programa con el siguiente comando:
java -cp classes analizador.Main
4. El programa procesará el archivo y mostrará un mensaje cuando termine.

Paso 3: Ver los resultados
1. Abrir la carpeta "Analizador HTML".
2. Entrar a la carpeta "output".
3. Abrir el archivo llamado "tokens.txt" con cualquier editor de texto.

En el archivo de resultado, cada linea representa una parte del HTML identificada:

Token: Tipo de elemento HTML encontrado.
Lexema: El texto exacto encontrado.
Línea: El número de línea donde se encontró.
Columna: La posición en la línea donde comienza.

Tipos de elementos que puede identificar
DOCTYPE
ETIQUETA_APERTURA
ETIQUTA_CIERRE
NOMBRE_ATRIBUTO
VALOR_ATRIBUTO
TEXTO
COMENTARIO
ENTIDAD_HTML
ERROR


Para analizar otro archivos HTML:

Analiza el primer archivo como se explicó anteriormente
Antes de analizar otro, puedes renombrar el archivo "tokens.txt" (por ejemplo a "resultado1.txt") para no perder los resultados
Edita nuevamente el archivo "entrada.html" con el nuevo contenido HTML
Ejecuta el programa otra vez


Ejemplo de ejecución:
1. Abrir "entrada.html"

2. Copiar y pegar loo siguiente:
<!DOCTYPE html>
<html>
<head>
  <title>Página de prueba</title>
</head>
<body>
  <h1>Hola mundo</h1>
</body>
</html>

3. Guardar el archivo.

4. Ejecutar con java -cp classes analizador.Main

5. Abrir "tokens-txt" para ver el resultado.