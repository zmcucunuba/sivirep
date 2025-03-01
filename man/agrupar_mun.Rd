% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checking_data.R
\name{agrupar_mun}
\alias{agrupar_mun}
\title{Agrupar por municipios y casos}
\usage{
agrupar_mun(
  data_event,
  dept_nombre = NULL,
  col_nombre = "cod_mun_o",
  porcentaje = FALSE
)
}
\arguments{
\item{data_event}{Un data frame que contiene los datos de la
enfermedad o evento}

\item{dept_nombre}{Un character (cadena de caracteres) que contiene
el nombre del departamento; su valor por defecto es NULL}

\item{col_nombre}{Un character (cadena de caracteres) con el nombre de
la columna en los datos de la enfermedad o evento que contiene los códigos
de municipios; su valor por defecto es cod_mun_o}

\item{porcentaje}{Un boolean (TRUE o FALSE) que indica si es necesario
agregar un porcentaje de casos como una columna; su valor por
defecto es FALSE}
}
\value{
Un data frame con los datos de la enfermedad o evento agrupados
por códigos de municipios y número de casos
}
\description{
Función que agrupa los datos de una enfermedad o evento por código
de municipios y número de casos
}
\examples{
data_event <- import_data_event(2019, "DENGUE")
data_event <- limpiar_encabezado(data_event)
agrupar_mun(data_event = data_event,
            dept_nombre = "Antioquia",
            col_nombre = "cod_mun_o",
            porcentaje = FALSE)
}
