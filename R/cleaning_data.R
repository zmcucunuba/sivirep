#' Estandarizar códigos geográficos de los datos de una enfermedad o evento
#'
#' Función que estandariza los códigos geográficos de los datos
#' de una enfermedad o evento
#' @param data_event Un data frame que contiene los datos de una
#' enfermedad o evento
#' @return Un data frame que contiene los códigos geográficos estandarizados
#' de los datos de una enfermedad o evento
#' @examples
#' data_event <- import_data_event(2019, "DENGUE")
#' data_event <- limpiar_encabezado(data_event)
#' estandarizar_geo_cods(data_event = data_event)
#' @export
estandarizar_geo_cods <- function(data_event) {
  geo_columns <- config::get(file =
                               system.file("extdata", "config.yml",
                                           package = "sivirep"),
                             "geo_column_names")
  for (column in geo_columns) {
    if (stringr::str_detect(column, "dpto") == TRUE) {
      data_event[[column]] <- formatC(data_event[[column]],
                                      width = 2,
                                      format = "d",
                                      flag = "0")
    }
    if (stringr::str_detect(column, "mun") == TRUE) {
      data_event[[column]] <- formatC(data_event[[column]],
                                      width = 3,
                                      format = "d",
                                      flag = "0")
    }
  }
  return(data_event)
}

#' Limpiar códigos de departamento de los datos de una
#' enfermedad o evento
#'
#' Función que limpia los códigos de departamento de los datos
#' de una enfermedad o evento
#' @param depto_cods Un data frame que contiene los códigos de
#' departamento
#' @param data_event Un data frame que contiene los datos de una
#' enfermedad o evento
#' @param agrupar Un boolean (TRUE o FALSE) que indica si es
#' necesario agrupar por códigos de departamento y números de casos
#' @return Un data framecon los códigos de departamento
#' limpios de los datos de una enfermedad o evento
#' @examples
#' geo_cods <- import_geo_cods()
#' depto_cods <- obtener_cods_dpto(geo_cods)
#' data_event <- import_data_event(2019, "DENGUE")
#' data_event <- limpiar_encabezado(data_event)
#' data_agrupada <- agrupar_cols_casos(data_event,
#'                                     "cod_dpto_o",
#'                                     agr_porcentaje = TRUE)
#' limpiar_cods_event_dpto(depto_cods = depto_cods,
#'                         data_event = data_agrupada,
#'                         agrupar = TRUE)
#' @export
limpiar_cods_event_dpto <- function(depto_cods,
                                    data_event,
                                    agrupar = TRUE) {
  depto_cods$id <- as.character(depto_cods$cod_dep)
  data_event$id <- as.character(data_event$cod_dpto_o)
  data_event_clean <- data_event
  if (agrupar) {
    data_event_clean <- data_event %>%
      dplyr::group_by(.data$id) %>%
      dplyr::summarise(casos = sum(.data$casos))
  }
  return(data_event_clean)
}

#' Limpiar códigos de departamento de los datos
#' de una enfermedad o evento
#'
#' Función que limpia los códigos de departamento de los datos
#' de una enfermedad o evento
#' @param data_event Un data frame que contiene los datos de
#' una enfermedad o evento
#' @param col_cods_data Un character (cadena de caracteres) que
#' contiene el nombre de la columna en los datos
#' de una enfermedad o evento que contiene los códigos de departamento
#' @param geo_data Datos geográficos que incluyen los códigos de
#' departamento
#' @param col_geo_cods Un character (cadena de caracteres) con
#' el nombre de la columna en los datos geográficos
#' que contiene los códigos de departamento
#' @return Un data framecon los códigos de departamento limpios
#' de los datos de una enfermedad o evento
#' @examples
#' geo_codes <- import_geo_cods()
#' data_event <- import_data_event(2019, "DENGUE")
#' data_event <- limpiar_encabezado(data_event)
#' limpiar_cods_dpto(data_event = data_event,
#'                   col_cods_data = "cod_dpto_o",
#'                   geo_data = geo_codes,
#'                   col_geo_cods = "codigo_departamento")
#' @export
limpiar_cods_dpto <- function(data_event,
                              col_cods_data,
                              geo_data,
                              col_geo_cods) {
  col_detps_geo <- eval(parse(text = paste0("geo_data$", col_geo_cods)))
  col_detps_geo <- as.character(col_detps_geo)
  data_event_clean <- data_event
  col_detps_data <- eval(parse(text =
                                 paste0("data_event_clean$", col_cods_data)))
  col_detps_data <- as.character(col_detps_data)
  col_detps_data[
    nchar(col_detps_data) < 2 & col_detps_data != "1" & col_detps_data != "0" &
      paste("0", col_detps_data, sep = "") %in% col_detps_geo
  ] <- paste("0", col_detps_data[
    nchar(col_detps_data) < 2 & col_detps_data != "1" & col_detps_data != "0" &
      paste("0", col_detps_data, sep = "") %in% col_detps_geo
  ], sep = "")
  col_detps_data[col_detps_data == "1"
                 & paste("1", col_detps_data, sep = "")
                 %in% col_detps_geo] <- "11"
  return(data_event_clean)
}

