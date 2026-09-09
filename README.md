# README

# Sistema de Procesamiento de Boletas con IA (Ruby on Rails 8)

Aplicación web desarrollada con Ruby on Rails 8 que permite subir boletas o facturas (PDF o imágenes), extraer su información clave automáticamente utilizando Google Gemini AI, pre-cargar un formulario de verificación para el usuario, y almacenar de forma segura los datos y archivos en una base de datos Supabase PostgreSQL mediante ActiveStorage.

El sistema deberia poder permitir al usuario ingresar una boleta, luego este rescata los datos de esta y deberia permitirle al usuario poder editar estos antes de guardarla, recien cuando el usuario presione guardar boleta este guarda la los datos de esta en la base de datos en supabase. Finalmente luego de que los datos se guarden en la base de datos estos se ven reflejados en una lista.

## Pasos que se hicieron para construir el proyecto:

1. instalar ruby y rails
2. crear el proyecto base mediante comandos: rails new boletas_app -d postgresql 
3. crear la conexion a base de datos mediante la creacion del archivo .env y comandos rails generate scaffold Boleta rut_emisor:string razon_social:string folio:string fecha_emision:date monto_total:integer y db:migrate
4. crear el servicio 
5. crear el controlador
6. editar las vistas predeterminadas

## Consultas hechas a la inteligencia artificial para construir el proyecto: 
1. contruccion del proyecto base: "buenas tardes gemini, necesito que me entregues el codigo para crear un proyecto base con las siguientes tecnologias: 
• Backend en Ruby on Rails.
• Procesamiento de PDF e imágenes con OCR cuando sea necesario.
• Integración con OpenAI o Gemini para procesar y estructurar el texto.
• Guardar la información extraída en PostgreSQL.
ademas, necesito que me indiques los comandos de instalacion de estas herramientas, tomando en cuenta que utilizo una mac m3"
2. manejo de errores: "tengo el siguiente error, te adjunto el error y el texto de salida que me imprimio la terminal"

## Pasos a seguir para echar a andar el proyecto:
1. clonar el repositorio 
2. abrir la terminal en el visual studio code o en la carpeta contenedora del sistema
3. arrancar el servidor: rails server
4. aceptar invitacion a participar en el proyecto de supabase enviada (esto permitira vigilar la base de datos, dentro de esta hay una tabla llamada boletas en la cual )


## Requisitos Técnicos

- Ruby: 3.3.6 (o superior)
- Rails: 8.1.3.1
- Base de Datos: Supabase (PostgreSQL)
- API Key: Google AI Studio (Gemini)

---


