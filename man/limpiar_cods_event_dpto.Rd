% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cleaning_data.R
\name{limpiar_cods_event_dpto}
\alias{limpiar_cods_event_dpto}
\title{Limpiar códigos de departamento de los datos de una
enfermedad o evento}
\usage{
limpiar_cods_event_dpto(depto_cods, data_event, agrupar = TRUE)
}
\arguments{
\item{depto_cods}{Un data frame que contiene los códigos de
departamento}

\item{data_event}{Un data frame que contiene los datos de una
enfermedad o evento}

\item{agrupar}{Un boolean (TRUE o FALSE) que indica si es
necesario agrupar por códigos de departamento y números de casos}
}
\value{
Un data framecon los códigos de departamento
limpios de los datos de una enfermedad o evento
}
\description{
Función que limpia los códigos de departamento de los datos
de una enfermedad o evento
}
\examples{
geo_cods <- import_geo_cods()
depto_cods <- obtener_cods_dpto(geo_cods)
data_event <- import_data_event(2019, "DENGUE")
data_event <- limpiar_encabezado(data_event)
data_agrupada <- agrupar_cols_casos(data_event,
                                    "cod_dpto_o",
                                    agr_porcentaje = TRUE)
limpiar_cods_event_dpto(depto_cods = depto_cods,
                        data_event = data_agrupada,
                        agrupar = TRUE)
}