#' Convertir edad a años
#'
#' Función que convierte las edades en años según las unidades de medida del
#' SIVIGILA
#' @param data_event Un data frame que contiene los datos de una
#' enfermedad o evento
#' @param col_edad Un character (cadena de caracteres) con el nombre
#' de la columna en los datos de una enfermedad o evento que
#' contiene las edades; su valor por defecto es edad
#' @param col_uni_med Un character (cadena de caracteres) con el nombre
#' de la columna en los datos de una enfermedad o evento que contiene
#' las unidades de medida; su valor por defecto es uni_med
#' @return Un data framecon las edades en años según las unidades de medida
#' del SIVIGILA
#' @examples
#' data_event <- import_data_event(2019, "DENGUE")
#' data_event <- limpiar_encabezado(data_event)
#' convert_edad(data_event = data_event,
#'              col_edad = "edad",
#'              col_uni_med = "uni_med")
#' @export
convert_edad <- function(data_event,
                         col_edad = "edad",
                         col_uni_med = "uni_med") {
  data_event_years <-
    dplyr::mutate(data_event,
                  edad =
                  dplyr::case_when(eval(parse(text = col_uni_med)) == 1 ~
                                     round(eval(parse(text = col_edad)), 3),
                                   eval(parse(text = col_uni_med)) == 2 ~
                                     round((eval(parse(text =
                                                         col_edad)) / 12), 3),
                                   eval(parse(text = col_uni_med)) == 3 ~
                                     round((eval(parse(text =
                                                         col_edad)) / 876), 3),
                                   eval(parse(text = col_uni_med)) == 4 ~
                                     round((eval(parse(text =
                                                         col_edad)) / 525960),
                                           3),
                                   eval(parse(text = col_uni_med)) == 5 ~
                                     round((eval(parse(text =
                                                         col_edad)) / 3.156e+7),
                                           3)))
  return(data_event_years)
}

#' Eliminar valores NIN (NA, Infinito, NaN)
#'
#' Función que elimina filas si los valores de la columna seleccionada
#' incluyen NA, Infinito o NaN
#' @param data_event Un data frame que contiene los datos de una
#' enfermedad o evento
#' @param nom_col Un character (cadena de caracteres) que contiene el
#' nombre de la columna en los datos de una enfermedad o evento a evaluar
#' @return Los datos limpios sin valores NA, Infinito o NaN
#' @examples
#' data_event <- import_data_event(2019, "DENGUE")
#' data_event <- limpiar_encabezado(data_event)
#' remove_val_nin(data_event = data_event, nom_col = "edad")
#' @export
remove_val_nin <- function(data_event, nom_col) {
  ref_col <- paste0("data_event$", nom_col)
  data_event_del <- data_event
  del_rows <-
    which(ifelse(is.na(eval(parse(text = ref_col))), TRUE,
                 ifelse(is.nan(eval(parse(text = ref_col))), TRUE,
                        is.infinite(eval(parse(text = ref_col))))))
  if (length(del_rows) > 0) data_event_del <- data_event[-del_rows]
  return(data_event_del)
}

