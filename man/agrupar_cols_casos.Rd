% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checking_data.R
\name{agrupar_cols_casos}
\alias{agrupar_cols_casos}
\title{Agrupar por columnas y casos}
\usage{
agrupar_cols_casos(data_event, cols_nombres, agr_porcentaje = FALSE)

agrupar_cols_casos(data_event, cols_nombres, agr_porcentaje = FALSE)
}
\arguments{
\item{data_event}{Un data frame que contiene los datos
de la enfermedad o evento}

\item{cols_nombres}{Un character (cadena de caracteres) o
array (arreglo) de character que contiene el nombre de
la(s) columna(s) por la(s) que se desea agrupar los datos}

\item{agr_porcentaje}{Un boolean (TRUE o FALSE) que indica si
es necesario agregar un porcentaje de casos como una columna;
su valor por defecto es FALSE}
}
\value{
Un data frame con los datos de una enfermedad
o evento agrupados por el nombre de la(s) columna(s) y el
número de casos; su valor por defecto es TRUE

Un data frame con los datos de una enfermedad
o evento agrupados por nombre de columna(s) y número de casos
}
\description{
Función que agrupa los datos de una enfermedad o evento
por nombre de columna(s) y número de casos

Función que agrupa los datos de una enfermedad o evento
por un nombre de columna(s) específico y número de casos
}
\examples{
data_event <- import_data_event(2019, "DENGUE")
data_event <- limpiar_encabezado(data_event)
agrupar_cols_casos(data_event = data_event,
                   cols_nombres = "sexo",
                   agr_porcentaje = TRUE)
agrupar_cols_casos(data_event = data_event,
                   cols_nombres = c("sexo", "semana"))
data_event <- import_data_event(2019, "DENGUE")
data_event <- limpiar_encabezado(data_event)
agrupar_cols_casos(data_event = data_event,
                   cols_nombres = "sexo",
                   agr_porcentaje = TRUE)
agrupar_cols_casos(data_event = data_event,
                   cols_nombres = c("sexo", "semana"))
}
