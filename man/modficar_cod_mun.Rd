% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{modficar_cod_mun}
\alias{modficar_cod_mun}
\title{Establecer códigos geográficos de los datos de la enfermedad o evento}
\usage{
modficar_cod_mun(code_dept, cod_mun)
}
\arguments{
\item{code_dept}{Un numeric (numerico) que contiene el código del
departamento}

\item{cod_mun}{Un numeric (numerico) que contiene el código del municipio}
}
\value{
Un data frame con los códigos geográficos
}
\description{
Función que establece los códigos geográficos de los datos de la enfermedad
o evento
}
\examples{
modficar_cod_mun(code_dept = 01, cod_mun = "001")
}
