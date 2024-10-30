# Cargar los datos 

data <- read.csv("C:\\Users\\pedro\\OneDrive\\Escritorio\\Intro to Stats in R\\2015_TICEMPRESAS_BDD.csv", 
                 fileEncoding = "latin1", header = TRUE)

head(data)
str(data)

data[is.na(data)] <- 0

# Filtrar las columnas relevantes
data_filtrada <- data[, c("tic1_inversion", "tic2_valor_inversion", "tic41_personal_comp_m", "tic42_personal_comp_h", "tic61_personal_int_m", "tic62_personal_int_h")]

data_filtrada$inversion_total <- ifelse(!is.na(data_filtrada$tic1_inversion), data_filtrada$tic1_inversion, data_filtrada$tic2_valor_inversion)

# Análisis descriptivo para el personal capacitado por género
summary(data_filtrada[c("tic41_personal_comp_m", "tic42_personal_comp_h")])

# Análisis descriptivo para el personal con acceso a internet por género
summary(data_filtrada[c("tic61_personal_int_m", "tic62_personal_int_h")])


library(ggplot2)

# Sumar el total de personal capacitado en computadoras y el total con acceso a internet por género
total_capacitadas_mujeres <- sum(data_filtrada$tic41_personal_comp_m, na.rm = TRUE)
total_capacitados_hombres <- sum(data_filtrada$tic42_personal_comp_h, na.rm = TRUE)

total_acceso_internet_mujeres <- sum(data_filtrada$tic61_personal_int_m, na.rm = TRUE)
total_acceso_internet_hombres <- sum(data_filtrada$tic62_personal_int_h, na.rm = TRUE)

# Crear un dataframe con los datos resumidos
data_resumida <- data.frame(
  Categoria = c("Capacitadas en Computadoras", "Capacitadas en Computadoras", 
                "Acceso a Internet", "Acceso a Internet"),
  Genero = c("Mujeres", "Hombres", "Mujeres", "Hombres"),
  Total = c(total_capacitadas_mujeres, total_capacitados_hombres,
            total_acceso_internet_mujeres, total_acceso_internet_hombres)
)

# Gráfico comparativo de personal capacitado en computadoras y personal con acceso a internet
ggplot(data_resumida, aes(x = Categoria, y = Total, fill = Genero)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparación de Mujeres y Hombres en Capacitación y Acceso a Internet",
       x = "Categoría", y = "Total") +
  scale_fill_manual(name = "Género", values = c("Mujeres" = "pink", "Hombres" = "blue"))

# Linear regression model for IT training
model_training <- lm((tic41_personal_comp_m + tic42_personal_comp_h) ~ inversion_total, data = data_filtrada)

# Linear regression model for Internet access
model_internet <- lm((tic61_personal_int_m + tic62_personal_int_h) ~ inversion_total, data = data_filtrada)

# Model summaries
summary(model_training)
summary(model_internet)
