# TTPS-Ruby 2023 - Senra Ignacio - chqto 

## Requisitos 
    Ruby version: 3.2.2
    Rails version: 7.1.2

## Instrucciones para deployment local:

Una vez descargado el proyecto:

### instalar dependencias:
    bundler install

### Generar BD con datos pre-cargados del seeds:
    $rails db:migrate
    $rails db:seed

### Desplegar app:
    $rails server

Queda el server desplegado en: http://127.0.0.1:3000/

### Credenciales users pre-cargados:
    email: mailuser1@gmail.com, password: 123456
    email: mailuser2@gmail.com, password: 123456


## Librerías y gemas utilizadas:
 - SweetAlert2      para flash messages (cdn)
 - Bootstrap 5      para estilos
 - Bootstrap Icons  
 - sassc-rails      para Sass en Rails (dependencia  bootstrap)
 - Will_paginate    para paginado de listas de elementos
 - groupdate        para agrupar por dates
 - ransack          para búsqueda

 - attr_encrypted   para autenticación
 - Cancancan        para autorización
 - Bcrypt           para cifrado de contraseñas


## Pendientes:

 - Dropdown de Profile no pude hacerlo funcionar. Problemas con Bootstrap + Turbo por lo que averigué.

 - Corregir vista de Link.

 - Vistas de estadísticas.

 - Controladores de estadísticas.