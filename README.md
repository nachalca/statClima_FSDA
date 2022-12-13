

# Modelado de temperaturas extremas en Uruguay

Este repositorio contiene los principales resultados del proyecto *Modelado de temperaturas extremas en Uruguay* financiado por el Fondo Sectorial a partir de datos 2017 ANII (FSDA_1_2017_1_144032). Responsable del proyecto: [Ignacio Alverez-Castro](https://nachalca.netlify.app)).

Una aplicación interactiva con resultados se presenta [IESTA-INUMET](http://164.73.240.157:3838/IESTA-INUMET/). 


### Métodos Estadísticos

Se utilizan modelos lineales dinámicos para modelar series diarias de temperatura en el largo plazo. El resultado es una serie completta *estimada* de la señal de temperatura (mínima y máxima) para cada día en varias estaciones meteorológias de Uruguay. 

<details><summary>Código</summary>
<p>

Los códigos de `R` se pueden encontrar en :
[*Rcode*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Rcode)

Un reporte más detallado de la metodología utilizada se presenta en: 
[*Documento*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Doc_trabajo/ddt_fsdclima.pdf)

Definición y caracterización de olas de temperatura: [*Olas*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Doc_trabajo/inumet_feb19.pdf)

Poster para Jornadas de Sociedad Uruguaya de Estadística: 
[*Poster*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Doc_trabajo/sue_poster.pdf)

</p>
</details>

### Datos: Series completas de temperatura

Series diarias de temperatura imputadas para 11 estaciones de Uruugay.  

<details><summary>Base de datos </summary>
<p>
Variables:        
- location: Estación meteorológica (caracter)     
- year: Año, de 1950 y 2013 (entero)      
- day2: Día del año, de 1 a 366 (numérica)      
- tipo: Indica si corresponde a temperatura mínima o máxima (caracter)      
- temp: valor de la señal de temperatura estimada     

Los datos se encuentran en: [*Series*](https://github.com/nachalca/statClima_FSDA/tree/master/series_completas)

</p>
</details>

### Taller: "Métodos Estadísticos para el Análisis de Datos Meteorológicos"


Taller realizado en conjunto entre el Instituto de Estadística de la Facultad de Ciencias Económicas y de Administración (IESTA-FCEA-UdelaR) y el Instituto Uruguayo de Meteorología (INUMET) el 15 de Noviembre del 2019 de 9:30 a 18:00 hs en INUMET.


<details><summary> Charlas Invitadas: </summary>
<p>

**1. 9:30-945 Dra. Madeleine Renom: Presentación workshop**

+ [CVuy, Madeleine Renom](https://exportcvuy.anii.org.uy/CvEstatico/?urlId=984149b8e6cf25749c4c91f1a38eb5d71200be0a41732b976cb5dfdc2c682de465a660d01f1d82426edd914b48e61875bd1fc87293a3698a1b61093f2c1a3fd9&formato=pdf&convocatoria=21)

+ [*Presentación*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Presentaciones/Renom.pdf)

**2. 9:45-10:45   Dra. Matilde Rusticucci: "Manejo de la información en escala climática"**

+ [*Presentación*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Presentaciones/RusticucciMTVTnov19.pdf)

**3. 11:00-11:30 Lic. Juan Badagian: "Uso de datos hidrometeorológicos en la Represa de Salto Grande"**

+ [*Presentación*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Presentaciones/Badagian.pdf)

**4. 11:30-11:50 Lic. Matilde Ungerovich: "Eventos extremos de precipitación en el sur de Uruguay”.**

+ [*Presentación*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Presentaciones/Ungerovich.pdf)

**5. 11.50-12.10 Dr. Fernando Arismendi: “Corrección de sesgos en los pronósticos estacionales de NMME”**

+ [*Presentación*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Presentaciones/Arismendi.pdf)

**6. 13:30-14:30 Dr. Andrés Farrall: "Inteligencia Artificial para la Detección de Errores en Datos  Meteorológicos"**

+ [*Presentación*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Presentaciones/Farral.pdf)

**7. 14:30-15:30 Ignacio Alvarez-Castro, Santiago de Mello: "Proyecto FSD, Modelado de temperatura diaria en Uruguay"**

+ [CVuy, Ignacio Alvarez-Castro](https://exportcvuy.anii.org.uy/cv/?f8ed8bf31a8041cecdc5153aa486b483b9dbc92eeec87a4f1008faea2f447fa1523b92127db5289ff92636af02a3d61fe89cfcc30ee8fbff78e0a87462d69388)

+ [*Presentación*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Presentaciones/Alvarez_DeMello.pdf) 

**8. 16:00-16:30  Dr. Leonardo Moreno: "Dependencia de extremos en datos climáticos"**

+ [CVuy, Leonardo Moreno](https://exportcvuy.anii.org.uy/cv/?2d5d41c5ca1e94af67ef8876f4fdbc74cfcd1f7333b41f52ed5663869f97fb923d02a1403c78e825e483d902c787d7a63b78b49a3dd1695fa91af3a68f0303c6)

+ [*Presentación*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Presentaciones/Moreno.pdf)

**9. 16:30-17:00 Mg. Florencia Santiñaque: "Análisis estadístico de las precipitaciones anuales extremas en Uruguay"**

+ [CVuy, Florencia Santiñaque](https://exportcvuy.anii.org.uy/cv/?a5d3ded130c493d8c91724e5f975dd94209ac169cb564fd3bcff3495fc189cd660545b94f9ddb8e961df00c63518e5cb8386b5e87f03186ed0adb8ff4d3124ea)

+ [*Presentación*](https://github.com/nachalca/taller_statClima_FSDA/blob/master/Presentaciones/Santiñaque.pdf)

</p>
</details>