#' Eliminar fechas mayores que el valor de comparación
#'
#' Función que elimina fechas mayores que el valor de comparación
#' @param data_event Un data frame que contiene los datos de
#' una enfermedad o evento
#' @param col_ini Un character (cadena de caracteres) que contiene
#' el nombre de la columna de la fecha inicial;
#' su valor por defecto es ini_sin
#' @param col_comp Un character (cadena de caracteres) que contiene el
#' nombre de la columna de la fecha de comparación;
#' su valor por defecto es fec_hos
#' @return Un data framecon los datos sin las fechas mayores que el
#' valor de comparación
#' @examples
#' data_event <- import_data_event(2019, "DENGUE")
#' data_event <- limpiar_encabezado(data_event)
#' remove_error_fecha(data_event = data_event,
#'                    col_ini = "ini_sin",
#'                    col_comp = "fec_hos")
#' @export
remove_error_fecha <- function(data_event,
                               col_ini = "ini_sin",
                               col_comp = "fec_hos") {
  ref_col_ini <- paste0("data_event$", col_ini)
  ref_col_comp <- paste0("data_event$", col_comp)
  del_rows <- which(ref_col_comp <= ref_col_ini)
  data_event_del <- data_event[-del_rows]
  return(data_event_del)
}

#' Formatear fechas
#'
#' Función que da un formato específico a una fecha
#' @param data_event Un data frame que contiene los datos
#' de un evento o enfermedad
#' @param format_fecha Un character (cadena de caracteres)
#' que contiene  el formato deseado de fecha
#' @param nombres_col Un character (cadena de caracteres) que
#' contiene los nombres de la columna a formatear
#' @return Un data framecon los datos con las fechas formateadas
#' @examples
#' data_event <- import_data_event(2020, "DENGUE")
#' data_event <- format_fecha(data_event)
#' format_fecha(data_event = data_event,
#'              format_fecha = "%AAAA-%MM-%DD",
#'              nombres_col = c("ini_sin", "fec_hos"))
#' @export
format_fecha <- function(data_event,
                         format_fecha = "%AAAA-%MM-%DD",
                         nombres_col = c()) {
  data_event_limp <- data_event
  for (name in nombres_col) {
    if (!is.null(name)) {
      ref_col <- eval(parse(text = paste0("data_event_limp$", name)))
      ref_col <- as.Date(ref_col, format = format_fecha)
    }
  }
  return(data_event_limp)
}

#' Limpiar las etiquetas del encabezado de los datos de una enfermedad
#'
#' Función que limpia las etiquetas del encabezado de los datos
#' de una enfermedad o evento
#' @param data_event Un data frame que contiene los datos de una
#' enfermedad o evento
#' @return Un data framecon las etiquetas del encabezado formateadas
#' con guión bajo (_)
#' @examples
#' data_event <- import_data_event(2019, "DENGUE")
#' limpiar_encabezado(data_event = data_event)
#' @export
limpiar_encabezado <- function(data_event) {
  names(data_event) <- epitrix::clean_labels(names(data_event))
  return(data_event)
}

#' Limpiar fechas de los datos de una enfermedad o evento
#'
#' Función que limpia las fechas de los datos de una enfermedad o evento
#' @param data_event Un data frame que contiene los datos de
#' una enfermedad o evento
#' @param year Un numeric (numerico) que contiene el año de los datos
#' de una enfermedad o evento
#' @param format_fecha Un character (cadena de caracteres) que contiene
#' el formato deseado de fecha; su valor por defecto es "\%AAAA-\%MM-\%DD"
#' @param nombre_col Un character (cadena de caracteres) que contiene
#' el nombre de la columna del conjunto de datos
#' @param col_comp Un character (cadena de caracteres) que contiene el
#' nombre de la columna de comparación del conjunto de datos
#' @return Un data framecon los datos con las fechas limpias
#' @examples
#' data_event <- import_data_event(2020, "DENGUE")
#' data_event <- limpiar_encabezado(data_event)
#' limpiar_fecha_event(data_event = data_event,
#'                     year = 2020,
#'                     format_fecha = "%AAAA-%MM-%DD",
#'                     nombre_col = "ini_sin",
#'                     col_comp = "fec_hos")
#' @export
limpiar_fecha_event <- function(data_event,
                                year,
                                format_fecha = "%AAAA-%MM-%DD",
                                nombre_col = "ini_sin",
                                col_comp = NULL) {
  data_event_fecha_ini <- data_event
  if (!is.null(col_comp)) {
    data_event_fecha_ini <-
      remove_error_fecha(data_event_fecha_ini,
                         nombre_col,
                         col_comp)
  }
  data_event_fecha_ini[order(eval(parse(text =
                                          paste0("data_event_fecha_ini$",
                                                 nombre_col))),
                             decreasing = TRUE), ]
  data_event_fecha_ini <- data_event_fecha_ini[format(eval(
    parse(text = paste0("data_event_fecha_ini$", nombre_col))
  ), "%Y") == year, ]
  return(data_event_fecha_ini)
}

