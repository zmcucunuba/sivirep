% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cleaning_data.R
\name{format_fecha}
\alias{format_fecha}
\title{Formatear fechas}
\usage{
format_fecha(data_event, format_fecha = "\%AAAA-\%MM-\%DD", nombres_col = c())
}
\arguments{
\item{data_event}{Un data frame que contiene los datos
de un evento o enfermedad}

\item{format_fecha}{Un character (cadena de caracteres)
que contiene  el formato deseado de fecha}

\item{nombres_col}{Un character (cadena de caracteres) que
contiene los nombres de la columna a formatear}
}
\value{
Un data framecon los datos con las fechas formateadas
}
\description{
Función que da un formato específico a una fecha
}
\examples{
data_event <- import_data_event(2020, "DENGUE")
data_event <- format_fecha(data_event)
format_fecha(data_event = data_event,
             format_fecha = "\%AAAA-\%MM-\%DD",
             nombres_col = c("ini_sin", "fec_hos"))
}