#' Limpiar las edades de los datos de una enfermedad o evento
#'
#' Función que limpia las edades de los datos de una enfermedad o evento
#' @param data_event Un data frame que contiene los datos de una
#' enfermedad o evento
#' @param nombre_col Un character (cadena de caracteres) con el nombre
#' de la columna de los datos que contiene las edades;
#' su valor por defecto es edad
#' @return Un data framecon los datos de una enfermedad o evento
#' con las edades limpias
#' @examples
#' data_event <- import_data_event(2020, "DENGUE")
#' data_event <- limpiar_encabezado(data_event)
#' limpiar_edad_event(data_event = data_event, nombre_col = "edad")
#' @export
limpiar_edad_event <- function(data_event, nombre_col = "edad") {
  data_event_years <- convert_edad(data_event)
  data_event_years <- remove_val_nin(data_event_years, nombre_col)
}

#' Limpiar los valores atipicos de los datos
#'
#' Función que limpia los valores atipicos de los datos de una
#' enfermedad o evento del SIVIGILA
#' @param data_event Un data frame que contiene los datos de una
#' enfermedad o evento
#' @return Un data framecon los datos de una enfermedad o
#' evento con los valores atípicos limpios (NA)
#' @examples
#' data_event <- import_data_event(2020, "DENGUE")
#' data_event <- limpiar_encabezado(data_event = data_event)
#' @export
limpiar_val_atipic <- function(data_event) {
  cols_events <- config::get(file =
                               system.file("extdata",
                                           "config.yml",
                                           package = "sivirep"),
                             "diseases_exceptions")
  cod_event <- data_event$cod_eve[1]
  if (cod_event > 0) {
    for (event in cols_events) {
      code <- names(event)
      if (cod_event %in% code) {
        cols <- event[as.character(cod_event)]
        for (nom_cols in cols) {
          for (col in nom_cols) {
            data_event[eval(parse(text = col))] <- NA
          }
        }
      }
    }
  }
}

#' Limpiar datos de SIVIGILA
#'
#' Función que limpia los datos seleccionados de una enfermedad o evento de
#' la fuente de SIVIGILA
#' @param data_event Un data frame que contiene los datos de
#' una enfermedad o evento
#' @param year Un numeric (numerico) que contiene el año de los
#' datos de una enfermedad o evento
#' @return Un data framecon los datos limpios de la enfermedad o evento
#' @examples
#' year <- 2019
#' data_event <- import_data_event(year, "DENGUE")
#' limpiar_data_sivigila(data_event = data_event, year = year)
#' @export
limpiar_data_sivigila <- function(data_event, year) {
  data_event <- limpiar_encabezado(data_event)
  data_event <- limpiar_edad_event(data_event)
  nom_cols_fechas <- config::get(file = system.file("extdata",
                                                    "config.yml",
                                                    package = "sivirep"),
                                 "dates_column_names")
  data_event_limp <- format_fecha(data_event,
                                  nombres_col = nom_cols_fechas)
  data_event_limp <- limpiar_fecha_event(data_event_limp, year,
                                         nombre_col = nom_cols_fechas[3],
                                         col_comp = nom_cols_fechas[4])
  data_event_limp <- limpiar_fecha_event(data_event_limp, year,
                                         nombre_col = nom_cols_fechas[2])
  data_event_limp <- estandarizar_geo_cods(data_event_limp)
  data_event_limp <- convert_edad(data_event_limp,
                                  col_edad = "edad",
                                  col_uni_med = "uni_med")
  return(data_event_limp)
}
